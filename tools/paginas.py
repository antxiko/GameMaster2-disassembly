#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Konami's Game Master 2 (Konami, RC-755, 1987, MSX1) es un cartucho de 128 KB
con su propio mapper (openMSX lo llama GameMaster2): 16 bancos de 8 KB y una
SRAM. El banco de 0x4000-0x5FFF es FIJO y los otros tres se eligen
escribiendo el numero de banco en 0x6000 (para 0x6000-0x7FFF), 0x8000 (para
0x8000-0x9FFF) y 0xA000 (para 0xA000-0xBFFF). En 0xA000, un valor con el bit
4 puesto (0x10, 0x30) no pone un banco de ROM: pone la SRAM.

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez):
  - Los repartos se meten con `ld a,N / ld (0x8000),a / inc a /
    ld (0xA000),a`: 2-3, 5-6, 7-8 y 9-10 van por parejas; el 1 solo va en
    0x6000; el 4 va en 0x8000 con la SRAM en 0xA000 (p00:402E); el 11 lo
    pone p09 en 0xA000.
  - Los bancos 12 a 15 son relleno 0xFF entero: nadie los pone.
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16

# banco -> direccion de ejecucion. Medido, no supuesto: ver reconocimiento.py.
# Los 12-15 no se ponen nunca; se listan en 0xA000 por dar alguna.
EN_6000 = (1,)
EN_8000 = (2, 4, 5, 7, 9)
EN_A000 = (3, 6, 8, 10, 11, 12, 13, 14, 15)
ORG = {0: 0x4000}
for _b in EN_6000:
    ORG[_b] = 0x6000
for _b in EN_8000:
    ORG[_b] = 0x8000
for _b in EN_A000:
    ORG[_b] = 0xA000

# Escrituras al mapper que ponen un banco fuera de su ranura, medidas en
# reconocimiento.py: (banco, pc de la escritura) -> ranura.
EXCEPCIONES = {}

NUNCA_MAPEADOS = (12, 13, 14, 15)

# Escrituras a los registros que NO van a este cartucho (banco, pc).
OTRO_SLOT = set()


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p15."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("%d bancos de %d bytes en %s/" % (N_PAGINAS, TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
