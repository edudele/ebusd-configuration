#!/usr/bin/env python3
"""Post-proceso de la compilacion: aplica utils/compat_fieldnames.json a los CSV generados.

El emisor TypeSpec escribe siempre el nombre del campo en minusculas y no admite nombres vacios; el repo antiguo
usaba nombre vacio para los tipos base sin nombre (entity_id de HA sin sufijo) y mayusculas originales. Esta tabla
(generada con utils/gen_compat_fieldnames.py comparando el volcado de ebusd de ambos repos) restituye esos nombres para
que los entity_id/unique_id de Home Assistant no cambien al actualizar.
Uso: apply_compat_fieldnames.py <dir_outcsv>   (p. ej. outcsv/@ebusd/ebus-typespec)
"""
import csv, io, json, os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
FILES = {'basv0': 'vaillant/15.basv0.csv', 'hmu00': 'vaillant/08.hmu00.csv', 'broadcast': 'vaillant/broadcast.csv'}
def run(root, check=False):
    table = json.load(open(os.path.join(HERE, 'compat_fieldnames.json'), encoding='utf-8'))
    changed = 0
    for circ, rel in FILES.items():
        path = os.path.join(root, rel)
        if not os.path.exists(path): continue
        raw = open(path, 'rb').read().decode('utf-8')
        eol = '\r\n' if '\r\n' in raw else '\n'
        rows = list(csv.reader(io.StringIO(raw, newline=''), delimiter=',', quotechar='"'))
        sel = {k.split('|', 1)[1]: v for k, v in table.items() if k.split('|', 1)[0] == circ}
        for r in rows:
            if len(r) < 12 or not r[0] or r[0][0] in '#*' or r[0] == 'type': continue
            d = r[0][0]
            if d not in 'rwu': continue
            key = r[3].lower() + '|' + d
            hit = None
            for k, v in sel.items():
                if k.lower() == (r[3] + '|' + d).lower(): hit = v; break
            if not hit: continue
            pos = 0
            i = 9
            while i + 2 < len(r):
                ign = r[i] == 'ign' or r[i + 2].startswith('IGN') or (r[i].startswith('ign') and r[i + 2].startswith('IGN'))
                if not ign:
                    if str(pos) in hit and r[i] != hit[str(pos)]:
                        r[i] = hit[str(pos)]; changed += 1
                    pos += 1
                i += 6
        out = io.StringIO(newline='')
        csv.writer(out, delimiter=',', quotechar='"', lineterminator=eol).writerows(rows)
        new = out.getvalue()
        if not check and new != raw:
            open(path, 'wb').write(new.encode('utf-8'))
    return changed
def scan_lowercase(root):
    """vaillant/scan.csv: el repo antiguo usa circuito 'scan' y mensaje 'id' en minusculas. Con 'Scan'/'Id' ebusd publica
    el circuito 'Scan.08' ademas del 'scan.08' interno y Home Assistant crea dispositivos y entidades duplicados."""
    path = os.path.join(root, 'vaillant', 'scan.csv')
    if not os.path.exists(path): return 0
    raw = open(path, 'rb').read().decode('utf-8')
    new = raw.replace('\nr,Scan,,Id,', '\nr,scan,,id,').replace('\r\nr,Scan,,Id,', '\r\nr,scan,,id,')
    if new != raw: open(path, 'wb').write(new.encode('utf-8'))
    return int(new != raw)

def link_outputs(root):
    """Replica en la salida los enlaces simbolicos de src (misma convencion que utils/copylink.sh): cada
    15.<x>.tsp -> 15.basv0.tsp pasa a 15.<x>.csv -> 15.basv0.csv (ya con los nombres de campo compat aplicados).
    El circuito lo toma ebusd del nombre de fichero, igual que en el repo antiguo (bass0, basv1, ctlv2...)."""
    src = os.path.join(HERE, '..', 'src')
    made = 0
    for dp, dn, fn in os.walk(src):
        for f in fn:
            lp = os.path.join(dp, f)
            if not (os.path.islink(lp) and f.endswith('.tsp')): continue
            tgt = os.path.realpath(lp)
            if not os.path.isfile(tgt): continue
            rl = os.path.relpath(lp, src)[:-4] + '.csv'
            rt = os.path.relpath(tgt, src)[:-4] + '.csv'
            dest, real = os.path.join(root, rl), os.path.join(root, rt)
            if not os.path.exists(real): continue
            want = os.path.relpath(real, os.path.dirname(dest))
            if os.path.islink(dest) and os.readlink(dest) == want: continue
            if os.path.lexists(dest): os.remove(dest)
            os.symlink(want, dest); made += 1
    return made

if __name__ == '__main__':
    n = run(sys.argv[1], check=len(sys.argv) > 2 and sys.argv[2] == '--check')
    print(f'compat_fieldnames: {n} nombres de campo ajustados')
    if not (len(sys.argv) > 2 and sys.argv[2] == '--check'):
        print(f'scan.csv en minusculas: {scan_lowercase(sys.argv[1])}')
        print(f'enlaces simbolicos creados: {link_outputs(sys.argv[1])}')
