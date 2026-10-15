#!/usr/bin/env python3
"""SCREEN 2 del TMS9918: 16 KB de VRAM a PNG, con sprites de 16x16.

La disposicion es la que dan los registros del cartucho (p01:72E2:
02 E2 0E 7F 07 76 03, R#7 = el borde), la de siempre en los Konami:

    0x0000-0x17FF  colores         (R#3 = 0x7F)
    0x1800-0x1FFF  dibujos de sprite (R#6 = 0x03)
    0x2000-0x37FF  dibujos         (R#4 = 0x07)
    0x3800-0x3AFF  nombres         (R#2 = 0x0E)
    0x3B00-0x3B7F  atributos de sprite (R#5 = 0x76)

Sale del renderizador del Game Master 1 (GAMEMASTER_DISAM/tools/graficos.py).
Uso: screen2.py <vram.bin> <png> [borde]
"""
import struct
import sys
import zlib

# La paleta del TMS9918. La 0 es transparente: se ve el color del borde.
PALETA = [
    (0, 0, 0), (0, 0, 0), (33, 200, 66), (94, 220, 120),
    (84, 85, 237), (125, 118, 252), (212, 82, 77), (66, 235, 245),
    (252, 85, 84), (255, 121, 120), (212, 193, 84), (230, 206, 128),
    (33, 176, 59), (201, 91, 186), (204, 204, 204), (255, 255, 255),
]

COLORES, SPR_DIBUJOS, DIBUJOS, NOMBRES, SPR_ATRIBUTOS = \
    0x0000, 0x1800, 0x2000, 0x3800, 0x3B00


def png(w, h, px, fn, escala=2):
    """PNG en color verdadero sin nada de fuera; cada punto, escala x escala."""
    filas = []
    for y in range(h):
        fila = b"".join(bytes(px[y][x]) * escala for x in range(w))
        filas.extend([b"\x00" + fila] * escala)

    def chunk(t, d):
        return (struct.pack(">I", len(d)) + t + d
                + struct.pack(">I", zlib.crc32(t + d) & 0xFFFFFFFF))

    with open(fn, "wb") as f:
        f.write(b"\x89PNG\r\n\x1a\n"
                + chunk(b"IHDR", struct.pack(">IIBBBBB", w * escala, h * escala, 8, 2, 0, 0, 0))
                + chunk(b"IDAT", zlib.compress(b"".join(filas), 9))
                + chunk(b"IEND", b""))


def pinta(v, borde=1, con_sprites=True):
    """Los 16 KB en 256x192 puntos: [fila][columna] -> (r, g, b)."""
    fondo_borde = PALETA[borde & 15]
    px = [[fondo_borde] * 256 for _ in range(192)]
    for fila in range(24):
        tercio = fila // 8
        for col in range(32):
            car = v[NOMBRES + fila * 32 + col]
            base = DIBUJOS + tercio * 0x800 + car * 8
            cbase = COLORES + tercio * 0x800 + car * 8
            for y in range(8):
                linea, color = v[base + y], v[cbase + y]
                t, f = color >> 4, color & 15
                tinta = PALETA[t] if t else fondo_borde
                fondo = PALETA[f] if f else fondo_borde
                for x in range(8):
                    px[fila * 8 + y][col * 8 + x] = \
                        tinta if linea & (0x80 >> x) else fondo
    if con_sprites:
        pinta_sprites(v, px)
    return px


def pinta_sprites(v, px):
    """Los sprites de 16x16, de atras adelante (el 0 tapa a los demas).

    Y = 0xD0 corta la lista; la linea que se ve es Y + 1, y las Y de 0xE0 en
    adelante son negativas (sprite que asoma por arriba o escondido).
    """
    entradas = []
    for i in range(32):
        a = SPR_ATRIBUTOS + i * 4
        if v[a] == 0xD0:
            break
        entradas.append((v[a], v[a + 1], v[a + 2], v[a + 3]))
    for y, x, patron, color in reversed(entradas):
        if (color & 15) == 0:
            continue
        c = PALETA[color & 15]
        if color & 0x80:                   # el bit EC corre el sprite 32 a la izquierda
            x -= 32
        y = y + 1 if y < 0xE0 else y + 1 - 256
        base = SPR_DIBUJOS + (patron & 0xFC) * 8
        for cuarto in range(4):            # izq-arriba, izq-abajo, der-arriba, der-abajo
            dx, dy = (cuarto // 2) * 8, (cuarto % 2) * 8
            for f in range(8):
                linea = v[base + cuarto * 8 + f]
                for b in range(8):
                    if linea & (0x80 >> b):
                        py, pxx = y + dy + f, x + dx + b
                        if 0 <= py < 192 and 0 <= pxx < 256:
                            px[py][pxx] = c


def main(argv):
    v = open(argv[1], "rb").read()
    borde = int(argv[3], 0) if len(argv) > 3 else 1
    png(256, 192, pinta(v, borde), argv[2])


if __name__ == "__main__":
    main(sys.argv)
