# tools

Herramientas del host que acompañan a la configuración de ebusd. No forman parte de la
compilación TypeSpec (`src/` → `outcsv/`).

## ebusd_bus_stats.py: salud del bus eBUS en Home Assistant

Publica por MQTT, con descubrimiento de Home Assistant, estadísticas del bus para ver si
está sufriendo (latencia, arbitraje, tramas perdidas). Los sensores aparecen en el
dispositivo **ebusd** (`mqtt` / identificador `ebusd`, el mismo de `running`, `signal` y `uptime`).

**Solo lee, no escribe en el bus.** Usa dos fuentes:

- `ebusctl info` (contadores internos del demonio; no envía nada al bus).
- Las líneas nuevas del log crudo `logs/ebusd_raw.log` (solo lo escrito desde la lectura anterior).

### Sensores

Todas las entidades llevan el prefijo del área (`sensor.heating_ebusd_bus_...`) y categoría `diagnostic`.

| Entidad | Origen | Qué es |
|---|---|---|
| `..._bus_symbol_rate` | `ebusctl info` | Símbolos/s ahora (instantáneo, es el único que se mueve) |
| `..._bus_max_symbol_rate` | `ebusctl info` | Máximo de símbolos/s desde el arranque de ebusd |
| `..._bus_min_arbitration` / `..._max_arbitration` | `ebusctl info` | Arbitraje mín/máx en µs desde el arranque |
| `..._bus_min_symbol_latency` / `..._max_symbol_latency` | `ebusctl info` | Latencia de símbolo mín/máx en ms desde el arranque |
| `..._bus_last_latency_peak` | derivado | Hora del último récord de `max_symbol_latency` (timestamp) |
| `..._bus_stray_bytes` | log crudo | Líneas del log con un solo byte (~700/h de base; sube con perturbaciones) |
| `..._bus_unanswered_requests` | log crudo | Peticiones nuestras (`>`) sin respuesta (~1/h de base) |
| `..._bus_nak` | log crudo | Peticiones nuestras respondidas con NAK (0 normal) |

Los mínimos y máximos son **acumulados desde el arranque de ebusd**: solo cambian cuando hay un
récord nuevo, así que verlos quietos durante horas es lo normal. Los tres últimos son contadores
(`total_increasing`): para verlos por hora se usan sus estadísticas o un `utility_meter`.

### Funcionamiento

- Cron cada minuto; cada ejecución toma **4 lecturas separadas 15 s**. Un bloqueo (`/run/ebusd_bus_stats.lock`) evita solapes.
- Estado persistente en `/var/lib/ebusd_bus_stats.json`: posición leída del log, contadores y referencia del pico.
  Si el log se trunca (reinicio de ebusd) se relee desde el principio y los contadores siguen sumando.
  Si `max_symbol_latency` baja es que ebusd se reinició: se toma como nueva referencia sin marcar pico.
- Topic de estado: `ebusd/busstats` (JSON). Disponibilidad: `ebusd/global/running`.
- Descubrimiento: `homeassistant/sensor/ebusd_busstats_<clave>/config`, retenido y republicado cada hora
  (marca en `/run/ebusd_bus_stats.disc`).
- Credenciales MQTT: se leen en cada ejecución del entorno del contenedor `ebusd-latest`
  (`EBUSD_MQTTUSER`, `EBUSD_MQTTPASS`) y se pasan a `mosquitto_pub` (contenedor `mosquitto`) por entorno,
  sin escribirlas en disco ni en argumentos.

### Instalación

Está en el **host**, no en un contenedor, así que no se pierde al recrear contenedores.

```bash
sudo cp tools/ebusd_bus_stats.cron /etc/cron.d/ebusd_bus_stats
sudo chmod 644 /etc/cron.d/ebusd_bus_stats
```

Requisitos: `python3`, `docker` y `cron` en el host; contenedores llamados `ebusd-latest` y `mosquitto`.
Si se renombran, hay que cambiar `EBUSD` y el nombre `mosquitto` en `publish()` del script.
La ruta del log crudo (`RAWLOG`) debe coincidir con `EBUSD_LOGRAWDATAFILE` de ebusd.

Si se reinstala el host, basta con restaurar el repositorio y copiar el fichero `.cron`. El primer arranque
sin `/var/lib/ebusd_bus_stats.json` empieza los contadores en 0 y sin pico registrado.

### Dashboard

Los sensores están en el dashboard `lovelace`, vista AEROTERMIA, tarjeta "Estado Aerotermia", sección
**Demonio** (los de bus) y **Adaptador** (los del adaptador, `ebusd_adaptador_*`, que publica el propio
adaptador por MQTT).

### Comprobar y depurar

```bash
python3 tools/ebusd_bus_stats.py          # ejecuta ahora (devuelve al instante si ya hay otra en marcha)
cat /var/lib/ebusd_bus_stats.json         # estado y contadores
docker exec ebusd-latest ebusctl info     # la fuente de los contadores del demonio
```

Para empezar de cero los contadores del log, borrar `/var/lib/ebusd_bus_stats.json`.
