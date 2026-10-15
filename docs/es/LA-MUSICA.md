# La música

Nueve piezas, todas de Tennis and Hockey. El motor (bancos 7 y 8) tiene
cinco pistas: la música va en las tres primeras y los efectos en las dos últimas,
que le quitan al PSG la voz C o la B mientras suenan y se la devuelven al acabar
(`p08:A291`). El PSG tiene tres voces y el motor escribe en él por la BIOS
(WRTPSG): nunca toca un SCC.

Las piezas no se han reescrito: se ejecuta el propio motor del cartucho en un Z80 de Python
(`tools/musica.py`) y lo que escribe en el PSG se pasa a sonido. Cada una se ha cotejado
con openMSX (`tools/omsx_psg.tcl`, `tools/coteja_psg.py`): el estado del chip coincide en
todos los cuadros. Los diez efectos no van.

## 0x0D: GAME SELECT

<audio controls preload="none" src="../audio/musica_0D.mp3?v=8ec6f8ce"></audio>

Lo pide `p07:80AA`, al entrar en el minijuego; en bucle. 4,3 s y vuelve al cuadro 36.

## 0x0E: Tras GAME MODIFY: tenis

<audio controls preload="none" src="../audio/musica_0E.mp3?v=78fd73dc"></audio>

Lo pide th_aplica_opciones (p07:926D), con el tenis elegido. 6,1 s.

## 0x0F: Tras GAME MODIFY: hockey

<audio controls preload="none" src="../audio/musica_0F.mp3?v=32859774"></audio>

Lo pide th_aplica_opciones (p07:926D), con el hockey elegido. 6,3 s.

## 0x0B: El partido de tenis

<audio controls preload="none" src="../audio/musica_0B.mp3?v=b20eb1ca"></audio>

Lo pide `p07:8127` al acabar la 0x0E y p07:835B tras cada set; en bucle. 28,2 s y vuelve al cuadro 253.

## 0x0C: El partido de hockey

<audio controls preload="none" src="../audio/musica_0C.mp3?v=12b91bf8"></audio>

Lo pide `p07:812B` al acabar la 0x0F y p07:838D tras el descanso; en bucle. 59,3 s y vuelve al cuadro 1765.

## 0x12: Fin de un set

<audio controls preload="none" src="../audio/musica_12.mp3?v=a2638bdb"></audio>

Lo pide `p07:8344` (estado 6). 4,0 s.

## 0x13: El descanso del hockey (HALF TIME)

<audio controls preload="none" src="../audio/musica_13.mp3?v=72760748"></audio>

Lo pide `p07:8372` (estado 7). 7,5 s.

## 0x10: Fin del partido de tenis

<audio controls preload="none" src="../audio/musica_10.mp3?v=d382ec96"></audio>

Lo pide `p07:82DA` (estado 5). 4,9 s.

## 0x11: Fin del partido de hockey

<audio controls preload="none" src="../audio/musica_11.mp3?v=2517e285"></audio>

Lo pide `p07:824E` (estado 5). 6,1 s.
