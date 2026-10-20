#!/usr/bin/env python3
"""Publica por MQTT las estadisticas de bus de ebusd con descubrimiento de Home Assistant.

Se ejecuta cada minuto desde /etc/cron.d/ebusd_bus_stats y toma 4 lecturas, una cada 15 s. Solo lee:
- ebusctl info (contadores internos del demonio, no toca el bus)
- el log crudo de ebusd (solo las lineas nuevas desde la lectura anterior)
Credenciales MQTT: se leen del entorno del contenedor ebusd y se pasan a mosquitto_pub por entorno.
"""
import fcntl, json, os, re, subprocess, sys, time
from datetime import datetime

EBUSD = 'ebusd-latest'
STATE_TOPIC = 'ebusd/busstats'
AVAIL_TOPIC = 'ebusd/global/running'
RAWLOG = '/docker/ebusd/logs/ebusd_raw.log'
STATE_FILE = '/var/lib/ebusd_bus_stats.json'
DISC_MARK = '/run/ebusd_bus_stats.disc'
DISC_EVERY = 3600
SAMPLES = 4
INTERVAL = 15
LOCK = '/run/ebusd_bus_stats.lock'

# clave json, linea de ebusctl info, nombre, unidad, device_class
INFO_SENSORS = [
    ('symbol_rate', 'symbol rate', 'bus symbol rate', 'sym/s', None),
    ('max_symbol_rate', 'max symbol rate', 'bus max symbol rate', 'sym/s', None),
    ('min_arbitration', 'min arbitration micros', 'bus min arbitration', 'µs', 'duration'),
    ('max_arbitration', 'max arbitration micros', 'bus max arbitration', 'µs', 'duration'),
    ('min_symbol_latency', 'min symbol latency', 'bus min symbol latency', 'ms', 'duration'),
    ('max_symbol_latency', 'max symbol latency', 'bus max symbol latency', 'ms', 'duration'),
]
# clave json, nombre, unidad, device_class, state_class
EXTRA_SENSORS = [
    ('latency_peak_at', 'bus last latency peak', None, 'timestamp', None),
    ('stray_bytes', 'bus stray bytes', 'bytes', None, 'total_increasing'),
    ('unanswered', 'bus unanswered requests', 'req', None, 'total_increasing'),
    ('nak', 'bus nak', 'req', None, 'total_increasing'),
]


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, timeout=20, **kw)


def mqtt_env():
    out = {}
    for var, key in (('MQTT_U', 'EBUSD_MQTTUSER'), ('MQTT_P', 'EBUSD_MQTTPASS')):
        r = run(['docker', 'exec', EBUSD, 'printenv', key])
        out[var] = r.stdout.strip()
    return out


def publish(env, topic, payload, retain=False):
    cmd = ['docker', 'exec', '-e', 'MQTT_U', '-e', 'MQTT_P', 'mosquitto', 'sh', '-c',
           'mosquitto_pub -h localhost -u "$MQTT_U" -P "$MQTT_P" -t "$0" -m "$1"' + (' -r' if retain else ''),
           topic, payload]
    return run(cmd, env={**os.environ, **env})


def load_state():
    try:
        with open(STATE_FILE) as f:
            return json.load(f)
    except (OSError, ValueError):
        return {'offset': os.path.getsize(RAWLOG) if os.path.exists(RAWLOG) else 0,
                'stray_bytes': 0, 'unanswered': 0, 'nak': 0,
                'last_max_latency': None, 'latency_peak_at': None}


def save_state(state):
    tmp = STATE_FILE + '.tmp'
    with open(tmp, 'w') as f:
        json.dump(state, f)
    os.replace(tmp, STATE_FILE)


def count_log(state):
    """Cuenta lineas nuevas del log crudo: bytes sueltos, peticiones nuestras sin respuesta y NAK."""
    try:
        size = os.path.getsize(RAWLOG)
    except OSError:
        return
    if size < state['offset']:  # ebusd reinicio o rotacion del log
        state['offset'] = 0
    if size == state['offset']:
        return
    with open(RAWLOG, 'rb') as f:
        f.seek(state['offset'])
        data = f.read(size - state['offset'])
    end = data.rfind(b'\n') + 1  # solo lineas completas
    for line in data[:end].decode(errors='replace').splitlines():
        m = re.match(r'\S+ \S+ ([<>])([0-9a-f]*)(.*)$', line)
        if not m:
            continue
        direction, head, rest = m.groups()
        if direction == '<':
            if 0 < len(head) <= 2 and not rest:
                state['stray_bytes'] += 1
        else:
            if not rest.startswith('<'):
                state['unanswered'] += 1
            elif rest.startswith('<ff'):
                state['nak'] += 1
    state['offset'] += end


def sample(env, state):
    r = run(['docker', 'exec', EBUSD, 'ebusctl', 'info'])
    if r.returncode != 0:
        return False
    values = {}
    for key, line, *_ in INFO_SENSORS:
        m = re.search(r'^%s: *(-?\d+)' % re.escape(line), r.stdout, re.M)
        if m:
            values[key] = int(m.group(1))
    if not values:
        return False
    lat = values.get('max_symbol_latency')
    if lat is not None:
        last = state.get('last_max_latency')
        if last is not None and lat > last:
            state['latency_peak_at'] = datetime.now().astimezone().replace(microsecond=0).isoformat()
        state['last_max_latency'] = lat  # si baja, ebusd se reinicio: nueva referencia
    count_log(state)
    values.update({k: state[k] for k in ('stray_bytes', 'unanswered', 'nak', 'latency_peak_at')})
    publish(env, STATE_TOPIC, json.dumps(values))
    save_state(state)
    return True


def discovery(env):
    if os.path.exists(DISC_MARK) and time.time() - os.path.getmtime(DISC_MARK) < DISC_EVERY:
        return
    device = {'identifiers': ['ebusd'], 'name': 'ebusd', 'manufacturer': 'ebusd.eu'}
    entries = [(k, n, u, d, 'measurement') for k, _, n, u, d in INFO_SENSORS] + EXTRA_SENSORS
    for key, name, unit, dclass, sclass in entries:
        tpl = '{{ value_json.%s }}' % key
        if key == 'latency_peak_at':
            tpl = '{{ value_json.latency_peak_at if value_json.latency_peak_at else none }}'
        cfg = {
            'unique_id': 'ebusd_busstats_' + key,
            'name': name,
            'state_topic': STATE_TOPIC,
            'value_template': tpl,
            'availability_topic': AVAIL_TOPIC,
            'payload_available': 'true',
            'payload_not_available': 'false',
            'entity_category': 'diagnostic',
            'device': device,
        }
        if unit:
            cfg['unit_of_measurement'] = unit
        if dclass:
            cfg['device_class'] = dclass
        if sclass:
            cfg['state_class'] = sclass
        publish(env, 'homeassistant/sensor/ebusd_busstats_%s/config' % key, json.dumps(cfg), retain=True)
    open(DISC_MARK, 'w').close()


def main():
    lock = open(LOCK, 'w')
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        return 0
    env = mqtt_env()
    state = load_state()
    for i in range(SAMPLES):
        start = time.time()
        sample(env, state)
        if i == 0:
            discovery(env)
        if i < SAMPLES - 1:
            time.sleep(max(0, INTERVAL - (time.time() - start)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
