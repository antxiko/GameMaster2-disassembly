# Findings

## It also gets into MSX2 cartridges

To get into the game it looks in its start-up code for the address of an
interrupt hook: first H.TIMI, the one of Konami's six MSX2 cartridges, then
H.KEYI, the MSX1 one (`p00:588C`). Game Master 1 only looked for the second.
Checked with the ROMs: the six MSX2 ones write to H.TIMI and none to H.KEYI.

## Six new signatures

The signature table (`p00:44BE`) is Game Master 1's plus five for Vampire
Killer and one for Hinotori: 68 for 30 games.

## A non-Japanese machine gets the MSX1 title sequence

If the BIOS character set is not the Japanese one, the cartridge forgets it is
on an MSX2 and shows the MSX1 title sequence without the title (`p09:8024`).

## On MSX1 it calls a routine that only exists on MSX2

To clear the VRAM it uses BIGFIL (`0x016B`) on MSX1 too, where that BIOS entry
does not exist (on the C-BIOS it is zeros up to `0x0200`): the VRAM is not fully
cleared. It does not show because what is left falls on characters the screen
does not use. Checked against openMSX: on the SELF menu 8,322 bytes of the
tables differ and not one dot on the screen.

## Five tracks for three voices

The Tennis and Hockey engine has three music tracks and two effect tracks; an
effect takes PSG voice C or B if its priority is not lower than the music's,
and gives it back when it ends (`p08:A291`).

## Tennis without deuce

From 40 the next point wins the game, whoever reaches it first (`p07:9290`),
and the set ends at 6 games with no need for a two-game lead.

## The biorhythm curves fade in

On MSX2 the colours of the curves rise a little each day of the animation until
they are yellow, cyan and magenta (`p06:A2B7`).
