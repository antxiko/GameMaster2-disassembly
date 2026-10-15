# Konami's Game Master 2 (RC-755)

*Konami's Game Master 2* (1987), in Japan *Konami no Shin 10-bai Cartridge*,
is a cheat cartridge for the MSX. It goes in next to a Konami game, recognises
it and lets you change the stage and the lives, save screens and games to disk
or to its own SRAM, and keep a ranking. On its own, with no game next to it,
it has its own menu: the SRAM utility, a tennis and hockey minigame and a
biorhythm.

![The title](imagenes/presentacion_japonesa.png)

Here is all of its code: the 131,072 bytes, in 16 banks of 8 KB, reassemble
byte for byte, and 40% of the instructions are commented.

## What is on this site

- [The cartridge](THE-CARTRIDGE.html): the banks, how it gets into the game,
  the table of 30 games, the cheats, the SRAM and the disk.
- [The screens](THE-SCREENS.html): 24 screens drawn from the ROM, on MSX and
  MSX2.
- [Tennis and Hockey](TENNIS-AND-HOCKEY.html): the minigame, its rules and its
  options.
- [The biorhythm](THE-BIORHYTHM.html): how it counts the days and draws the
  curves.
- [The music](THE-MUSIC.html): the nine pieces, taken from its own engine.
- [The texts](THE-TEXTS.html): everything it writes on screen.
- [The code](THE-CODE.html): how the disassembly is made and reassembled.
- [Findings](FINDINGS.html) and [Open questions](OPEN-QUESTIONS.html).

## Not one capture

Every picture is drawn with our own code reading the cartridge's tables, and
each has been compared byte for byte with the running cartridge or with the
openMSX VRAM: they match completely. The MSX ones use the BIOS font of the
Japanese C-BIOS, the machine used for the checks; on another machine the BIOS
letters would differ.

## Building it

You need the cartridge image, which is not distributed: `gamemaster2.rom`, the
GoodMSX dump (sha1 `5c00f9e3...`, 131,072 bytes), in the root. `make verify`
reassembles the 16 banks and checks that they come out identical.
