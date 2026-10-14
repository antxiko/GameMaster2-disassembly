#!/usr/bin/env python3
"""Una linea por rutina (destino de `call`) para bautizarla: cuantas veces la
llaman, sus primeras instrucciones, la BIOS y la RAM que toca y a quien llama.

Herramienta de mano: no escribe nada.

Uso: resumen.py <banco> [desde_hex] [hasta_hex]
"""
import re
import sys
import glob
import os
from collections import Counter

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)

BIOS = {0x0C: "RDSLT", 0x14: "WRSLT", 0x1C: "CALSLT", 0x24: "ENASLT", 0x41: "DISSCR",
        0x44: "ENASCR", 0x47: "WRTVDP", 0x4A: "RDVRM", 0x4D: "WRTVRM", 0x50: "SETRD",
        0x53: "SETWRT", 0x56: "FILVRM", 0x59: "LDIRMV", 0x5C: "LDIRVM", 0x5F: "CHGMOD",
        0x62: "CHGCLR", 0x69: "CLRSPR", 0x6C: "INITXT", 0x72: "INIGRP", 0x93: "WRTPSG",
        0x96: "RDPSG", 0x9C: "CHSNS", 0x9F: "CHGET", 0xA2: "CHPUT", 0xC0: "BEEP",
        0xC3: "CLS", 0xC6: "POSIT", 0xD5: "GTSTCK", 0xD8: "GTTRIG", 0x132: "CHGCAP",
        0x138: "RSLREG", 0x13B: "WSLREG", 0x13E: "RDVDP", 0x141: "SNSMAT", 0x156: "KILBUF",
        0x16B: "BIGFIL", 0x16E: "NSETRD", 0x171: "NSTWRT", 0xF37D: "BDOS"}


def main(argv):
    b = int(argv[1])
    desde = int(argv[2], 16) if len(argv) > 2 else 0
    hasta = int(argv[3], 16) if len(argv) > 3 else 0x10000
    todos = {}
    for f in glob.glob(os.path.join(RAIZ, "src", "*_p*.asm")):
        todos[int(f[-6:-4])] = open(f, encoding="utf-8").read().splitlines()
    # las llamadas que van DE VERDAD a este banco: las del propio listado y
    # las de otros bancos que el trazador de cartucho entero manda aqui
    # (src/pNN.entries, "pMM:XXXX call")
    cnt = Counter()
    for l in todos[b]:
        m = re.match(r"	call (?:[a-z]+,)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h)", l)
        if m:
            cnt[int(m.group(1) or m.group(2), 16)] += 1
    for l in open(os.path.join(RAIZ, "src", "p%02d.entries" % b), encoding="utf-8"):
        m = re.match(r"^0x([0-9A-Fa-f]{4})\s+#\s+p\d\d:[0-9A-F]{4} call", l)
        if m:
            cnt[int(m.group(1), 16)] += 1
    ls = todos[b]
    ins = []
    for l in ls:
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})", l)
        if m and not l.startswith("\tdefb"):
            ins.append((int(m.group(2), 16), m.group(1).strip()))
    pos = {a: k for k, (a, _) in enumerate(ins)}
    objetivos = sorted(a for a in cnt if a in pos and desde <= a < hasta)
    for a in objetivos:
        k = pos[a]
        cuerpo = []
        bios, ram, llama = set(), set(), []
        j = k
        while j < len(ins) and j - k < 60:
            t = ins[j][1]
            cuerpo.append(t)
            for x in re.findall(r"\b0?([0-9a-f]{4,5})h\b", t):
                v = int(x, 16)
                if t.startswith(("call", "jp")) and v in BIOS:
                    bios.add(BIOS[v])
                elif v >= 0xC000 and not t.startswith(("call", "jp")):
                    ram.add("%04X" % v)
            m = re.match(r"(?:call|jp) (?:[a-z]+,)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h)", t)
            if m:
                v = int(m.group(1) or m.group(2), 16)
                if v >= 0x4000 and v not in BIOS:
                    llama.append("%04X" % v)
            if t == "ret" or (t.startswith("jp ") and "," not in t) or t.startswith("jr ") and "," not in t:
                break
            j += 1
        print("%04X x%-2d n=%-2d %s | %s%s%s" % (
            a, cnt[a], len(cuerpo), " / ".join(cuerpo[:10]),
            ("BIOS " + ",".join(sorted(bios)) + " ") if bios else "",
            ("RAM " + ",".join(sorted(ram)[:6]) + " ") if ram else "",
            ("-> " + ",".join(llama[:5])) if llama else ""))


if __name__ == "__main__":
    main(sys.argv)
