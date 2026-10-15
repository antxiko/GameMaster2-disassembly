# Tennis and Hockey

A two-player Pong (banks 7 and 8): there is no computer opponent. Everything
runs inside the interrupt (`p07:8004`).

![The tennis court](imagenes/tenis_pista.png)

## The controls

| player | side | joystick | keyboard |
|---|---|---|---|
| 1 | right | port 1 | arrows, space (A), SELECT (B) |
| 2 | left | port 2 | E S F C, SHIFT (A), CTRL (B) |

CTRL and C together go back to the start (`p07:806E`).

## GAME MODIFY

| option | values | what it does |
|---|---|---|
| LENGTH | 1-4 | the length of the bat (`p07:8A0A`) |
| SPEED | 1-5 | the speed (`p07:8D4C`) |
| TYPE | A, B, C | with B or C each player has a second bat: B in their own half, C in the other one (`p07:8A25`) |
| BAR | N, Y | a bar that moves up and down in the middle (`p07:8C4D`) |

## Tennis

It counts 15, 30, 40 and game, **with no deuce or advantage** (`p07:9277`).
A set is 6 games with no need for a two-game lead, and the match is two sets.
The serve changes every game.

## Hockey

![The hockey rink](imagenes/hockey_pista.png)

Whoever scores more goals wins (the scoreboard goes up to 99). The clock starts
at 90 and goes down by one every 64 frames (`p07:931A`); at 10 there is a
warning sound and there is a break, HALF TIME (`p07:8367`). At the end the one
ahead wins, or it is a DRAW.

At the end of the match 1P WIN, 2P WIN or DRAW blinks (`p07:831B`).

*Read in the code.* The music for each moment is on [The music](THE-MUSIC.html).
