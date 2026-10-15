# Konami's Game Master 2 (RC-755) — a commented disassembly

*(También en [castellano](README.es.md).)*

**[→ Read it on the web](https://antxiko.github.io/GameMaster2-disassembly/)**

A complete, commented disassembly of Konami's Game Master 2 for the MSX
(1987), in Japan *Konami no Shin 10-bai Cartridge*: RC-755, 128 KB with SRAM.

It is Konami's **cheat cartridge**: it goes in next to a game, recognises it,
gets into its interrupt and lets you change the stage and the lives, save
screens and games to disk or to its SRAM, and keep a ranking. On its own it has
its own menu: the SRAM utility, a two-player Tennis and Hockey and a
biorhythm.

| | |
|---|---|
| binary explained | **100%**, 131,072 of 131,072 bytes |
| code traced | 36,633 bytes |
| data identified | 94,439 bytes |
| routines | 2,338, **none under-commented** |
| comment density | **40.1%** |
| games it recognises | 30 (68 signatures) |
| screens drawn | 24, checked to 0 |
| tunes | 9, checked against openMSX |
| tests | 14 |

## How it gets in

It looks in the first 256 bytes of the game's start-up code for the address
of an interrupt hook: first H.TIMI (the one Konami's MSX2 cartridges use), then
H.KEYI (the MSX1 one). That is how it also gets into Vampire Killer and
Hinotori, which Game Master 1 could not do.

## Reproducing it

The cartridge is not distributed. Put your copy in the root as
`gamemaster2.rom` (sha256 `2054636a6ca2…`) and:

    make verify    # reassembles the 16 banks and compares them byte for byte
    make sanity    # checks the trace
    make web       # builds the website

## The pictures and the music

No picture is a capture: they are drawn by reading the cartridge's tables and
checked byte for byte against the running cartridge or the openMSX VRAM. The
tunes come from running its own sound engine and match openMSX frame by frame.

See [LEGAL-NOTICE.md](LEGAL-NOTICE.md) and [LICENSE](LICENSE).
