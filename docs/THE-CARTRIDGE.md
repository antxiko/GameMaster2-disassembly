# The cartridge

## The banks

128 KB in 16 banks of 8 KB, with the Game Master 2's own mapper. Bank 0 is
fixed at `0x4000`; the others are selected by writing their number to
`0x6000`, `0x8000` or `0xA000`. A value with bit 4 set at `0xA000` puts the
SRAM there instead: two halves of 4 KB. Banks 12 to 15 are empty (`0xFF`).

| banks | what is there |
|---|---|
| p00-p01 | the menu of the cartridge on its own (its RAM at `0xF2xx` and in page 2) |
| p02-p03 | the copy that runs with the game next to it (its RAM at `0xD1xx`-`0xD3xx`) |
| p04 | the SRAM file system |
| p05-p06 | the biorhythm, on MSX1 and MSX2 |
| p07-p08 | Tennis and Hockey and its sound engine |
| p09 | the title sequence and the VDP library |
| p10-p11 | graphics |

## How it gets into the game

At power-on it looks for a Konami cartridge in the other slots and reads the
first 256 bytes of its start-up code looking for the address of an interrupt
hook (`p00:5878`): first H.TIMI (`9F FD`), where Konami's six MSX2 cartridges
hook in, then H.KEYI (`9A FD`), the MSX1 one (`p00:588C`). Game Master 1 only
looked for the second: that is why this one also gets into Vampire Killer and
Hinotori.

Holding space or GRAPH at power-on stops the cartridge from starting.

## The table of games

To know which game is next to it, it reads the second header at `0x4010` if
the game has one (`AB`, `CD` or `EF` and its catalogue number). If not, it adds
up the 256 bytes at `0x5000`-`0x50FF` and looks the sum up in the table at
`p00:44BE`: 68 signatures pointing to 31 records for 30 games. Each record
starts with the catalogue number in BCD (`07 01` is RC-701) followed by the
addresses of the game's variables.

They are Game Master 1's 62 signatures plus six new ones: five for Vampire
Killer (RC-744) and one for Hinotori (RC-747). 35 are checked by adding up the
real ROMs, and each of the 30 games has at least one.

## The cheats

MODIFY STAGE NUMBER and MODIFY PLAYER NUMBER go through two tables of
three-byte entries, catalogue number and routine: lives (`p01:6CA6`, 16 games)
and stage (`p01:6CD7`, 21 games). The lives routine for almost all of them
(`p01:6D27`) writes the lives asked for (`0xF299`) into the variable given by
the game's record (`0xF288`); the stage one does its own sum for each game:
the stage asked for modulo the number of stages, in BCD, or spread over
several variables.

| RC | game | lives | stage |
|---|---|---|---|
| RC-700 | Athletic Land | `p01:6D27` | `p01:6DD8` |
| RC-701 | Antarctic Adventure | - | `p01:6DFD` |
| RC-702 | Monkey Academy | `p01:6D27` | - |
| RC-703 | Time Pilot | `p01:6D27` | - |
| RC-704 | Frogger | `p01:6D27` | - |
| RC-705 | Super Cobra | `p01:6D27` | - |
| RC-706 | Konami's Billiards | `p01:6D27` | - |
| RC-710 | Hyper Olympic 1 | - | `p01:6E38` |
| RC-711 | Hyper Olympic 2 | - | `p01:6E38` |
| RC-712 | Circus Charlie | `p01:6D27` | `p01:6E81` |
| RC-713 | Magical Tree | `p01:6D27` | `p01:6E97` |
| RC-714 | Comic Bakery | `p01:6D27` | `p01:6EE9` |
| RC-715 | Hyper Sports 1 | - | `p01:6EEC` |
| RC-716 | Cabbage Patch Kids | `p01:6D27` | `p01:6DD8` |
| RC-717 | Hyper Sports 2 | - | `p01:6EF3` |
| RC-718 | Hyper Rally | - | `p01:6EFF` |
| RC-721 | Sky Jaguar | `p01:6D27` | `p01:6F37` |
| RC-725 | Yie Ar Kung-Fu | `p01:6D17` | `p01:6F48` |
| RC-727 | King's Valley | `p01:6D27` | `p01:6F78` |
| RC-728 | Mopi Ranger | `p01:6D34` | `p01:6FC9` |
| RC-729 | Pippols | `p01:6D2F` | `p01:6FE4` |
| RC-730 | Road Fighter | - | `p01:6FF7` |
| RC-732 | Konami's Soccer / Football | - | `p01:7016` |
| RC-733 | Hyper Sports 3 | - | `p01:701F` |
| RC-736 | Konami's Boxing | - | `p01:7028` |
| RC-737 | Yie Ar Kung-Fu II | `p01:6D2F` | `p01:704E` |


## The SRAM

*Read in the code, not run.* Bank 4 holds a file system for the SRAM: a
directory at `0xB000` (64 entries of 8 bytes), the block table at `0xB200`,
five-letter names that accept the wildcards `*` and `?` and a CRC-16
(`0xA001`) for each 128-byte block. Every command goes through one door:
`p00:4020` brings in the SRAM and jumps to `p04:8000` with the command number in
C (5 is the directory; 0x0C and 0x0D clear it and mark it as formatted). From
the SELF menu it is reached through SRAM DISK UTILITY: DIRECTORY, FILE DELETE
and FORMAT.

## The disk

LOAD SCREEN DATA and the saving of screens, games and ranking need a disk:
without one (`p00:5F1A` checks whether the H.PHYD hook is a `ret`), the
cartridge goes back to the menu.
