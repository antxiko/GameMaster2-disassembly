# El código

Un listado por banco en `src/gamemaster2_pNN.asm` (de p00 a p11), que se monta
con pasmo y sale idéntico a la ROM: `make verify`. El 100 % del binario está
explicado: 36.633 bytes de código y 94.439 de datos, con 2.338 rutinas con
nombre y el 40 % de las 18.220 instrucciones comentado. Ninguna rutina queda
por debajo del mínimo de comentarios.

## Cómo está hecho

- `tools/z80trace.py` recorre el código desde sus entradas y separa código de
  datos. Los trozos que el cartucho copia a RAM y ejecuta allí (18, en
  `src/reubica.txt`) se recorren en la dirección donde corren.
- `tools/bancos.py` sabe qué banco va en cada ventana: el reparto que pone cada
  rutina, los despachadores y los ganchos.
- `tools/anota.py` comenta las variables, la BIOS y las llamadas, y
  `tools/gemelas.py` copia nombres y comentarios entre las rutinas repetidas
  (p00/p01 y p02/p03 son casi la misma).

## Las imágenes y la música

- `tools/pantallas.py` y `tools/pantallas2.py` dibujan las pantallas;
  `tools/corre.py` ejecuta el cartucho entero en un Z80 de Python (con el
  mapper, la BIOS atrapada y la C-BIOS para leer su fuente) y
  `tools/coteja.py` compara las dos VRAM. En MSX2 se coteja contra openMSX
  (`tools/omsx_msx2.tcl`, `tools/coteja2.py`).
- `tools/musica.py` ejecuta el motor de sonido y saca los MP3;
  `tools/omsx_psg.tcl` y `tools/coteja_psg.py` lo cotejan con openMSX.
