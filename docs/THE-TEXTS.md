# The texts

Everything the cartridge writes on screen, taken from the ROM with
`tools/saca_textos.py`. There are four formats: [VRAM address] and letters with
`0xFE` / `0xFF` (the menus); the same with the letters 0x20 below ASCII (Tennis
and Hockey and the MSX1 biorhythm); [x, y] and letters (the MSX2 biorhythm), and
loose strings ending in `0xFF`. In the lists, "fila" is the row, "col" the
column and "suelto" a loose string.

The signs follow the cartridge's own font (`p00:483F`), which is not ASCII:
`0x3A` is an arrow, `0x3D` quotes, `0x3E` the equals sign and `0x40` a dash. The
typos are the ROM's own: "FORAMT" (three times), "UNFORMATED" and "BIORYTHM".

## p00

```
p00:4123*  fila  1 col  4  --SRAM DISK UTILITY--
            fila 14 col  2  SELECT COMMAND
            fila 15 col  4  DIRECTORY
            fila 16 col  4  FILE DELETE
            fila 17 col  4  FORMAT
            fila 18 col  4  END
p00:41E2*  fila  7 col 10  NO FILE
p00:41EC*  fila  3 col  8  DIRECTORY
p00:41F8*  fila 20 col  4  END>PUSH SPACE
p00:42D3*  fila 20 col  4  DELETE FILE
            fila 21 col  6  FILE NAME  -----
p00:42F4*  fila 22 col  4  FAILED
p00:42FD*  fila 22 col  4  RAM DISK UNFORMATED
p00:4313*  fila 22 col  4  FILE NOT FOUND
p00:4324*  fila 22 col  4  FILE DELETED
p00:4387*  fila  5 col  8  FORMAT RAM DISK
            fila  9 col  8  OK  PUSH Y
            fila 11 col  8  NO  PUSH N
p00:43B3*  fila 22 col  8  FORMAT COMPLETED
p00:43C6*  fila 22 col  8  FORAMT FAILED
p00:51C3*  (suelto)      --DISK ERROR--
p00:51FA*  (suelto)      HIT RETURN KEY
p00:5215   (suelto)      "FILE NOT FOUND"
p00:5226   (suelto)      "TOO MANY FILES"
p00:5237   (suelto)      "DISK FULL"
p00:5243   (suelto)      "DISK READ ERROR"
p00:5255   (suelto)      "DISK IO ERROR"
p00:534D   (suelto)      "WRITE PROTECTED""DISK OFFLINE"   RETURN KEY--RETRY
p00:5381   (suelto)      SPACE KEY --ABORT
p00:546E*  (suelto)      NO FILE
p00:5476*  (suelto)      HIT RETURN KEY
p00:5B3A*  (suelto)      INPUT FILE NAME
p00:5B4A*  (suelto)      SELECT FILE NAME
p00:5C72*  fila 17 col  1  --MENU--
            fila 17 col 12  DISK SAVE
            fila 18 col 12  DISK LOAD
            fila 19 col 12  END
p00:5C9B*  fila 19 col 11  RC-7
p00:5CBE*  fila 17 col 12  SCREEN DATA
            fila 18 col 12  GAME DATA
            fila 19 col 12  END
p00:5CDE*  fila 17 col 12  GAME DATA
            fila 18 col 12  END
p00:5CF0   (suelto)      L>END
p00:5D1E   (suelto)      DISK-SAVE
p00:5D28   (suelto)      DISK-LOAD
p00:5D32   (suelto)      TAPE-SAVE
p00:5D3C   (suelto)      TAPE-LOAD
p00:5D46   (suelto)      RANKING
p00:5D4E   (suelto)      PRINTER
p00:5D7D   (suelto)      GAME
p00:5D82   (suelto)      SCREEN
p00:5D89   (suelto)      HI SCORE
p00:5D92   (suelto)      RANKING
p00:5DA4*  (suelto)      SEARCH FILE
p00:5DBC*  fila 17 col 12  DISPLAY DATA
            fila 18 col 12  CHANGE NAME
            fila 22 col 12  END
p00:5F96*  fila 17 col  6  --SCREEN DISPLAY MODE--
            fila 19 col  7  DISPLAY ALL SCREEN
            fila 20 col  7  END
p00:5FCB*  fila  6 col  6  --SELF MODE MENU--
            fila  9 col  7  LOAD SCREEN DATA
            fila 11 col  7  SRAM DISK UTILITY
            fila 13 col  7  TENNIS AND HOCKEY
            fila 15 col  7  BIORYTHM
            fila 17 col  7  END
p01:602C   (suelto)      END
p01:60B8*  fila  6 col  5  ---MODIFY STAGE NUMBER---
            fila 11 col  7  STAGE NUMBER=
p01:6137*  fila  6 col  6  --MODIFY PLAYER NUMBER--
            fila 11 col  7  PLAYER NUMBER=
p01:619F   fila  6 col  6  --RANKING MODE--
            fila  9 col  7  LOAD DISK DATA
            fila 11 col  7  CLEAR RANKING DATA
            fila 13 col  7  END
p01:6273*  fila  6 col  6  --MODIFY MODE MENU--
            fila  9 col  7  MODIFY STAGE NUMBER
            fila 11 col  7  MODIFY PLAYER NUMBER
            fila 13 col  7  START GAME
p01:6958*  fila 17 col  1  RANKING
            fila 20 col 12  INPUT 1P NAME
p01:6972*  fila 20 col 12  INPUT 2P NAME
p01:6982*  fila 17 col 12  1P NAME =
p01:698F*  fila 18 col 12  2P NAME =
p01:699C*  fila 20 col 12  OK
            fila 22 col 12  RETRY
p01:6C50   bufer 0x8000  *** RC-7   SCORE RANKING ***
            bufer 0x803A  Rank.  Name.   Score.
            bufer 0x8054  ----------------------------
```

## p02

```
p02:854C*  (suelto)      INPUT FILE NAME
p02:855C*  (suelto)      SELECT FILE NAME
p02:8668*  fila 17 col  1  --MENU--
            fila 17 col 12  DISK SAVE
            fila 18 col 12  DISK LOAD
            fila 19 col 12  END
p02:8691*  fila 19 col 11  RC-7
p02:86B4*  fila 17 col 12  SCREEN DATA
            fila 18 col 12  GAME DATA
            fila 19 col 12  END
p02:86D4*  fila 17 col 12  GAME DATA
            fila 18 col 12  END
p02:86EA   (suelto)      L>END
p02:8718   (suelto)      DISK-SAVE
p02:8722   (suelto)      DISK-LOAD
p02:872C   (suelto)      RANKING
p02:8734   (suelto)      PRINTER
p02:8763   (suelto)      GAME
p02:8768   (suelto)      SCREEN
p02:876F   (suelto)      HI SCORE
p02:8778   (suelto)      RANKING
p02:878A*  (suelto)      SEARCH FILE
p02:87A2*  fila 17 col 12  DISPLAY DATA
            fila 18 col 12  CHANGE NAME
            fila 22 col 12  END
p02:882E*  fila  6 col  6  --SELF MODE MENU--
            fila  9 col  7  LOAD SCREEN DATA
            fila 11 col  7  SRAM DISK UTILITY
            fila 13 col  7  TENNIS AND HOCKEY
            fila 15 col  7  BIORYTHM
            fila 17 col  7  END
p02:894E*  fila  6 col  6  --RAM DISK FORMAT--
            fila  9 col  7  FORMAT
            fila 11 col  7  END
p02:8973*  fila 14 col  9  FORAMT COMPLETED
p02:8986*  fila 14 col  9  FORAMT FAILED
p02:89C2*  fila 17 col  6  --SCREEN DISPLAY MODE--
            fila 19 col  7  DISPLAY ALL SCREEN
            fila 20 col  7  END
p02:8A79*  fila  6 col  5  ---MODIFY STAGE NUMBER---
            fila 11 col  7  STAGE NUMBER=
p02:8AF8*  fila  6 col  6  --MODIFY PLAYER NUMBER--
            fila 11 col  7  PLAYER NUMBER=
p02:8B60   fila  6 col  6  --RANKING MODE--
            fila  9 col  7  LOAD DISK DATA
            fila 11 col  7  CLEAR RANKING DATA
            fila 13 col  7  END
p02:8C34*  fila  6 col  6  --MODIFY MODE MENU--
            fila  9 col  7  MODIFY STAGE NUMBER
            fila 11 col  7  MODIFY PLAYER NUMBER
            fila 13 col  7  START GAME
p02:956F*  (suelto)      --DISK ERROR--
p02:95A6*  (suelto)      HIT RETURN KEY
p02:95C1   (suelto)      "FILE NOT FOUND"
p02:95D2   (suelto)      "TOO MANY FILES"
p02:95E3   (suelto)      "DISK FULL"
p02:95EF   (suelto)      "DISK READ ERROR"
p02:9601   (suelto)      "DISK IO ERROR"
p02:96ED   (suelto)      "WRITE PROTECTED""DISK OFFLINE"   RETURN KEY--RETRY
p02:9721   (suelto)      SPACE KEY --ABORT
p02:980E*  (suelto)      NO FILE
p02:9816*  (suelto)      HIT RETURN KEY
p02:9BC2*  fila 17 col  1  RANKING
            fila 20 col 12  INPUT 1P NAME
p02:9BDC*  fila 20 col 12  INPUT 2P NAME
p02:9BEC*  fila 17 col 12  1P NAME =
p02:9BF9*  fila 18 col 12  2P NAME =
p02:9C06*  fila 20 col 12  OK
            fila 22 col 12  RETRY
```

## p05 (biorritmo de MSX1)

```
p05:9E40   OK<RET
p05:9E71   BIRTHDAY Y M D
p05:9EA0   CHECK DAY Y M D
p05:9EFB   PUSH SPACE KEY
p05:9F0C   CHECK DAY Y M D
p05:9F2B   PHY<
p05:9F32   SEN<
p05:9F39   INT<
p05:9F54   WORST
p05:9F5A   BAD
p05:9F5E   CAUTION
p05:9F66   NORMAL
p05:9F6D   GOOD
```

## p06

```
p06:A15E*  x  32 y  24  BIRTHDAY
            x  32 y  32  Y      M    D
p06:A17C*  x  48 y  48  CHECK   DAY
            x  48 y  56  Y      M    D
p06:A19D*  x 176 y  72  ;00DAY
p06:A1B2*  x  80 y 186  PHYSICAL
p06:A1BD*  x  80 y 186  SENSITIVITY
p06:A1CB*  x  80 y 186  INTELLECTUAL
p06:A1DA*  x  80 y 186  PUSH SPACE KEY
p06:A1EB*  x  32 y  24  CHECK DAY
            x  40 y  32  Y      M    D
p06:A208*  x  40 y  48  PHY<
            x  40 y  58  SEN<
            x  40 y  68  INT<
p06:A21D   (suelto)      WORST
p06:A223   (suelto)      BAD
p06:A227   (suelto)      CAUTION
p06:A22F   (suelto)      NORMAL
p06:A236   (suelto)      GOOD
p06:A267*  x 184 y 168  OK<RET
```

## p07

```
p07:8186*  fila  8 col 13  SET START
p07:8192*  fila  8 col 13  START
p07:82A0*  fila 18 col  9  PUSH SPACE KEY
p07:8399*  fila  8 col 12  HALF TIME
p07:876E*  fila  7 col 11  GAME SELECT
            fila 10 col 14  TENNIS
            fila 12 col 14  HOCKEY
            fila 14 col 14  END
            fila 17 col  9  PUSH SPACE KEY
p07:87A5*  fila  3 col 11  GAME MODIFY
            fila  6 col  8  LENGTH  1 2 3 4
            fila  8 col  8  SPEED   1 2 3 4 5
            fila 10 col  8  TYPE    A B C
            fila 12 col  8  BAR     N Y
            fila 17 col  9  PUSH SPACE KEY
p07:881C*  fila  5 col 14  DRAW
```

## p09

```
p09:8D74*  fila 19 col 10  (C)KONAMI 1988
```

