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

## Código compartido con otros cartuchos de Konami

Este desensamblado se ha comparado, instrucción por instrucción, con
todos los demás de Konami de la serie. Cuenta un bloque cuando las
mismas instrucciones, al menos seis desde una etiqueta hasta su `ret`
o su salto sin condición, están en los dos cartuchos; las direcciones
no se miran, porque cambian de un cartucho a otro. De los otros 57,
**46** tienen al menos un bloque en común con este; estos son los
que más comparten:

| Cartucho | Bloques | Instrucciones | Por ejemplo (aquí = allí) |
|---|---:|---:|---|
| [Konami’s Game Master](https://antxiko.github.io/GameMaster-disassembly/es/) | 155 | 2.447 | `lee_teclas` (p01:662E) = `lee_las_teclas_de_truco` |
| [Shalom: Knightmare III](https://antxiko.github.io/Shalom-disassembly/es/) | 67 | 917 | `sonido_mezclador` (p08:A384) = `mezclador` |
| [The Pro Yakyuu Gekitotsu Pennant Race](https://antxiko.github.io/PennantRace-disassembly/es/) | 59 | 976 | `vdp_hmmc` (p05:8448) = `rectangulo_desde_ram` |
| [Hai no Majutsushi - Mahjong 2](https://antxiko.github.io/Majutsushi-disassembly/es/) | 54 | 661 | `sonido_mezcla` (p08:A291) = `vuelca_psg` |
| [Gekitotsu Pennant Race 2](https://antxiko.github.io/PennantRace2-disassembly/es/) | 40 | 499 | `vdp_hmmv` (p05:83C8) = `borra_bloque_vram` |
| [King's Valley II](https://antxiko.github.io/KingsValley2-disassembly/es/) | 39 | 453 | `sonido_envolvente` (p08:A356) |
| [Salamander - Operation X](https://antxiko.github.io/Salamander-disassembly/es/) | 37 | 462 | `th_pinta_texto` (p07:8626) = `lista_a_vram` |
| [Nemesis 3 - The Eve of Destruction](https://antxiko.github.io/Nemesis3-disassembly/es/) | 34 | 414 | `th_pinta_texto` (p07:8626) = `escribe_texto` |
| [Parodius](https://antxiko.github.io/Parodius-disassembly/es/) | 34 | 408 | `canal_libre` (p07:9BCB) = `carga_canal` |
| [F-1 Spirit — The Way to Formula 1](https://antxiko.github.io/F1Spirit-disassembly/es/) | 31 | 391 | `canal_libre` (p07:9BCB) = `SONIDO_CANAL` |

La matriz entera, los 58 cartuchos entre sí, está en
[Las rutinas](https://antxiko.github.io/MSX-disassembly-database/es/LAS-RUTINAS.html) de la base de datos de la
serie, con el método y el programa que la mide.
