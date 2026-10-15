# The music

Nine pieces, all from Tennis and Hockey. The engine (banks 7 and 8) has
five tracks: the music uses the first three and the effects the last two, which
take PSG voice C or B while they play and give it back when they end
(`p08:A291`). The PSG has three voices and the engine writes to it through the
BIOS (WRTPSG): it never touches an SCC.

The pieces are not rewritten: the cartridge's own engine runs on a Python Z80
(`tools/musica.py`) and what it writes to the PSG is turned into sound. Each one
has been checked against openMSX (`tools/omsx_psg.tcl`, `tools/coteja_psg.py`):
the chip state matches in every frame. The ten effects are not included.

## 0x0D: GAME SELECT

<audio controls preload="none" src="audio/musica_0D.mp3?v=8ec6f8ce"></audio>

Asked for by `p07:80AA`, on entering the minigame; looping. 4.3 s, looping back to frame 36.

## 0x0E: After GAME MODIFY: tennis

<audio controls preload="none" src="audio/musica_0E.mp3?v=78fd73dc"></audio>

Asked for by th_aplica_opciones (`p07:926D`), with tennis chosen. 6.1 s.

## 0x0F: After GAME MODIFY: hockey

<audio controls preload="none" src="audio/musica_0F.mp3?v=32859774"></audio>

Asked for by th_aplica_opciones (`p07:926D`), with hockey chosen. 6.3 s.

## 0x0B: The tennis match

<audio controls preload="none" src="audio/musica_0B.mp3?v=b20eb1ca"></audio>

Asked for by `p07:8127` when 0x0E ends and by `p07:835B` after each set; looping. 28.2 s, looping back to frame 253.

## 0x0C: The hockey match

<audio controls preload="none" src="audio/musica_0C.mp3?v=12b91bf8"></audio>

Asked for by `p07:812B` when 0x0F ends and by `p07:838D` after half time; looping. 59.3 s, looping back to frame 1765.

## 0x12: End of a set

<audio controls preload="none" src="audio/musica_12.mp3?v=a2638bdb"></audio>

Asked for by `p07:8344` (state 6). 4.0 s.

## 0x13: Hockey half time (HALF TIME)

<audio controls preload="none" src="audio/musica_13.mp3?v=72760748"></audio>

Asked for by `p07:8372` (state 7). 7.5 s.

## 0x10: End of the tennis match

<audio controls preload="none" src="audio/musica_10.mp3?v=d382ec96"></audio>

Asked for by `p07:82DA` (state 5). 4.9 s.

## 0x11: End of the hockey match

<audio controls preload="none" src="audio/musica_11.mp3?v=2517e285"></audio>

Asked for by `p07:824E` (state 5). 6.1 s.
