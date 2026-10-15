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
