#!/usr/bin/env python3
"""Las musicas de Tennis and Hockey, ejecutando su motor de sonido
(ver motor_musica.py).

El motor esta en p07 (0x8000) y p08 (0xA000): la interrupcion (p07:8004)
llama en cada cuadro a sonido_cuadro, p07:9CA5, y el minijuego pide un
sonido con pide_sonido, p07:9B3C (A = numero). La tabla de p07:9BF5 da, por
numero, las pistas que usa (bits 7-3 = pistas 0-4), su prioridad y un puntero
por pista. Cinco pistas de 0x2C bytes desde 0xE200: la musica en las 0-2 y
los efectos en la 3 y la 4, que le quitan al PSG la voz C o la B mientras
suenan (p08:A291). Solo PSG: el motor escribe por WRTPSG y nunca toca un SCC.
Antes de nada, p07:8045 borra 0xE200-0xE8FF y p07:86B0 pone el mezclador a
0xBF.

Uso:  musica.py registros 0x0D [cuadros] | mp3 0x0D f.mp3 | todas docs/audio
      musica.py barrido 0x01 0x14
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402

P = motor_musica.P

# Las musicas (pistas 0-2) de la tabla de p07:9BF5; los efectos (0x02-0x0A,
# 0x14) y el silencio (0x01) no van.
PIEZAS = [
    P(0x0D, "GAME SELECT", "GAME SELECT",
      "p07:80AA, al entrar en el minijuego; en bucle"),
    P(0x0E, "Tras GAME MODIFY: tenis", "After GAME MODIFY: tennis",
      "th_aplica_opciones (p07:926D), con el tenis elegido"),
    P(0x0F, "Tras GAME MODIFY: hockey", "After GAME MODIFY: hockey",
      "th_aplica_opciones (p07:926D), con el hockey elegido"),
    P(0x0B, "El partido de tenis", "The tennis match",
      "p07:8127 al acabar la 0x0E y p07:835B tras cada set; en bucle"),
    P(0x0C, "El partido de hockey", "The hockey match",
      "p07:812B al acabar la 0x0F y p07:838D tras el descanso; en bucle"),
    P(0x12, "Fin de un set", "End of a set", "p07:8344 (estado 6)"),
    P(0x13, "El descanso del hockey (HALF TIME)", "Hockey half time (HALF TIME)",
      "p07:8372 (estado 7)"),
    P(0x10, "Fin del partido de tenis", "End of the tennis match", "p07:82DA (estado 5)"),
    P(0x11, "Fin del partido de hockey", "End of the hockey match", "p07:824E (estado 5)"),
]

CFG = dict(rom="gamemaster2.rom", org=0x4000, mapper="konami",
           bancos0=((0x4000, 0), (0x6000, 1), (0x8000, 7), (0xA000, 8)),
           frame=0x9CA5, pide=0x9B3C, banco_frame=7, banco_pide=7,
           ram=(0xE200, 0xE300), ram0=[(0xE2EE, 0xBF)], hz=60,
           psg0={7: 0xBF}, max_s=300, piezas=PIEZAS,
           maquina="C-BIOS_MSX1_JP")


if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
