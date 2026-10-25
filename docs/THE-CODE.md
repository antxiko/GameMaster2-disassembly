# The code

One listing per bank in `src/gamemaster2_pNN.asm` (p00 to p11), assembled with
pasmo into a ROM identical to the original: `make verify`. 100% of the binary
is explained: 36,633 bytes of code and 94,439 of data, with 2,338 named
routines and 40% of the 18,220 instructions commented. No routine is below the
minimum of comments.

## How it is made

- `tools/z80trace.py` walks the code from its entry points and separates code
  from data. The pieces the cartridge copies to RAM and runs there (18, in
  `src/reubica.txt`) are walked at the address where they run.
- `tools/bancos.py` knows which bank is in each window: the layout each
  routine sets, the dispatchers and the hooks.
- `tools/anota.py` comments the variables, the BIOS and the calls, and
  `tools/gemelas.py` copies names and comments between repeated routines
  (p00/p01 and p02/p03 are almost the same).

## The pictures and the music

- `tools/pantallas.py` and `tools/pantallas2.py` draw the screens;
  `tools/corre.py` runs the whole cartridge on a Python Z80 (with the mapper,
  the BIOS trapped and the C-BIOS to read its font) and `tools/coteja.py`
  compares the two VRAMs. MSX2 is checked against openMSX
  (`tools/omsx_msx2.tcl`, `tools/coteja2.py`).
- `tools/musica.py` runs the sound engine and makes the MP3s;
  `tools/omsx_psg.tcl` and `tools/coteja_psg.py` check them against openMSX.

## Code shared with other Konami cartridges

This disassembly has been compared, instruction by instruction, with
every other Konami one in the series. A block counts when the same
instructions, at least six of them from a label to its `ret` or its
unconditional jump, are in both cartridges; the addresses are left
aside, because they change from one cartridge to the next. Of the
other 57, **46** have at least one block in common with this one;
these are the ones that share the most:

| Cartridge | Blocks | Instructions | For example (here = there) |
|---|---:|---:|---|
| [Konami’s Game Master](https://antxiko.github.io/GameMaster-disassembly/) | 155 | 2,447 | `lee_teclas` (p01:662E) = `lee_las_teclas_de_truco` |
| [Shalom: Knightmare III](https://antxiko.github.io/Shalom-disassembly/) | 67 | 917 | `sonido_mezclador` (p08:A384) = `mezclador` |
| [The Pro Yakyuu Gekitotsu Pennant Race](https://antxiko.github.io/PennantRace-disassembly/) | 59 | 976 | `vdp_hmmc` (p05:8448) = `rectangulo_desde_ram` |
| [Hai no Majutsushi - Mahjong 2](https://antxiko.github.io/Majutsushi-disassembly/) | 54 | 661 | `sonido_mezcla` (p08:A291) = `vuelca_psg` |
| [Gekitotsu Pennant Race 2](https://antxiko.github.io/PennantRace2-disassembly/) | 40 | 499 | `vdp_hmmv` (p05:83C8) = `borra_bloque_vram` |
| [King's Valley II](https://antxiko.github.io/KingsValley2-disassembly/) | 39 | 453 | `sonido_envolvente` (p08:A356) |
| [Salamander - Operation X](https://antxiko.github.io/Salamander-disassembly/) | 37 | 462 | `th_pinta_texto` (p07:8626) = `lista_a_vram` |
| [Nemesis 3 - The Eve of Destruction](https://antxiko.github.io/Nemesis3-disassembly/) | 34 | 414 | `th_pinta_texto` (p07:8626) = `escribe_texto` |
| [Parodius](https://antxiko.github.io/Parodius-disassembly/) | 34 | 408 | `canal_libre` (p07:9BCB) = `carga_canal` |
| [F-1 Spirit — The Way to Formula 1](https://antxiko.github.io/F1Spirit-disassembly/) | 31 | 391 | `canal_libre` (p07:9BCB) = `SONIDO_CANAL` |

The whole matrix, the 58 cartridges against each other, is on
[The routines](https://antxiko.github.io/MSX-disassembly-database/THE-ROUTINES.html) in the series database, along
with the method and the program that measures it.
