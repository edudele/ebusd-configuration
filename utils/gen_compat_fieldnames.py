#!/usr/bin/env python3
"""Genera utils/compat_fieldnames.json comparando, con el propio ebusd, el CSV del repo antiguo y el compilado.

Uso (los volcados se obtienen sin tocar el bus):
  ebusd -f -n -d 127.0.0.1:1 --checkconfig --dumpconfig=json --dumpconfigto=dump_old.json -c <repo_antiguo/latest/en>
  ebusd -f -n -d 127.0.0.1:1 --checkconfig --dumpconfig=json --dumpconfigto=dump_new.json -c outcsv/@ebusd/ebus-typespec
  utils/gen_compat_fieldnames.py dump_old.json dump_new.json > utils/compat_fieldnames.json

Para cada mensaje comun con el mismo numero de campos publicables, anota la posicion y el nombre del campo antiguo cuando
difiere del nuevo: nombre vacio (tipos base sin nombre), mayusculas originales. Los nombres duplicados del antiguo
(p. ej. Status01: temp1,temp1,...) no se tocan: se mantienen los nombres unicos del nuevo (mismo entity_id en HA).
"""
import json, sys, collections
CIRCS = {'basv0', 'hmu00', 'broadcast'}
# El repo antiguo no publicaba estos mensajes en HA (campo sin nombre + tipo HTI/HTM no casa con type_switch); se mantienen
# con `value` para no perder las entidades text (reloj, vacaciones, legionela) que existen en el repo nuevo.
KEEP_VALUE = {'time', 'hwcholidaystarttime', 'hwcholidayendtime', 'z1holidaystarttime', 'z1holidayendtime', 'hwclegionellatime'}
FILES = {'vaillant/15.basv0.csv', 'vaillant/08.hmu00.csv', 'vaillant/broadcast.csv'}
def load(path, onlyfiles):
    out = {}
    for m in json.load(open(path))['messages']:
        c = m['circuit'].lower()
        if c not in CIRCS or (onlyfiles and m.get('filename') not in FILES): continue   # nuevo: solo los 3 ficheros del dispositivo (no bass*/ctlv*); antiguo: tambien los .inc incluidos
        d = 'u' if m.get('passive') else ('w' if m.get('write') else 'r')
        out[(c, m['name'].lower(), d)] = (m['name'], [f['name'] for f in m['fielddefs'] if not f.get('isignored')])
    return out
old, new = load(sys.argv[1], False), load(sys.argv[2], True)
table = collections.OrderedDict()
for k, (name, o) in sorted(old.items()):
    if k not in new: continue
    nname, n = new[k]
    if k[1] in KEEP_VALUE: continue
    if len(o) != len(n) or not o: continue
    cnt = collections.Counter(x.lower() for x in o)
    fix = {}
    for i, (a, b) in enumerate(zip(o, n)):
        if a == b: continue
        if a != '' and cnt[a.lower()] > 1: continue          # nombre duplicado en el antiguo: se conserva el unico del nuevo
        if a == '' and cnt[''] > 1: continue
        fix[str(i)] = a
    if fix:
        table[f'{k[0]}|{nname}|{k[2]}'] = fix
json.dump(table, sys.stdout, indent=1, ensure_ascii=False)
