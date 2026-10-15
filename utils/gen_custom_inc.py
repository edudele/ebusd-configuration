#!/usr/bin/env python3
"""Genera src/vaillant/b555sched_inc.tsp (BASV0, programas horarios) y
src/vaillant/b516stat_inc.tsp (HMU00, estadisticas de energia) a partir de las
lineas CSV validadas en el bus (b555 en 15.basv0.csv, b516 en 08.hmu00.csv).
Uso: gen_custom_inc.py 15.basv0.csv 08.hmu00.csv"""
import csv, sys, os

HEAD = '''import "@ebusd/ebus-typespec";
import "./_templates.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

'''
DAYS = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

def lines(path, pb):
    for r in csv.reader(open(path, encoding="utf-8")):
        if len(r) > 8 and r[7] == pb and r[0] in ("r", "w"):
            yield r

def ext(idhex, nbase):
    b = bytes.fromhex(idhex)[nbase:]
    return ", ".join("0x%02x" % x for x in b)

def doc(c):
    return "  /** %s */\n" % c.replace("*/", "* /")

def b555(path):
    sigs = {
     "ign,,IGN:1,,,,mon,,UCH,,,,tue,,UCH,,,,wed,,UCH,,,,thu,,UCH,,,,fri,,UCH,,,,sat,,UCH,,,,sun,,UCH,,,,ign_1,,IGN:1,,,": "count",
     "ign,,IGN:1,,,,from,,HTM,,,,to,,HTM,,,,temp,,UIN,10,°C,": "slot_t",
     "ign,,IGN:1,,,,from,,HTM,,,,to,,HTM,,,,ign_1,,IGN:2,,,": "slot_n",
     "slotindex,,UCH,,,,slotcount,,UCH,,,,from,,HTM,,,,to,,HTM,,,,const,,HEX:2,=ffff,,,result,s,UCH,,,": "set_n",
     "slotindex,,UCH,,,,slotcount,,UCH,,,,from,,HTM,,,,to,,HTM,,,,temp,,UIN,10,°C,,result,s,UCH,,,": "set_t",
    }
    body = {
     "count": "    @maxLength(1) ign: IGN;\n    mon: UCH;\n    tue: UCH;\n    wed: UCH;\n    thu: UCH;\n    fri: UCH;\n    sat: UCH;\n    sun: UCH;\n    @maxLength(1) ign_1: IGN;\n",
     "slot_t": "    @maxLength(1) ign: IGN;\n    from: HTM;\n    to: HTM;\n    @unit(\"°C\") @divisor(10) temp: UIN;\n",
     "slot_n": "    @maxLength(1) ign: IGN;\n    from: HTM;\n    to: HTM;\n    @maxLength(2) ign_1: IGN;\n",
     "set_n": "    slotindex: UCH;\n    slotcount: UCH;\n    from: HTM;\n    to: HTM;\n    @maxLength(2) @constValue(\"ffff\") `const`: HEX;\n    @in result: UCH;\n",
     "set_t": "    slotindex: UCH;\n    slotcount: UCH;\n    from: HTM;\n    to: HTM;\n    @unit(\"°C\") @divisor(10) temp: UIN;\n    @in result: UCH;\n",
    }
    base = {"count": ("r_a4", 0xa4), "slot_t": ("r_a5", 0xa5), "slot_n": ("r_a5", 0xa5),
            "set_n": ("w_a6", 0xa6), "set_t": ("w_a6", 0xa6)}
    out = HEAD + "/** Programas horarios del termostato (b555): lectura a4/a5, escritura a6 del dia completo. */\nnamespace B555sched_inc {\n"
    out += "  /** counter read */\n  @base(MF, 0x55, 0xa4)\n  model r_a4 {}\n\n"
    out += "  /** slot read */\n  @base(MF, 0x55, 0xa5)\n  model r_a5 {}\n\n"
    out += "  /** day write */\n  @write\n  @base(MF, 0x55, 0xa6)\n  model w_a6 {}\n\n"
    for r in lines(path, "b555"):
        k = sigs[",".join(r[9:])]
        bname, _ = base[k]
        out += doc(r[4])
        poll = "  @poll(5)\n" if r[0] == "r" else ""
        out += "%s  @inherit(%s)\n  @ext(%s)\n  model %s {\n%s  }\n\n" % (poll, bname, ext(r[8], 1), r[3], body[k])
    return out + "}\n"

def b516(path):
    out = HEAD + "/** Estadisticas de energia de la HMU (b516), periodos fijos. */\nnamespace B516stat_inc {\n"
    out += "  /** energy statistics read */\n  @base(MF, 0x16)\n  model r_16 {}\n\n"
    for r in lines(path, "b516"):
        assert ",".join(r[9:]) == "ign,,IGN:7,,,,value,,EXP,,Wh,", r
        out += doc(r[4])
        out += "  @inherit(r_16)\n  @ext(%s)\n  model %s {\n    @maxLength(7) ign: IGN;\n    @unit(\"Wh\") value: EXP;\n  }\n\n" % (ext(r[8], 0 if False else 1) if False else ", ".join("0x%02x" % x for x in bytes.fromhex(r[8])), r[3])
    return out + "}\n"

if __name__ == "__main__":
    d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "src", "vaillant")
    open(os.path.join(d, "b555sched_inc.tsp"), "w", encoding="utf-8").write(b555(sys.argv[1]))
    open(os.path.join(d, "b516stat_inc.tsp"), "w", encoding="utf-8").write(b516(sys.argv[2]))
