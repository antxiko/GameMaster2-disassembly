; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 09 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x80ca  (202 bytes)
; ======================================================================


L_8000:
	di			;8000
	ld hl,L_800E		;8001
	ld de,0fd9ah		;8004
	ld bc,00005h		;8007
	ldir		;800a
	ei			;800c
	ret			;800d
L_800E:
	ld hl,0e008h		;800e
	dec (hl)			;8011
	ret			;8012
L_8013:
	di			;8013
	ld a,0c9h		;8014
	ld (0fd9ah),a		;8016
	ei			;8019
	ret			;801a
L_801B:
	call L_8000		;801b
	ld a,(0002dh)		;801e
	ld (0e003h),a		;8021
	ld a,(0002bh)		;8024
	and 00fh		;8027
	ld (0e009h),a		;8029
	jr z,L_8032		;802c
	xor a			;802e
	ld (0e003h),a		;802f
L_8032:
	ld a,(0e003h)		;8032
	and a			;8035
	jr z,L_8060		;8036
	ld a,004h		;8038
	ld (0f3ebh),a		;803a
	call 00062h		;803d   ; BIOS CHGCLR - Changes the screen colors
	jp L_8091		;8040
L_8043:
	ld a,(0002dh)		;8043
	ld (0e003h),a		;8046
	ld a,(0002bh)		;8049
	and 00fh		;804c
	ld (0e009h),a		;804e
	jr z,L_8057		;8051
	xor a			;8053
	ld (0e003h),a		;8054
L_8057:
	call L_8000		;8057
	ld a,(0e003h)		;805a
	and a			;805d
	jr nz,L_8089		;805e
L_8060:
	ld a,002h		;8060
	ld (0fcafh),a		;8062
	ld hl,00000h		;8065
	ld bc,04000h		;8068
	xor a			;806b
	call 00056h		;806c   ; BIOS FILVRM - Fills VRAM with value
	call 072bch		;806f
	ld a,0ffh		;8072
	call 00132h		;8074   ; BIOS CHGCAP - Alternates the CAPS lamp status
	ld hl,03b00h		;8077
	ld bc,00080h		;807a
	ld a,0e0h		;807d
	call 00056h		;807f   ; BIOS FILVRM - Fills VRAM with value
	ld bc,00407h		;8082
	call 00047h		;8085   ; BIOS WRTVDP - Writes data in the VDP-register
	ret			;8088
L_8089:
	ld a,00fh		;8089
	ld (0f3ebh),a		;808b
	call 00062h		;808e   ; BIOS CHGCLR - Changes the screen colors
L_8091:
	ld a,005h		;8091
	call 0005fh		;8093   ; BIOS CHGMOD - Switches to given screen mode
	ld b,004h		;8096
	ld hl,080cah		;8098
L_809B:
	push bc			;809b
	ld c,(hl)			;809c
	inc hl			;809d
	ld b,(hl)			;809e
	inc hl			;809f
	push hl			;80a0
	call 00047h		;80a1   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;80a4
	pop bc			;80a5
	djnz L_809B		;80a6
	call 07275h		;80a8
	call L_8ECC		;80ab
	ld hl,00000h		;80ae
	ld bc,00000h		;80b1
	xor a			;80b4
	call 0016bh		;80b5   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	call L_8EB6		;80b8
	ld hl,0f600h		;80bb
	ld bc,00080h		;80be
	ld a,0e0h		;80c1
	call 0016bh		;80c3   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	call L_8ED7		;80c6
	ret			;80c9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x80ca..0x80d2  (8 bytes)
DATA_80CA:
	defb 001h,062h,005h,0efh,006h,01fh,00bh,001h	; 80ca  .b......

; ======================================================================
; CODIGO 0x80d2..0x8107  (53 bytes)
; ======================================================================


L_80D2:
	ld a,(0e003h)		;80d2
	and a			;80d5
	jr nz,L_80DC		;80d6
	call L_8135		;80d8
	ret			;80db
L_80DC:
	call L_8ECC		;80dc
	ld hl,08107h		;80df
	call 072aeh		;80e2
	ld b,00fh		;80e5
	ld c,007h		;80e7
	call 00047h		;80e9   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;80ec
	ld bc,0a848h		;80ef
	xor a			;80f2
	ld d,001h		;80f3
	call L_8F41		;80f5
	call L_8163		;80f8
	call L_8EB6		;80fb
	ld hl,0e001h		;80fe
	ld (hl),031h		;8101
	inc hl			;8103
	ld (hl),000h		;8104
	ret			;8106

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8107..0x8117  (16 bytes)
DATA_8107:
	defb 000h,000h,000h,001h,070h,003h,002h,060h,001h,003h,044h,004h,00fh,077h,007h,0ffh	; 8107  ....p..`..D..w..

; ======================================================================
; CODIGO 0x8117..0x81db  (196 bytes)
; ======================================================================


L_8117:
	call 00156h		;8117   ; BIOS KILBUF - Clears keyboard buffer
L_811A:
	call L_8254		;811a
	jr z,L_812A		;811d
	ld b,001h		;811f
	ld hl,000e0h		;8121
	call 06756h		;8124
	ret nz			;8127
	jr L_811A		;8128
L_812A:
	ld b,001h		;812a
	ld hl,00000h		;812c
	call 06756h		;812f
	ret			;8132
L_8133:
	ret			;8133
L_8134:
	ret			;8134
L_8135:
	ld hl,00000h		;8135
	ld (0e001h),hl		;8138
	ld hl,09988h		;813b
	call 07336h		;813e
	ld hl,00b00h		;8141
	ld bc,003f0h		;8144
	xor a			;8147
	call 00056h		;8148   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;814b
	ld a,060h		;814e
	ld c,006h		;8150
	ld de,0000bh		;8152
L_8155:
	ld b,015h		;8155
L_8157:
	call 0004dh		;8157   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;815a
	inc a			;815b
	djnz L_8157		;815c
	add hl,de			;815e
	dec c			;815f
	jr nz,L_8155		;8160
	ret			;8162
L_8163:
	ld hl,09b6ah		;8163
	ld de,00800h		;8166
	ld bc,00d01h		;8169
	call L_8EE2		;816c
	ld hl,09bd2h		;816f
	ld de,07000h		;8172
	ld bc,00d02h		;8175
	call L_8EE2		;8178
	ld hl,09c3ah		;817b
	ld de,0d800h		;817e
	ld bc,01a03h		;8181
	call L_8EE2		;8184
	ld de,04040h		;8187
	ld hl,09b29h		;818a
	call L_82AA		;818d
	ret			;8190
L_8191:
	call L_81D2		;8191
	call L_819B		;8194
	call L_823D		;8197
	ret			;819a
L_819B:
	ld hl,02400h		;819b
	ld bc,00020h		;819e
	ld a,03fh		;81a1
	call 072fch		;81a3
	ld hl,02420h		;81a6
	ld bc,00020h		;81a9
	ld a,0fch		;81ac
	call 072fch		;81ae
	ld hl,081fch		;81b1
	ld de,00400h		;81b4
	call 07323h		;81b7
	ld hl,0820dh		;81ba
	ld de,02440h		;81bd
	ld bc,00030h		;81c0
	call 0730dh		;81c3
	ld hl,00440h		;81c6
	ld bc,00030h		;81c9
	ld a,0f0h		;81cc
	call 072fch		;81ce
	ret			;81d1
L_81D2:
	ld hl,081dbh		;81d2
	ld de,00000h		;81d5
	jp 07323h		;81d8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x81db..0x823d  (98 bytes)
DATA_81DB:
	defb 008h,000h,008h,011h,008h,022h,008h,033h,008h,044h,008h,055h,008h,066h,008h,077h	; 81db  .....".3.D.U.f.w
	defb 008h,088h,008h,099h,008h,0aah,008h,0bbh,008h,0cch,008h,0ddh,008h,0eeh,008h,0ffh	; 81eb  ................
	defb 000h,008h,0e0h,008h,07ah,008h,0dch,008h,046h,008h,0eah,008h,07ch,008h,0d6h,008h	; 81fb  ....z...F...|...
	defb 040h,000h,038h,044h,09ah,0a2h,09ah,044h,038h,000h,007h,06eh,07ch,079h,079h,06fh	; 820b  @.8D...D8..n|yyo
	defb 067h,000h,000h,000h,01ch,0b6h,0b6h,0b6h,01ch,000h,000h,000h,0f1h,0d8h,0d9h,0dbh	; 821b  g...............
	defb 0d9h,000h,000h,000h,0cfh,06dh,0edh,06dh,0edh,000h,006h,000h,0e6h,0b6h,0b6h,0b6h	; 822b  .....m.m........
	defb 0b6h,000h	; 823b

; ======================================================================
; CODIGO 0x823d..0x831b  (222 bytes)
; ======================================================================


L_823D:
	ld hl,0483fh		;823d
	ld de,02180h		;8240
	ld bc,00158h		;8243
	call 0730dh		;8246
	ld a,0f0h		;8249
	ld hl,00180h		;824b
	ld bc,00158h		;824e
	jp 072fch		;8251
L_8254:
	ld a,(0e003h)		;8254
	and a			;8257
	jr nz,L_828F		;8258
	ld bc,(0e001h)		;825a
	ld a,0ebh		;825e
	inc b			;8260
L_8261:
	add a,015h		;8261
	djnz L_8261		;8263
	ld l,a			;8265
	ld h,000h		;8266
	add hl,hl			;8268
	add hl,hl			;8269
	add hl,hl			;826a
	ld de,00b00h		;826b
	add hl,de			;826e
	ld a,c			;826f
	call 07251h		;8270
	ld b,015h		;8273
	ld de,00008h		;8275
	ld a,0f0h		;8278
L_827A:
	call 0004dh		;827a   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;827d
	djnz L_827A		;827e
	ld hl,0e001h		;8280
	ld a,(hl)			;8283
	inc a			;8284
	and 007h		;8285
	ld (hl),a			;8287
	ret nz			;8288
	inc hl			;8289
	inc (hl)			;828a
	ld a,(hl)			;828b
	cp 006h		;828c
	ret			;828e
L_828F:
	ld hl,0e001h		;828f
	dec (hl)			;8292
	jr nz,L_8297		;8293
	xor a			;8295
	ret			;8296
L_8297:
	ld a,031h		;8297
	sub (hl)			;8299
	ld c,a			;829a
	ld b,0a8h		;829b
	ld hl,02840h		;829d
	ld e,l			;82a0
	ld d,h			;82a1
	ld a,001h		;82a2
	call L_8E52		;82a4
	or 0ffh		;82a7
	ret			;82a9
L_82AA:
	push de			;82aa
L_82AB:
	ld a,(hl)			;82ab
	inc hl			;82ac
	ld c,a			;82ad
	inc a			;82ae
	jr z,L_82C8		;82af
	inc a			;82b1
	jr nz,L_82BF		;82b2
	pop de			;82b4
	ld a,(hl)			;82b5
	inc hl			;82b6
	add a,d			;82b7
	ld d,a			;82b8
	ld a,008h		;82b9
	add a,e			;82bb
	ld e,a			;82bc
	jr L_82AA		;82bd
L_82BF:
	ld a,c			;82bf
	call L_8E96		;82c0
	call L_903E		;82c3
	jr L_82AB		;82c6
L_82C8:
	pop de			;82c8
	ret			;82c9
L_82CA:
	ld a,(0e003h)		;82ca
	and a			;82cd
	jp nz,L_8692		;82ce
	call 072eah		;82d1
	ld hl,09de3h		;82d4
	ld de,02300h		;82d7
	call 07323h		;82da
	ld hl,0a1e3h		;82dd
	ld de,00300h		;82e0
	call 07323h		;82e3
	ld hl,0a32eh		;82e6
	ld de,01800h		;82e9
	call 0733ah		;82ec
	ld a,(0e009h)		;82ef
	and a			;82f2
	call nz,L_8D27		;82f3
	ld hl,08337h		;82f6
	ld de,038c2h		;82f9
	ld bc,00c0ah		;82fc
	call L_8457		;82ff
	ld hl,083afh		;8302
	ld de,038cfh		;8305
	ld bc,00c0eh		;8308
	call L_8457		;830b
	ld hl,0831bh		;830e
	ld de,03b00h		;8311
	ld bc,0001ch		;8314
	call 0005ch		;8317   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;831a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x831b..0x8457  (316 bytes)
DATA_831B:
	defb 04ch,024h,000h,004h,060h,018h,004h,004h,071h,020h,008h,004h,041h,040h,00ch,004h	; 831b  L$..`...q ..A@..
	defb 051h,04bh,010h,004h,05fh,055h,014h,004h,06fh,05bh,018h,004h,000h,000h,08ch,000h	; 832b  QK.._U..o[......
	defb 000h,000h,000h,000h,000h,000h,000h,08dh,08eh,08fh,090h,0a1h,0a2h,09ch,000h,000h	; 833b  ................
	defb 000h,000h,000h,091h,0a4h,0a5h,0a6h,0a3h,000h,000h,09dh,0c1h,0b1h,092h,0b0h,0a7h	; 834b  ................
	defb 0bbh,0bch,09fh,000h,093h,0bdh,0b2h,094h,085h,085h,0beh,0bfh,0a0h,000h,095h,0c0h	; 835b  ................
	defb 0b3h,096h,085h,085h,0afh,0a8h,097h,0eah,000h,0b4h,0bah,0c2h,0c2h,0c2h,0c2h,0c3h	; 836b  ................
	defb 0c4h,0e8h,000h,0c5h,0b5h,0b6h,085h,085h,0c6h,0c7h,0a9h,0e7h,000h,000h,0b7h,0b9h	; 837b  ................
	defb 085h,0c8h,0c9h,0cah,0cbh,0cch,000h,000h,0cdh,0b8h,0ceh,0cfh,0d0h,0d1h,0d2h,0d3h	; 838b  ................
	defb 000h,000h,09eh,0d4h,0d5h,0d5h,0d5h,0d5h,0d5h,0d6h,08bh,08bh,08bh,0d7h,0d8h,0d8h	; 839b  ................
	defb 0d8h,0d8h,0d9h,0dah,077h,078h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h	; 83ab  ....wxyyyyyyyyyy
	defb 07ah,07bh,07ch,086h,085h,085h,085h,085h,085h,085h,085h,085h,085h,085h,087h,07ch	; 83bb  z{|............|
	defb 07ch,086h,085h,085h,061h,062h,063h,062h,064h,065h,085h,085h,087h,07ch,07ch,086h	; 83cb  |...abcbde...||.
	defb 085h,085h,060h,060h,060h,060h,060h,060h,085h,085h,087h,07ch,07ch,086h,085h,0ebh	; 83db  ..``````...||...
	defb 085h,0ech,0edh,0eeh,0efh,085h,085h,085h,087h,07ch,07ch,086h,085h,085h,085h,085h	; 83eb  .........||.....
	defb 085h,085h,085h,085h,085h,085h,087h,07ch,07ch,086h,085h,066h,085h,06ch,06dh,06eh	; 83fb  .......||..f.lmn
	defb 06fh,070h,071h,085h,087h,07ch,07ch,086h,085h,085h,085h,085h,085h,085h,085h,085h	; 840b  opq..||.........
	defb 085h,085h,087h,07ch,07ch,086h,085h,066h,085h,073h,074h,075h,076h,085h,085h,085h	; 841b  ...||..f.stuv...
	defb 087h,07ch,07ch,088h,089h,089h,089h,089h,089h,089h,089h,089h,089h,089h,08ah,07ch	; 842b  .||............|
	defb 07dh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07fh,080h,081h	; 843b  }~~~~~~~~~~~~...
	defb 082h,082h,082h,082h,082h,082h,082h,082h,082h,082h,083h,084h	; 844b  ............

; ======================================================================
; CODIGO 0x8457..0x84d1  (122 bytes)
; ======================================================================


L_8457:
	push bc			;8457
	push hl			;8458
	ld b,000h		;8459
	push bc			;845b
	push de			;845c
	call 0005ch		;845d   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;8460
	ld bc,00020h		;8461
	add hl,bc			;8464
	ex de,hl			;8465
	pop bc			;8466
	pop hl			;8467
	add hl,bc			;8468
	pop bc			;8469
	djnz L_8457		;846a
	ret			;846c
L_846D:
	call 00156h		;846d   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;8470
	ld (0e010h),a		;8471
	ld (0e020h),a		;8474
L_8477:
	call L_84C8		;8477
	call 0009fh		;847a   ; BIOS CHGET - One character input (waiting)
	cp 020h		;847d
	jr z,L_848C		;847f
	call L_85CB		;8481
	call L_861A		;8484
	call L_84D9		;8487
	jr L_8477		;848a
L_848C:
	ld a,(0e010h)		;848c
	cp 002h		;848f
	jr z,L_8499		;8491
	ld a,(0e000h)		;8493
	inc a			;8496
	jr nz,L_8477		;8497
L_8499:
	ld a,(0e003h)		;8499
	and a			;849c
	jp nz,L_87D4		;849d
	ld hl,085eah		;84a0
	ld de,038c4h		;84a3
	ld bc,00608h		;84a6
	call L_8457		;84a9
	ld hl,084d1h		;84ac
	ld de,03b0ch		;84af
	ld bc,00008h		;84b2
	call 0005ch		;84b5   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0e008h		;84b8
	ld (hl),032h		;84bb
L_84BD:
	ld a,(hl)			;84bd
	and a			;84be
	jr nz,L_84BD		;84bf
	call L_8013		;84c1
	ld a,(0e010h)		;84c4
	ret			;84c7
L_84C8:
	call L_84FA		;84c8
	call 0009ch		;84cb   ; BIOS CHSNS - Tests the status of the keyboard buffer
	jr z,L_84C8		;84ce
	ret			;84d0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x84d1..0x84d9  (8 bytes)
DATA_84D1:
	defb 041h,040h,01ch,004h,051h,04bh,020h,004h	; 84d1  A@..QK .

; ======================================================================
; CODIGO 0x84d9..0x84f3  (26 bytes)
; ======================================================================


L_84D9:
	ld a,(0e003h)		;84d9
	and a			;84dc
	ret z			;84dd
	ld hl,0e020h		;84de
	ld a,(hl)			;84e1
	ld (hl),001h		;84e2
	and a			;84e4
	ld c,000h		;84e5
	jr z,L_84EB		;84e7
	ld c,003h		;84e9
L_84EB:
	ld a,c			;84eb
	ld (0e021h),a		;84ec
	call L_8EC1		;84ef
	ret			;84f2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x84f3..0x84fa  (7 bytes)
DATA_84F3:
	defb 03eh,004h,032h,021h,0e0h,018h,013h	; 84f3

; ======================================================================
; CODIGO 0x84fa..0x8560  (102 bytes)
; ======================================================================


L_84FA:
	ld a,(0e003h)		;84fa
	and a			;84fd
	ret z			;84fe
	ld a,(0e020h)		;84ff
	and a			;8502
	ret z			;8503
	ld a,(0e008h)		;8504
	ld hl,0e022h		;8507
	cp (hl)			;850a
	ret z			;850b
	ld (hl),a			;850c
	ld a,(0e010h)		;850d
	add a,a			;8510
	ld hl,08568h		;8511
	call 07251h		;8514
	ld e,(hl)			;8517
	inc hl			;8518
	ld d,(hl)			;8519
	ld a,(de)			;851a
	ld c,a			;851b
	inc de			;851c
	ld hl,0e021h		;851d
	ld a,(hl)			;8520
	inc (hl)			;8521
	ld hl,08560h		;8522
	call 07251h		;8525
	ld a,(hl)			;8528
	cp 0ffh		;8529
	jr z,L_8550		;852b
	add a,a			;852d
	ld b,a			;852e
	add a,a			;852f
	add a,b			;8530
	call 07256h		;8531
	ld hl,0f600h		;8534
	call 00171h		;8537   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	ld l,c			;853a
	ld a,(00007h)		;853b
	ld c,a			;853e
	ld b,003h		;853f
L_8541:
	ld a,(de)			;8541
	out (c),a		;8542
	inc de			;8544
	ld a,(de)			;8545
	out (c),a		;8546
	inc de			;8548
	out (c),l		;8549
	out (c),a		;854b
	djnz L_8541		;854d
	ret			;854f
L_8550:
	xor a			;8550
	ld (0e020h),a		;8551
	ld hl,0f600h		;8554
	ld bc,0000ch		;8557
	ld a,0e0h		;855a
	call 0016bh		;855c   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ret			;855f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8560..0x85cb  (107 bytes)
DATA_8560:
	defb 000h,001h,002h,002h,002h,003h,004h,0ffh,06eh,085h,08dh,085h,0ach,085h,000h,0e0h	; 8560  ........n.......
	defb 000h,0e0h,000h,05bh,060h,0e0h,000h,05bh,060h,057h,070h,05bh,060h,057h,070h,053h	; 8570  ...[`..[`Wp[`WpS
	defb 080h,057h,070h,053h,080h,0e0h,000h,053h,080h,0e0h,000h,0e0h,000h,004h,0e0h,000h	; 8580  .WpS...S........
	defb 0e0h,000h,05eh,060h,0e0h,000h,05eh,060h,060h,070h,05eh,060h,060h,070h,062h,080h	; 8590  ..^`..^``p^``pb.
	defb 060h,070h,062h,080h,0e0h,000h,062h,080h,0e0h,000h,0e0h,000h,008h,0e0h,000h,0e0h	; 85a0  `pb...b.........
	defb 000h,05eh,060h,0e0h,000h,05eh,060h,066h,070h,05eh,060h,066h,070h,06eh,080h,066h	; 85b0  .^`..^`fp^`fpn.f
	defb 070h,06eh,080h,0e0h,000h,06eh,080h,0e0h,000h,0e0h,000h	; 85c0  pn...n.....

; ======================================================================
; CODIGO 0x85cb..0x85ea  (31 bytes)
; ======================================================================


L_85CB:
	cp 01eh		;85cb
	jr z,L_85DF		;85cd
	cp 01fh		;85cf
	jr z,L_85D4		;85d1
	ret			;85d3
L_85D4:
	ld hl,0e010h		;85d4
	inc (hl)			;85d7
	ld a,(hl)			;85d8
	cp 003h		;85d9
	ret c			;85db
	ld (hl),000h		;85dc
	ret			;85de
L_85DF:
	ld hl,0e010h		;85df
	dec (hl)			;85e2
	ld a,(hl)			;85e3
	cp 003h		;85e4
	ret c			;85e6
	ld (hl),002h		;85e7
	ret			;85e9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x85ea..0x861a  (48 bytes)
DATA_85EA:
	defb 08ch,000h,000h,000h,000h,000h,000h,000h,08eh,08fh,0dbh,0dch,0ddh,09ch,000h,000h	; 85ea  ................
	defb 0dfh,091h,0aah,0abh,0ach,0a3h,000h,000h,0b1h,0aeh,0adh,0e0h,0e1h,0e2h,000h,000h	; 85fa  ................
	defb 0b2h,094h,0e3h,0e4h,0e5h,0e6h,09ah,000h,0b3h,096h,085h,085h,0afh,0a8h,09bh,0eah	; 860a  ................

; ======================================================================
; CODIGO 0x861a..0x864c  (50 bytes)
; ======================================================================


L_861A:
	ld a,(0e003h)		;861a
	and a			;861d
	jp nz,L_879B		;861e
	ld a,(0e010h)		;8621
	add a,a			;8624
	ld hl,0868ch		;8625
	call 07251h		;8628
	ld de,0396ah		;862b
	ld bc,00002h		;862e
	call 0005ch		;8631   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0864ch		;8634
	call 0738fh		;8637
	ld a,(0e010h)		;863a
	add a,a			;863d
	ld hl,08669h		;863e
	call 07251h		;8641
	ld e,(hl)			;8644
	inc hl			;8645
	ld d,(hl)			;8646
	ex de,hl			;8647
	call 0738fh		;8648
	ret			;864b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x864c..0x8692  (70 bytes)
DATA_864C:
	defb 052h,039h,066h,085h,067h,068h,069h,06ah,0feh,092h,039h,066h,085h,06ch,06dh,06eh	; 864c  R9f.ghij..9f.lmn
	defb 06fh,070h,071h,0feh,0d2h,039h,066h,085h,073h,074h,075h,076h,0ffh,06fh,086h,078h	; 865c  opq..9f.stuv.o.x
	defb 086h,083h,086h,052h,039h,0ebh,085h,0ech,0edh,0eeh,0efh,0ffh,092h,039h,0ebh,085h	; 866c  ...R9........9..
	defb 0f1h,0f2h,0f3h,0f4h,0f5h,0f6h,0ffh,0d2h,039h,0ebh,085h,0f8h,0f9h,0fah,0fbh,0ffh	; 867c  ........9.......
	defb 097h,0eah,098h,0eah,099h,0e9h	; 868c

; ======================================================================
; CODIGO 0x8692..0x8706  (116 bytes)
; ======================================================================


L_8692:
	call L_8ECC		;8692
	call L_86A8		;8695
	call L_86F8		;8698
	call L_8731		;869b
	call L_86B3		;869e
	call L_86C8		;86a1
	call L_8EB6		;86a4
	ret			;86a7
L_86A8:
	ld hl,00000h		;86a8
	ld bc,08000h		;86ab
	xor a			;86ae
	call 0016bh		;86af   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ret			;86b2
L_86B3:
	ld hl,09d0ah		;86b3
	ld de,0f800h		;86b6
	call 0733ah		;86b9
	ld hl,0f400h		;86bc
	ld bc,00030h		;86bf
	ld a,00bh		;86c2
	call 0016bh		;86c4   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ret			;86c7
L_86C8:
	ld hl,09828h		;86c8
	ld de,01030h		;86cb
	ld bc,00a0ch		;86ce
	call L_86E1		;86d1
	ld hl,098a0h		;86d4
	ld de,07830h		;86d7
	ld bc,00e0ch		;86da
	call L_86E1		;86dd
	ret			;86e0
L_86E1:
	push bc			;86e1
	push de			;86e2
L_86E3:
	ld a,(hl)			;86e3
	inc hl			;86e4
	call L_8F7D		;86e5
	ld a,008h		;86e8
	add a,d			;86ea
	ld d,a			;86eb
	djnz L_86E3		;86ec
	pop de			;86ee
	ld a,008h		;86ef
	add a,e			;86f1
	ld e,a			;86f2
	pop bc			;86f3
	dec c			;86f4
	jr nz,L_86E1		;86f5
	ret			;86f7
L_86F8:
	ld b,00dh		;86f8
	ld c,007h		;86fa
	call 00047h		;86fc   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,08706h		;86ff
	call 072aeh		;8702
	ret			;8705

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8706..0x8731  (43 bytes)
DATA_8706:
	defb 000h,000h,000h,001h,000h,000h,002h,011h,001h,003h,033h,003h,004h,055h,005h,005h	; 8706  ..........3..U..
	defb 077h,007h,006h,040h,000h,007h,037h,006h,008h,060h,000h,009h,071h,003h,00ah,070h	; 8716  w..@..7..`..q..p
	defb 005h,00bh,070h,007h,00ch,073h,007h,00dh,007h,000h,0ffh	; 8726  ..p..s.....

; ======================================================================
; CODIGO 0x8731..0x87f8  (199 bytes)
; ======================================================================


L_8731:
	ld de,0a580h		;8731
	ld hl,08c00h		;8734
	call L_8744		;8737
	ld de,0a390h		;873a
	ld hl,08800h		;873d
	call L_8744		;8740
	ret			;8743
L_8744:
	call 00171h		;8744   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	ld a,(00007h)		;8747
	exx			;874a
	ld c,a			;874b
	exx			;874c
	ld c,000h		;874d
L_874F:
	ld a,(de)			;874f
	and 07fh		;8750
	ret z			;8752
	ld b,a			;8753
	ld a,(de)			;8754
	add a,a			;8755
	inc de			;8756
	jr nc,L_8766		;8757
L_8759:
	ld a,(de)			;8759
	inc de			;875a
	exx			;875b
	out (c),a		;875c
	exx			;875e
	call L_8775		;875f
	djnz L_8759		;8762
	jr L_874F		;8764
L_8766:
	ld a,(de)			;8766
	inc de			;8767
L_8768:
	exx			;8768
	out (c),a		;8769
	exx			;876b
	push af			;876c
	call L_8775		;876d
	pop af			;8770
	djnz L_8768		;8771
	jr L_874F		;8773
L_8775:
	inc c			;8775
	ld a,c			;8776
	and 01fh		;8777
	jr z,L_8789		;8779
	and 003h		;877b
	ret nz			;877d
	ld a,080h		;877e
	add a,l			;8780
	ld l,a			;8781
	jp nc,00171h		;8782   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	inc h			;8785
	jp 00171h		;8786   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_8789:
	push de			;8789
	ld de,0fc84h		;878a
	add hl,de			;878d
	ld a,l			;878e
	cp 080h		;878f
	jr nz,L_8797		;8791
	ld de,00380h		;8793
	add hl,de			;8796
L_8797:
	pop de			;8797
	jp 00171h		;8798   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_879B:
	ld a,(0e010h)		;879b
	add a,a			;879e
	ld hl,08840h		;879f
	call 07251h		;87a2
	ld de,05058h		;87a5
	ld bc,00102h		;87a8
	call L_86E1		;87ab
	ld hl,08818h		;87ae
	ld de,09050h		;87b1
	ld bc,00805h		;87b4
	call L_86E1		;87b7
	ld hl,087f8h		;87ba
	ld a,(0e010h)		;87bd
	add a,a			;87c0
	call 07251h		;87c1
	ld e,(hl)			;87c4
	inc hl			;87c5
	ld d,(hl)			;87c6
	ex de,hl			;87c7
	ld e,(hl)			;87c8
	inc hl			;87c9
	ld b,(hl)			;87ca
	inc hl			;87cb
	ld c,001h		;87cc
	ld d,090h		;87ce
	call L_86E1		;87d0
	ret			;87d3
L_87D4:
	ld hl,09948h		;87d4
	ld de,02038h		;87d7
	ld bc,00808h		;87da
	call L_86E1		;87dd
	call L_84D9		;87e0
	ld a,032h		;87e3
	ld (0e008h),a		;87e5
L_87E8:
	call L_84FA		;87e8
	ld a,(0e008h)		;87eb
	and a			;87ee
	jr nz,L_87E8		;87ef
	call L_8013		;87f1
	ld a,(0e010h)		;87f4
	ret			;87f7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x87f8..0x8846  (78 bytes)
DATA_87F8:
	defb 0feh,087h,006h,088h,010h,088h,050h,006h,040h,073h,041h,042h,043h,044h,060h,008h	; 87f8  ......P.@sABCD`.
	defb 045h,073h,046h,047h,048h,049h,04ah,04bh,070h,006h,04ch,073h,04dh,04eh,04fh,050h	; 8808  EsFGHIJKp.LsMNOP
	defb 07ah,073h,07bh,07ch,07dh,07eh,073h,073h,073h,073h,073h,073h,073h,073h,073h,073h	; 8818  zs{|}~ssssssssss
	defb 07fh,073h,080h,081h,082h,083h,084h,085h,073h,073h,073h,073h,073h,073h,073h,073h	; 8828  .s......ssssssss
	defb 086h,073h,087h,088h,089h,08ah,073h,073h,0b1h,0bah,0dch,0ddh,0deh,0dfh	; 8838  .s....ss......

; ======================================================================
; CODIGO 0x8846..0x88a0  (90 bytes)
; ======================================================================


L_8846:
	ld a,(0e009h)		;8846
	and a			;8849
	ret nz			;884a
	ld a,(0e003h)		;884b
	and a			;884e
	jp nz,L_8B20		;884f
	call L_8894		;8852
	call 072eah		;8855
	ld hl,09048h		;8858
	ld de,02008h		;885b
	call 07323h		;885e
	ld hl,0953ah		;8861
	ld de,00008h		;8864
	call 07323h		;8867
	ld hl,09d2dh		;886a
	ld de,01800h		;886d
	call 0733ah		;8870
	ld de,03800h		;8873
	ld hl,08900h		;8876
	ld bc,00220h		;8879
	call 0005ch		;887c   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,088c0h		;887f
	ld de,03b00h		;8882
	ld bc,00040h		;8885
	call 0005ch		;8888   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,088a0h		;888b
	call 0738fh		;888e
	call L_8B32		;8891
L_8894:
	ld a,0e0h		;8894
	ld hl,03b00h		;8896
	ld bc,00080h		;8899
	call 00056h		;889c   ; BIOS FILVRM - Fills VRAM with value
	ret			;889f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x88a0..0x8b20  (640 bytes)
DATA_88A0:
	defb 04ah,03ah,0c3h,0c4h,0c5h,0c6h,0c7h,0c8h,0c9h,000h,0cah,0cbh,0cch,0cch,0feh,0a9h	; 88a0  J:..............
	defb 03ah,0cdh,0ceh,0cfh,0d0h,000h,0cfh,0cdh,0c7h,0d1h,0d2h,000h,0c4h,0d2h,0d3h,0ffh	; 88b0  :...............
	defb 017h,050h,000h,004h,027h,030h,004h,006h,037h,030h,008h,006h,047h,030h,00ch,004h	; 88c0  .P..'0..70..G0..
	defb 057h,030h,010h,004h,057h,020h,014h,004h,067h,020h,018h,006h,077h,020h,01ch,006h	; 88d0  W0..W ..g ..w ..
	defb 00fh,0a0h,020h,004h,027h,0c0h,024h,006h,037h,0c0h,028h,006h,047h,0c0h,02ch,004h	; 88e0  .. .'.$.7.(.G.,.
	defb 057h,0c0h,030h,004h,057h,0d0h,034h,004h,067h,0d0h,038h,006h,077h,0d0h,03ch,006h	; 88f0  W.0.W.4.g.8.w.<.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8900  ................
	defb 000h,000h,000h,009h,002h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8910  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h	; 8920  ................
	defb 003h,004h,005h,006h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8930  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,003h,00ah,00bh,00ch	; 8940  ................
	defb 00dh,00eh,00fh,010h,011h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8950  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,012h,013h,014h,015h,016h,017h	; 8960  ................
	defb 018h,019h,01ah,01bh,01ch,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8970  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,01dh,01eh,01fh,020h,021h,022h	; 8980  ............. !"
	defb 023h,024h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8990  #$%.............
	defb 0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,026h,027h,028h,029h,02ah,0c2h	; 89a0  ..........&'()*.
	defb 0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 89b0  ................
	defb 0bch,0c2h,0bdh,0beh,0bch,0c2h,02bh,02ch,02dh,02eh,02eh,02eh,02eh,02eh,02eh,02eh	; 89c0  ......+,-.......
	defb 02eh,02eh,02eh,02eh,02eh,02eh,02eh,02fh,030h,02bh,0c2h,0bfh,0c1h,0c0h,0c2h,0bfh	; 89d0  ......./0+......
	defb 0c2h,0bdh,0beh,0bch,0c2h,0c2h,031h,032h,033h,034h,035h,036h,037h,038h,039h,03ah	; 89e0  ......123456789:
	defb 03bh,03ch,03dh,03eh,03fh,040h,041h,042h,043h,044h,0c2h,0c2h,0bfh,0c1h,0c0h,0c2h	; 89f0  .<=>?@ABCD......
	defb 0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,045h,046h,034h,047h,048h,049h,04ah,04bh,04ch,03ah	; 8a00  ......EF4GHIJKL:
	defb 04dh,04eh,04fh,050h,051h,052h,053h,034h,054h,055h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 8a10  MNOPQRS4TU......
	defb 000h,000h,000h,000h,000h,000h,056h,057h,034h,058h,059h,05ah,05bh,05ch,05dh,03ah	; 8a20  ......VW4XYZ[\]:
	defb 04dh,04eh,05eh,05fh,060h,061h,062h,034h,063h,064h,000h,000h,000h,000h,000h,000h	; 8a30  MN^_`ab4cd......
	defb 000h,000h,000h,000h,000h,000h,042h,065h,044h,066h,067h,068h,069h,06ah,05dh,03ah	; 8a40  ......BeDfghij]:
	defb 06bh,06ch,06dh,03ah,06eh,06fh,070h,031h,071h,033h,000h,000h,000h,000h,000h,000h	; 8a50  klm:nop1q3......
	defb 000h,000h,000h,000h,072h,073h,074h,075h,076h,074h,074h,074h,074h,077h,078h,074h	; 8a60  ....rstuvttttwxt
	defb 079h,074h,07ah,074h,074h,074h,074h,07bh,07ch,074h,07dh,07eh,000h,000h,000h,000h	; 8a70  ytztttt{|t}~....
	defb 000h,000h,000h,000h,07fh,033h,080h,081h,04bh,082h,083h,083h,084h,085h,086h,087h	; 8a80  .....3..K.......
	defb 04dh,034h,088h,089h,08ah,08bh,08ch,08dh,08eh,08fh,042h,090h,000h,000h,000h,000h	; 8a90  M4........B.....
	defb 0c2h,0c2h,0c2h,0c2h,091h,092h,034h,093h,085h,094h,095h,095h,096h,085h,097h,098h	; 8aa0  ......4.........
	defb 099h,034h,09ah,09bh,09ch,09dh,09eh,09fh,0a0h,0a1h,0a2h,0a3h,0c2h,0c2h,0c2h,0c2h	; 8ab0  .4..............
	defb 0c2h,0bfh,0c1h,0c0h,0a4h,0a5h,0a6h,0a7h,0a8h,0a9h,034h,034h,034h,0aah,0abh,034h	; 8ac0  ..........444..4
	defb 0ach,0adh,0aeh,058h,0afh,0b0h,0b1h,0b2h,0b3h,0b4h,0b5h,0b6h,0bdh,0beh,0bch,0c2h	; 8ad0  ...X............
	defb 0c0h,0c2h,0bfh,0c1h,0b7h,0b8h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h	; 8ae0  ................
	defb 0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0b9h,0bah,0bbh,0beh,0bch,0c2h,0bdh	; 8af0  ................
	defb 0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 8b00  ................
	defb 0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 8b10  ................

; ======================================================================
; CODIGO 0x8b20..0x8b9c  (124 bytes)
; ======================================================================


L_8B20:
	call L_8ECC		;8b20
	call L_86A8		;8b23
	call L_8B8E		;8b26
	call L_8B3D		;8b29
	call L_8B51		;8b2c
	call L_8EB6		;8b2f
L_8B32:
	call 00156h		;8b32   ; BIOS KILBUF - Clears keyboard buffer
L_8B35:
	call 0009fh		;8b35   ; BIOS CHGET - One character input (waiting)
	cp 020h		;8b38
	jr nz,L_8B35		;8b3a
	ret			;8b3c
L_8B3D:
	ld a,00bh		;8b3d
	ld (0a000h),a		;8b3f
	ld de,0a000h		;8b42
	ld hl,08004h		;8b45
	call L_8744		;8b48
	ld a,00ah		;8b4b
	ld (0a000h),a		;8b4d
	ret			;8b50
L_8B51:
	ld hl,08bcdh		;8b51
	ld de,06008h		;8b54
	ld bc,00804h		;8b57
	call L_86E1		;8b5a
	ld hl,08bedh		;8b5d
	ld de,00028h		;8b60
	ld bc,02008h		;8b63
	call L_86E1		;8b66
	ld hl,08cedh		;8b69
	ld de,06068h		;8b6c
	ld bc,00804h		;8b6f
	call L_86E1		;8b72
	ld hl,08d0dh		;8b75
	ld de,05088h		;8b78
	ld bc,00c01h		;8b7b
	call L_86E1		;8b7e
	ld hl,08d19h		;8b81
	ld de,048a0h		;8b84
	ld bc,00e01h		;8b87
	call L_86E1		;8b8a
	ret			;8b8d
L_8B8E:
	ld b,004h		;8b8e
	ld c,007h		;8b90
	call 00047h		;8b92   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,08b9ch		;8b95
	call 072aeh		;8b98
	ret			;8b9b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8b9c..0x8d27  (395 bytes)
DATA_8B9C:
	defb 000h,000h,000h,001h,000h,000h,002h,055h,000h,003h,077h,000h,004h,005h,000h,005h	; 8b9c  .......U..w.....
	defb 047h,005h,006h,000h,003h,007h,000h,007h,008h,033h,007h,009h,050h,000h,00ah,000h	; 8bac  G........3..P...
	defb 000h,00bh,060h,004h,00ch,063h,007h,00dh,074h,003h,00eh,062h,007h,00fh,077h,007h	; 8bbc  ..`..c..t..b..w.
	defb 0ffh,000h,000h,000h,040h,041h,000h,000h,000h,000h,000h,042h,043h,044h,045h,000h	; 8bcc  ....@A.....BCDE.
	defb 000h,000h,046h,047h,048h,049h,04ah,04bh,000h,04ch,04dh,04eh,04fh,050h,051h,052h	; 8bdc  ..FGHIJK.LMNOPQR
	defb 053h,001h,002h,003h,004h,005h,001h,002h,003h,004h,005h,054h,055h,056h,057h,058h	; 8bec  S..........TUVWX
	defb 059h,05ah,05bh,05ch,05dh,05eh,05fh,010h,011h,012h,002h,013h,010h,011h,012h,002h	; 8bfc  YZ[\]^_.........
	defb 013h,006h,007h,008h,009h,00ah,006h,007h,008h,009h,00ah,060h,061h,062h,063h,064h	; 8c0c  ...........`abcd
	defb 065h,066h,067h,068h,069h,06ah,06bh,014h,015h,016h,017h,018h,014h,015h,016h,017h	; 8c1c  efghijk.........
	defb 018h,00bh,00ch,00dh,00eh,00fh,00bh,00ch,00dh,00eh,06ch,06dh,06eh,06fh,070h,071h	; 8c2c  ..........lmnopq
	defb 072h,073h,074h,075h,076h,077h,078h,079h,019h,01ah,01bh,01ch,01dh,019h,01ah,01bh	; 8c3c  rstuvwxy........
	defb 01ch,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,07ah,07bh,07ch,07dh,07eh,07fh	; 8c4c  ..........z{|}~.
	defb 080h,081h,082h,083h,084h,085h,086h,087h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h	; 8c5c  ................
	defb 0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,088h,089h,08ah,08bh,08ch,08dh	; 8c6c  ................
	defb 08eh,08fh,090h,091h,092h,093h,094h,095h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h	; 8c7c  ................
	defb 0d0h,01eh,01fh,020h,021h,022h,01eh,01fh,020h,021h,096h,097h,098h,099h,09ah,09bh	; 8c8c  ... !".. !......
	defb 09ch,09dh,09eh,09fh,0a0h,0a1h,0a2h,0a3h,02dh,02eh,02fh,030h,031h,02dh,02eh,02fh	; 8c9c  ........-./01-./
	defb 030h,023h,024h,025h,026h,027h,023h,024h,025h,026h,0a4h,0a5h,0a6h,0a7h,0a8h,0a9h	; 8cac  0#$%&'#$%&......
	defb 0aah,0abh,0ach,0adh,0aeh,0afh,0b0h,0b1h,032h,033h,034h,035h,036h,032h,033h,034h	; 8cbc  ........23456234
	defb 035h,028h,029h,02ah,02bh,02ch,028h,029h,02ah,02bh,02ch,028h,0b2h,0b3h,0b4h,0b5h	; 8ccc  5()*+,()*+,(....
	defb 0b6h,0b6h,0b8h,0b9h,0bah,0bbh,037h,038h,039h,03ah,029h,037h,038h,039h,03ah,029h	; 8cdc  ......789:)789:)
	defb 037h,0bch,0bdh,0beh,0b6h,0b6h,0c1h,0c2h,0c3h,000h,0c4h,0c5h,0c6h,0c7h,0c8h,0c9h	; 8cec  7...............
	defb 000h,000h,000h,0cah,0cbh,0cch,0cdh,000h,000h,000h,000h,000h,0ceh,0cfh,000h,000h	; 8cfc  ................
	defb 000h,0d1h,0d2h,0d3h,0d4h,0d5h,0d6h,0d7h,000h,0d8h,0d9h,0dah,0dah,0dbh,0dch,0ddh	; 8d0c  ................
	defb 0deh,000h,0ddh,0dbh,0d5h,0dfh,0e0h,000h,0d2h,0e0h,0e1h	; 8d1c  ...........

; ======================================================================
; CODIGO 0x8d27..0x8d74  (77 bytes)
; ======================================================================


L_8D27:
	call L_823D		;8d27
	ld hl,08de6h		;8d2a
	ld de,03080h		;8d2d
	ld bc,00008h		;8d30
	call 0005ch		;8d33   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,0f0h		;8d36
	ld hl,01080h		;8d38
	ld bc,00008h		;8d3b
	call 00056h		;8d3e   ; BIOS FILVRM - Fills VRAM with value
	ld a,0f0h		;8d41
	ld hl,00080h		;8d43
	ld bc,00200h		;8d46
	call 00056h		;8d49   ; BIOS FILVRM - Fills VRAM with value
	ld de,02080h		;8d4c
	ld hl,0b460h		;8d4f
	call 0733ah		;8d52
	ld hl,08d99h		;8d55
	ld de,03844h		;8d58
	ld bc,00319h		;8d5b
	call L_8D83		;8d5e
	ld hl,08de4h		;8d61
	ld de,038bch		;8d64
	ld bc,00102h		;8d67
	call L_8D83		;8d6a
	ld hl,08d74h		;8d6d
	call 0738fh		;8d70
	ret			;8d73

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d74..0x8d83  (15 bytes)
DATA_8D74:
	defb 06ah,03ah,010h,04bh,04fh,04eh,041h,04dh,049h,000h,031h,039h,038h,038h,0ffh	; 8d74  j:.KONAMI.1988.

; ======================================================================
; CODIGO 0x8d83..0x8d99  (22 bytes)
; ======================================================================


L_8D83:
	push bc			;8d83
	push hl			;8d84
	ld b,000h		;8d85
	push bc			;8d87
	push de			;8d88
	call 0005ch		;8d89   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;8d8c
	ld bc,00020h		;8d8d
	add hl,bc			;8d90
	ex de,hl			;8d91
	pop bc			;8d92
	pop hl			;8d93
	add hl,bc			;8d94
	pop bc			;8d95
	djnz L_8D83		;8d96
	ret			;8d98

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d99..0x8dee  (85 bytes)
DATA_8D99:
	defb 010h,011h,012h,013h,014h,015h,016h,013h,017h,02ah,015h,02bh,02ch,02dh,010h,02eh	; 8d99  .........*.+,-..
	defb 013h,011h,013h,02fh,013h,030h,000h,04ah,04bh,018h,019h,01ah,01bh,01ch,01dh,01eh	; 8da9  .../.0.JK.......
	defb 01fh,020h,031h,01dh,027h,032h,033h,034h,035h,036h,037h,038h,039h,038h,03ah,03bh	; 8db9  . 1.'234567898:.
	defb 04ch,04dh,021h,022h,023h,024h,025h,026h,027h,028h,029h,03ch,021h,03dh,03eh,03fh	; 8dc9  LM!"#$%&'()<!=>?
	defb 040h,041h,03ch,042h,043h,044h,045h,046h,047h,04eh,04fh,048h,049h,000h,01ch,022h	; 8dd9  @A<BCDEFGNOHI.."
	defb 049h,051h,049h,022h,01ch	; 8de9

; ======================================================================
; CODIGO 0x8dee..0x8fed  (511 bytes)
; ======================================================================


L_8DEE:
	ex de,hl			;8dee
	ld a,c			;8def
	or a			;8df0
	ld a,b			;8df1
	ld b,c			;8df2
	ret z			;8df3
	inc a			;8df4
	ret			;8df5
L_8DF6:
	ex de,hl			;8df6
	call L_8E09		;8df7
	call L_8DEE		;8dfa
	ex af,af'			;8dfd
	ld a,(00007h)		;8dfe
	ld c,a			;8e01
	ex af,af'			;8e02
L_8E03:
	otir		;8e03
	dec a			;8e05
	jr nz,L_8E03		;8e06
	ret			;8e08
L_8E09:
	push bc			;8e09
	ld a,(00007h)		;8e0a
	inc a			;8e0d
	ld c,a			;8e0e
	ld a,h			;8e0f
	rlca			;8e10
	rlca			;8e11
	and 003h		;8e12
	di			;8e14
	out (c),a		;8e15
	ld a,08eh		;8e17
	out (c),a		;8e19
	ld a,l			;8e1b
	out (c),a		;8e1c
	ld a,h			;8e1e
	and 03fh		;8e1f
	or 040h		;8e21
	out (c),a		;8e23
	pop bc			;8e25
	ei			;8e26
	ret			;8e27
L_8E28:
	ld a,002h		;8e28
	call L_8E32		;8e2a
	rra			;8e2d
	jp c,L_8E28		;8e2e
	ret			;8e31
L_8E32:
	push bc			;8e32
	push hl			;8e33
	ld hl,(00006h)		;8e34
	inc h			;8e37
	inc l			;8e38
	ld c,h			;8e39
	di			;8e3a
	out (c),a		;8e3b
	ld a,08fh		;8e3d
	out (c),a		;8e3f
	ld c,l			;8e41
	in a,(c)		;8e42
	push af			;8e44
	xor a			;8e45
	ld c,h			;8e46
	out (c),a		;8e47
	ld a,08fh		;8e49
	out (c),a		;8e4b
	pop af			;8e4d
	pop hl			;8e4e
	pop bc			;8e4f
	ei			;8e50
	ret			;8e51
L_8E52:
	ex af,af'			;8e52
	call L_8E28		;8e53
	push bc			;8e56
	ld a,(00007h)		;8e57
	inc a			;8e5a
	ld c,a			;8e5b
	ld a,020h		;8e5c
	di			;8e5e
	out (c),a		;8e5f
	ld a,091h		;8e61
	out (c),a		;8e63
	inc c			;8e65
	inc c			;8e66
	out (c),h		;8e67
	xor a			;8e69
	out (c),a		;8e6a
	out (c),l		;8e6c
	ex af,af'			;8e6e
	ld l,a			;8e6f
	and 003h		;8e70
	out (c),a		;8e72
	out (c),d		;8e74
	xor a			;8e76
	out (c),a		;8e77
	out (c),e		;8e79
	ld a,l			;8e7b
	rra			;8e7c
	rra			;8e7d
	and 003h		;8e7e
	out (c),a		;8e80
	pop hl			;8e82
	out (c),h		;8e83
	xor a			;8e85
	out (c),a		;8e86
	out (c),l		;8e88
	out (c),a		;8e8a
	out (c),a		;8e8c
	out (c),a		;8e8e
	ld a,0d0h		;8e90
	out (c),a		;8e92
	ei			;8e94
	ret			;8e95
L_8E96:
	push bc			;8e96
	push hl			;8e97
	push de			;8e98
	call L_8EA8		;8e99
	ld bc,00808h		;8e9c
	ld a,005h		;8e9f
	call L_8E52		;8ea1
	pop de			;8ea4
	pop hl			;8ea5
	pop bc			;8ea6
	ret			;8ea7
L_8EA8:
	ld b,a			;8ea8
	and 01fh		;8ea9
	add a,a			;8eab
	add a,a			;8eac
	add a,a			;8ead
	ld h,a			;8eae
	ld a,b			;8eaf
	and 0e0h		;8eb0
	rrca			;8eb2
	rrca			;8eb3
	ld l,a			;8eb4
	ret			;8eb5
L_8EB6:
	ld a,(0f3e0h)		;8eb6
	or 040h		;8eb9
	ld b,a			;8ebb
	ld c,001h		;8ebc
	call 00047h		;8ebe   ; BIOS WRTVDP - Writes data in the VDP-register
L_8EC1:
	ld a,(0ffe7h)		;8ec1
	and 0fdh		;8ec4
	ld b,a			;8ec6
	ld c,008h		;8ec7
	jp 00047h		;8ec9   ; BIOS WRTVDP - Writes data in the VDP-register
L_8ECC:
	ld a,(0f3e0h)		;8ecc
	and 0bfh		;8ecf
	ld b,a			;8ed1
	ld c,001h		;8ed2
	call 00047h		;8ed4   ; BIOS WRTVDP - Writes data in the VDP-register
L_8ED7:
	ld a,(0ffe7h)		;8ed7
	or 002h		;8eda
	ld b,a			;8edc
	ld c,008h		;8edd
	jp 00047h		;8edf   ; BIOS WRTVDP - Writes data in the VDP-register
L_8EE2:
	call L_8EEB		;8ee2
	call L_903E		;8ee5
	djnz L_8EE2		;8ee8
	ret			;8eea
L_8EEB:
	push bc			;8eeb
	push de			;8eec
	push hl			;8eed
	push de			;8eee
	call L_8F1B		;8eef
	pop de			;8ef2
	ld b,d			;8ef3
	ld d,e			;8ef4
	ld e,b			;8ef5
	srl d		;8ef6
	rr e		;8ef8
	ld a,d			;8efa
	add a,080h		;8efb
	ld d,a			;8efd
	ld hl,0e100h		;8efe
	ld b,008h		;8f01
L_8F03:
	push bc			;8f03
	ld bc,00004h		;8f04
	call L_8DF6		;8f07
	ex de,hl			;8f0a
	ld bc,00080h		;8f0b
	add hl,bc			;8f0e
	ex de,hl			;8f0f
	pop bc			;8f10
	djnz L_8F03		;8f11
	pop hl			;8f13
	ld bc,00008h		;8f14
	add hl,bc			;8f17
	pop de			;8f18
	pop bc			;8f19
	ret			;8f1a
L_8F1B:
	ld b,008h		;8f1b
	ld de,0e100h		;8f1d
L_8F20:
	push bc			;8f20
	push hl			;8f21
	ex de,hl			;8f22
	ld a,(de)			;8f23
	ld d,a			;8f24
	ld b,004h		;8f25
L_8F27:
	ld a,c			;8f27
	rl d		;8f28
	jr c,L_8F2D		;8f2a
	xor a			;8f2c
L_8F2D:
	rld		;8f2d
	ld a,c			;8f2f
	rl d		;8f30
	jr c,L_8F35		;8f32
	xor a			;8f34
L_8F35:
	rld		;8f35
	inc hl			;8f37
	djnz L_8F27		;8f38
	ex de,hl			;8f3a
	pop hl			;8f3b
	inc hl			;8f3c
	pop bc			;8f3d
	djnz L_8F20		;8f3e
	ret			;8f40
L_8F41:
	ex af,af'			;8f41
	call L_8E28		;8f42
	push bc			;8f45
	ld a,(00007h)		;8f46
	inc a			;8f49
	ld c,a			;8f4a
	ld a,024h		;8f4b
	di			;8f4d
	out (c),a		;8f4e
	ld a,091h		;8f50
	out (c),a		;8f52
	inc c			;8f54
	inc c			;8f55
	out (c),h		;8f56
	xor a			;8f58
	out (c),a		;8f59
	out (c),l		;8f5b
	out (c),d		;8f5d
	pop hl			;8f5f
	out (c),h		;8f60
	cp h			;8f62
	jr nz,L_8F66		;8f63
	inc a			;8f65
L_8F66:
	out (c),a		;8f66
	xor a			;8f68
	out (c),l		;8f69
	cp l			;8f6b
	jr nz,L_8F6F		;8f6c
	inc a			;8f6e
L_8F6F:
	out (c),a		;8f6f
	ex af,af'			;8f71
	out (c),a		;8f72
	xor a			;8f74
	out (c),a		;8f75
	ld a,0c0h		;8f77
	out (c),a		;8f79
	ei			;8f7b
	ret			;8f7c
L_8F7D:
	push bc			;8f7d
	push hl			;8f7e
	push de			;8f7f
	call L_8EA8		;8f80
	ld bc,00808h		;8f83
	ld a,001h		;8f86
	call L_8E52		;8f88
	pop de			;8f8b
	pop hl			;8f8c
	pop bc			;8f8d
	ret			;8f8e
L_8F8F:
	push bc			;8f8f
	push hl			;8f90
	push de			;8f91
	call L_8EA8		;8f92
	ld bc,00808h		;8f95
	ld a,048h		;8f98
	call L_8FA1		;8f9a
	pop de			;8f9d
	pop hl			;8f9e
	pop bc			;8f9f
	ret			;8fa0
L_8FA1:
	ex af,af'			;8fa1
	call L_8E28		;8fa2
	push bc			;8fa5
	ld a,(00007h)		;8fa6
	inc a			;8fa9
	ld c,a			;8faa
	ld a,020h		;8fab
	di			;8fad
	out (c),a		;8fae
	ld a,091h		;8fb0
	out (c),a		;8fb2
	inc c			;8fb4
	inc c			;8fb5
	out (c),h		;8fb6
	xor a			;8fb8
	out (c),a		;8fb9
	out (c),l		;8fbb
	ex af,af'			;8fbd
	rlca			;8fbe
	rlca			;8fbf
	ld l,a			;8fc0
	and 003h		;8fc1
	out (c),a		;8fc3
	out (c),d		;8fc5
	xor a			;8fc7
	out (c),a		;8fc8
	out (c),e		;8fca
	ld a,l			;8fcc
	ld e,a			;8fcd
	rlca			;8fce
	rlca			;8fcf
	and 003h		;8fd0
	out (c),a		;8fd2
	pop hl			;8fd4
	out (c),h		;8fd5
	xor a			;8fd7
	out (c),a		;8fd8
	out (c),l		;8fda
	out (c),a		;8fdc
	out (c),a		;8fde
	out (c),a		;8fe0
	ld a,e			;8fe2
	rra			;8fe3
	rra			;8fe4
	and 00fh		;8fe5
	or 090h		;8fe7
	out (c),a		;8fe9
	ei			;8feb
	ret			;8fec

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8fed..0x903e  (81 bytes)
DATA_8FED:
	defb 008h,0cdh,028h,08eh,0c5h,03ah,007h,000h,03ch,04fh,03eh,024h,0f3h,0edh,079h,03eh	; 8fed  ..(..:..<O>$..y>
	defb 091h,0edh,079h,00ch,00ch,0edh,051h,0afh,0edh,079h,0edh,059h,008h,0edh,079h,0d1h	; 8ffd  ..y...Q..y.Y..y.
	defb 0edh,051h,0afh,0edh,079h,0edh,059h,0edh,079h,07eh,023h,0edh,079h,0afh,0edh,079h	; 900d  .Q..y.Y.y~#.y..y
	defb 03eh,0f0h,0edh,079h,00dh,00dh,03eh,0ach,0edh,079h,03eh,091h,0edh,079h,00ch,00ch	; 901d  >..y..>..y>..y..
	defb 03eh,002h,0cdh,032h,08eh,01fh,0d0h,087h,087h,030h,0f5h,07eh,023h,0edh,079h,018h	; 902d  >..2.....0.~#.y.
	defb 0efh	; 903d

; ======================================================================
; CODIGO 0x903e..0x9048  (10 bytes)
; ======================================================================


L_903E:
	ld a,d			;903e
	add a,008h		;903f
	ld d,a			;9041
	ret nz			;9042
	ld a,e			;9043
	add a,008h		;9044
	ld e,a			;9046
	ret			;9047

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9048..0xa000  (4024 bytes)
DATA_9048:
	defb 008h,000h,005h,0ffh,083h,000h,080h,080h,003h,0ffh,09eh,000h,00fh,0ffh,0f0h,0ffh	; 9048  ................
	defb 0ffh,000h,00fh,0ffh,0f0h,0ffh,000h,001h,00fh,0ffh,0f0h,0ffh,01fh,07fh,0feh,0eeh	; 9058  ................
	defb 0f3h,003h,001h,001h,0e1h,0f8h,07ch,01ch,080h,004h,0c0h,003h,0e0h,006h,0ffh,081h	; 9068  ......|.........
	defb 00fh,004h,0ffh,002h,000h,088h,001h,00fh,0ffh,0ffh,000h,00fh,0ffh,0f0h,003h,0ffh	; 9078  ................
	defb 09bh,00fh,0ffh,0f0h,0ffh,018h,078h,03ch,03ch,0f0h,0ffh,007h,003h,003h,0ffh,010h	; 9088  ......x<<.......
	defb 0f0h,00fh,07fh,0ffh,0f0h,080h,0ffh,007h,03fh,0c1h,0c3h,0e3h,003h,003h,084h,0e3h	; 9098  ........?.......
	defb 0f1h,0cfh,0c7h,004h,087h,002h,0c7h,081h,01eh,005h,00eh,083h,01eh,01ch,0e0h,004h	; 90a8  ................
	defb 070h,003h,038h,084h,00fh,03fh,01ch,01eh,003h,00eh,0a4h,007h,0f0h,0ffh,000h,00fh	; 90b8  p.8..?..........
	defb 07fh,07fh,038h,020h,002h,00fh,0ffh,0ffh,0f7h,003h,003h,001h,0ffh,0ffh,003h,09fh	; 90c8  ..8 ............
	defb 09fh,08ch,0c0h,0c0h,01fh,07fh,0ffh,0feh,08eh,00fh,007h,00fh,0f9h,0f0h,080h,003h	; 90d8  ................
	defb 0ffh,0ach,000h,0ffh,0ffh,0f8h,0c0h,0ffh,001h,01fh,0ffh,07fh,0f1h,000h,0ffh,018h	; 90e8  ................
	defb 0fch,0feh,0feh,080h,0efh,0feh,07eh,038h,0ffh,0ffh,000h,00fh,07ch,038h,030h,0ffh	; 90f8  ......~8....|80.
	defb 000h,00fh,0ffh,0f0h,038h,01ch,01ch,01eh,0feh,0f0h,0ffh,0ffh,007h,007h,004h,003h	; 9108  ....8...........
	defb 002h,001h,002h,0ffh,004h,080h,084h,0c0h,0c1h,001h,001h,003h,0ffh,084h,003h,03fh	; 9118  ...............?
	defb 000h,0c0h,003h,0e0h,003h,0f0h,089h,080h,00fh,01eh,03eh,0fch,078h,060h,0ffh,007h	; 9128  ..........>.x`..
	defb 004h,0ffh,090h,000h,007h,07fh,0f8h,078h,040h,000h,00fh,0ffh,0f0h,0ffh,0ffh,000h	; 9138  .......x@.......
	defb 00fh,0ffh,0f8h,005h,0ffh,081h,0f0h,006h,000h,081h,001h,005h,000h,002h,0ffh,095h	; 9148  ................
	defb 0c7h,0e3h,0e3h,0e0h,0e0h,0f7h,07fh,078h,0fch,0c0h,0ffh,007h,07fh,0f8h,080h,0ffh	; 9158  .......x........
	defb 0ffh,007h,07fh,0f8h,0c0h,003h,0ffh,083h,07fh,0f8h,080h,003h,0ffh,002h,000h,00dh	; 9168  ................
	defb 0ffh,083h,0feh,0f9h,0f7h,003h,0ffh,085h,0f8h,007h,07fh,0f8h,087h,008h,0ffh,003h	; 9178  ................
	defb 000h,085h,01fh,0e0h,0feh,01fh,0e1h,005h,000h,083h,07fh,09fh,0efh,007h,0ffh,08ah	; 9188  ................
	defb 0feh,0eeh,0ddh,0dbh,0b7h,0b7h,06fh,06fh,0dfh,07fh,00fh,0ffh,002h,0f8h,005h,0ffh	; 9198  ......oo........
	defb 083h,087h,07fh,07fh,005h,003h,083h,087h,0ffh,0fch,006h,080h,08dh,0c7h,003h,001h	; 91a8  ................
	defb 000h,000h,001h,00fh,0ffh,0feh,0fch,0f8h,0f0h,0e0h,003h,0c0h,008h,007h,084h,0feh	; 91b8  ................
	defb 0f8h,0f0h,0f0h,004h,0e0h,081h,001h,005h,0ffh,08fh,030h,078h,0ffh,07fh,03fh,03fh	; 91c8  ..........0x..??
	defb 01fh,01fh,01eh,01eh,09fh,087h,083h,001h,001h,003h,003h,002h,0feh,003h,0ffh,002h	; 91d8  ................
	defb 000h,083h,0c0h,003h,003h,005h,0ffh,083h,0f8h,0ffh,0ffh,005h,007h,082h,01fh,0feh	; 91e8  ................
	defb 007h,0ffh,088h,077h,0bbh,0dbh,0edh,0edh,0f6h,0f6h,0fbh,007h,0ffh,081h,07fh,003h	; 91f8  ...w............
	defb 0feh,005h,0fdh,003h,0dfh,005h,0bfh,003h,0ffh,005h,0feh,083h,087h,0c3h,0c3h,005h	; 9208  ................
	defb 0ffh,083h,087h,00fh,00fh,005h,001h,003h,083h,005h,080h,003h,0ffh,005h,000h,085h	; 9218  ................
	defb 0c0h,0c2h,0c6h,0ceh,0deh,003h,0feh,008h,0e0h,008h,078h,081h,01eh,003h,01ch,004h	; 9228  ..........x.....
	defb 018h,004h,007h,004h,006h,002h,0c0h,002h,0e0h,004h,0ffh,002h,0f8h,002h,070h,004h	; 9238  ..............p.
	defb 0ffh,002h,01fh,002h,03fh,004h,003h,003h,0fbh,005h,0fdh,003h,07fh,005h,0bfh,005h	; 9248  ....?...........
	defb 0fdh,003h,0feh,005h,0bfh,003h,0dfh,002h,0ffh,005h,0feh,083h,0ffh,0f8h,0f8h,005h	; 9258  ................
	defb 0ffh,083h,0e0h,07fh,07fh,004h,001h,086h,0ffh,01eh,080h,083h,083h,003h,004h,007h	; 9268  ................
	defb 081h,000h,007h,003h,008h,0feh,003h,018h,005h,01eh,081h,006h,007h,007h,002h,0ffh	; 9278  ................
	defb 005h,080h,081h,081h,007h,0ffh,083h,0fch,003h,0ffh,006h,00fh,005h,0fdh,003h,0fbh	; 9288  ................
	defb 005h,0bfh,003h,07fh,08bh,0dfh,06fh,06fh,0b7h,0b7h,0dbh,0ddh,0eeh,0ffh,0ffh,0feh	; 9298  ......oo........
	defb 005h,0ffh,081h,0c0h,003h,0ffh,085h,008h,098h,0b8h,0f8h,00ch,003h,0ffh,084h,044h	; 92a8  ...............D
	defb 076h,07fh,07fh,003h,00fh,002h,01fh,002h,03fh,081h,0ffh,008h,003h,004h,0e0h,002h	; 92b8  v.......?.......
	defb 0f0h,084h,0f8h,0feh,078h,030h,005h,0ffh,081h,001h,004h,01eh,002h,03eh,082h,07eh	; 92c8  ....x0.......>.~
	defb 0feh,003h,081h,004h,080h,081h,081h,003h,0fch,004h,000h,081h,0fch,008h,00fh,088h	; 92d8  ................
	defb 0fbh,0f6h,0f6h,0edh,0edh,0dbh,0bbh,077h,005h,0ffh,08bh,0feh,0fdh,0fbh,000h,000h	; 92e8  .......w........
	defb 00fh,0cfh,03fh,0f0h,0cfh,0bfh,008h,0ffh,082h,0f7h,001h,004h,0ffh,002h,0e0h,082h	; 92f8  ..?.............
	defb 087h,0f8h,00ch,0ffh,002h,0f8h,006h,0ffh,002h,03fh,007h,0ffh,081h,0e0h,007h,0ffh	; 9308  .........?......
	defb 083h,0c1h,0e0h,01fh,006h,0ffh,085h,0efh,080h,0ffh,0ffh,000h,005h,0ffh,086h,0f0h	; 9318  ................
	defb 0f3h,0fch,00fh,0f3h,0fdh,003h,000h,002h,0ffh,086h,07fh,0bfh,0dfh,0fbh,0f6h,0f6h	; 9328  ................
	defb 003h,0edh,002h,0dbh,003h,0ffh,005h,0f0h,003h,0e0h,008h,0ffh,004h,03fh,081h,03ch	; 9338  .............?.<
	defb 00fh,0ffh,081h,001h,008h,0f8h,006h,03fh,081h,001h,008h,0ffh,081h,01fh,008h,0c1h	; 9348  .......?........
	defb 003h,0ffh,003h,0e1h,002h,0f0h,003h,0ffh,003h,087h,002h,0c3h,003h,0ffh,005h,0e0h	; 9358  ................
	defb 005h,0f8h,002h,0ffh,083h,0f8h,03fh,003h,003h,0ffh,08dh,0c0h,0fch,03fh,0f9h,0f9h	; 9368  ......?......?..
	defb 038h,03ch,03ch,03fh,03fh,0fch,03fh,03fh,003h,09fh,002h,0ffh,084h,01fh,0dfh,06fh	; 9378  8<<??.??.......o
	defb 06fh,003h,0b7h,009h,0dbh,082h,0edh,0e3h,003h,0ddh,081h,0e3h,003h,0ffh,002h,0e0h	; 9388  o...............
	defb 003h,0c1h,002h,083h,081h,007h,005h,03ch,003h,03fh,008h,0ffh,005h,001h,007h,0ffh	; 9398  .......<.?......
	defb 081h,03eh,003h,03fh,005h,001h,083h,0e1h,0ffh,0ffh,006h,0e0h,002h,0ffh,005h,0c1h	; 93a8  .>.?............
	defb 002h,081h,082h,003h,0f0h,003h,0f8h,003h,0fch,082h,0ffh,0c3h,003h,061h,003h,030h	; 93b8  .............a.0
	defb 081h,0ffh,005h,0e0h,002h,0c1h,081h,081h,004h,0f8h,004h,0ffh,089h,003h,0ffh,000h	; 93c8  ................
	defb 000h,0c0h,0fch,0ffh,000h,0fch,005h,03ch,002h,0f8h,008h,01fh,081h,0c7h,003h,0bbh	; 93d8  .......<........
	defb 081h,0c7h,003h,0ffh,007h,0dbh,089h,0b7h,0edh,0edh,0f6h,0f6h,0fbh,0fbh,0fdh,0feh	; 93e8  ................
	defb 004h,0ffh,086h,07fh,0bfh,0cfh,0f0h,0feh,0fch,004h,0f0h,08ch,0f1h,0ffh,007h,00fh	; 93f8  ................
	defb 01fh,01fh,03fh,07fh,0ffh,0ffh,0f8h,0f0h,004h,080h,082h,083h,0ffh,003h,03fh,002h	; 9408  ..?...........?.
	defb 07fh,003h,0ffh,007h,0f8h,081h,0ffh,007h,03fh,003h,0ffh,005h,0f8h,083h,0ffh,0feh	; 9418  ........?.......
	defb 0f8h,004h,0ffh,088h,001h,0ffh,003h,007h,007h,00fh,01fh,03fh,003h,0ffh,081h,0fch	; 9428  ...........?....
	defb 003h,0ffh,089h,000h,001h,000h,003h,003h,007h,00fh,01fh,03fh,004h,0ffh,005h,0fch	; 9438  ...........?....
	defb 009h,0ffh,088h,0f0h,0c0h,0ffh,0ffh,000h,001h,00fh,0ffh,003h,03fh,081h,07fh,008h	; 9448  ............?...
	defb 0ffh,097h,0feh,0fdh,0f3h,00fh,0b7h,0b7h,06fh,06fh,0dfh,0dfh,0bfh,07fh,0ffh,0ffh	; 9458  ........oo......
	defb 080h,0c0h,0e0h,0f0h,0f8h,0fch,03fh,0cfh,0f0h,005h,0ffh,084h,000h,0ffh,0ffh,000h	; 9468  ......?.........
	defb 004h,0ffh,083h,0fch,0f3h,00fh,007h,0ffh,08ch,001h,003h,007h,00fh,01fh,03fh,0fch	; 9478  ..............?.
	defb 0f8h,0f0h,0e0h,0c0h,080h,003h,0ffh,088h,000h,001h,003h,007h,00fh,01fh,03fh,07fh	; 9488  ..............?.
	defb 006h,0ffh,087h,0feh,03fh,01fh,00fh,007h,003h,001h,004h,000h,087h,080h,0c0h,0e0h	; 9498  ....?...........
	defb 0f0h,0f8h,0fch,0feh,006h,0ffh,081h,07fh,009h,0ffh,091h,01ch,022h,049h,051h,049h	; 94a8  ............"IQI
	defb 022h,01ch,0ffh,063h,066h,06ch,078h,07ch,06eh,067h,0ffh,03eh,005h,063h,09bh,03eh	; 94b8  "..cflx|ng.>.c.>
	defb 0ffh,063h,073h,07bh,07fh,06fh,067h,063h,0ffh,01ch,036h,063h,063h,07fh,063h,063h	; 94c8  .cs{.ogc..6cc.cc
	defb 0ffh,063h,077h,07fh,07fh,06bh,063h,063h,0ffh,03ch,005h,018h,084h,03ch,0ffh,018h	; 94d8  .cw..kcc.<...<..
	defb 038h,004h,018h,093h,07eh,0ffh,03eh,063h,063h,03fh,003h,063h,03eh,0ffh,03eh,063h	; 94e8  8...~.>cc?.c>.>c
	defb 063h,03eh,063h,063h,03eh,0ffh,07eh,003h,063h,084h,07eh,060h,060h,0ffh,006h,063h	; 94f8  c>cc>.~.c.~``..c
	defb 08ah,03eh,000h,03eh,063h,060h,03eh,003h,063h,03eh,0ffh,003h,063h,081h,07fh,003h	; 9508  .>.>c`>.c>..c...
	defb 063h,083h,0ffh,03eh,063h,003h,060h,08fh,063h,03eh,0ffh,07fh,060h,060h,07eh,060h	; 9518  c..>c.`.c>..``~`
	defb 060h,07fh,0ffh,066h,066h,07eh,03ch,003h,018h,085h,000h,07fh,063h,006h,00ch,003h	; 9528  `..ff~<.....c...
	defb 018h,000h,00dh,000h,003h,0c0h,003h,000h,002h,0c0h,002h,0c3h,08dh,033h,000h,0c0h	; 9538  .............3..
	defb 0c0h,0c3h,0c3h,033h,0c3h,0c3h,0c0h,0c3h,0c3h,033h,00ch,0c3h,008h,0c0h,006h,000h	; 9548  ...3.....3......
	defb 082h,0c0h,0cch,003h,000h,004h,0c0h,086h,0c3h,000h,0c0h,0c0h,0c3h,0c3h,003h,033h	; 9558  ...............3
	defb 084h,0c0h,0c3h,0c3h,033h,005h,0c3h,081h,033h,003h,0c3h,081h,033h,004h,0c3h,084h	; 9568  ....3...3...3...
	defb 0cch,0c3h,0c3h,033h,01ah,0c3h,081h,0c0h,007h,0c3h,002h,0c0h,005h,0c3h,083h,0c0h	; 9578  ...3............
	defb 0c3h,033h,009h,0c3h,081h,0cch,004h,0c3h,002h,033h,008h,0c3h,081h,0cch,008h,0c3h	; 9588  .3.......3......
	defb 003h,033h,089h,0c3h,033h,0cch,0c3h,0c3h,033h,0c3h,0c3h,0cch,003h,0c3h,081h,033h	; 9598  .3..3...3......3
	defb 009h,0c3h,002h,033h,005h,0c3h,085h,033h,0c3h,0c3h,0c0h,0c0h,004h,0c3h,002h,0c0h	; 95a8  ...3...3........
	defb 002h,000h,008h,0c0h,002h,033h,008h,0c3h,003h,033h,002h,0c3h,081h,0fch,00eh,0c3h	; 95b8  .....3...3......
	defb 082h,033h,0c3h,004h,033h,003h,0c3h,081h,0c0h,004h,0c3h,002h,0c0h,002h,000h,002h	; 95c8  .3..3...........
	defb 0c3h,002h,0c0h,004h,000h,082h,0c6h,0c0h,006h,060h,006h,0c6h,002h,066h,006h,0c3h	; 95d8  .........`...f..
	defb 002h,0c6h,002h,0c3h,08bh,033h,0c3h,0c3h,0c6h,0c6h,066h,033h,0c3h,0c3h,0c6h,0c6h	; 95e8  .....3....f3....
	defb 003h,066h,083h,0c3h,0c6h,0c6h,003h,066h,002h,0a6h,006h,066h,002h,0aah,004h,066h	; 95f8  .f.....f...f...f
	defb 002h,061h,002h,0a1h,003h,066h,081h,061h,004h,0a1h,003h,066h,085h,011h,0aah,0aah	; 9608  .a...f.a...f....
	defb 011h,0aah,003h,0c6h,081h,061h,004h,0a1h,005h,0a6h,083h,061h,0a1h,0a1h,005h,0aah	; 9618  .....a.....a....
	defb 00ch,0a1h,009h,0aah,005h,0a6h,083h,0aah,0a6h,0a6h,005h,066h,009h,0a6h,081h,0aah	; 9628  ...........f....
	defb 00eh,0a6h,081h,0aah,019h,0a6h,005h,066h,002h,0a6h,081h,0aah,011h,0a6h,002h,066h	; 9638  .......f.......f
	defb 081h,061h,005h,0a6h,005h,066h,083h,0a6h,0aah,0aah,006h,0a6h,081h,0a1h,007h,0aah	; 9648  .a...f..........
	defb 008h,0a1h,007h,0aah,011h,0a1h,003h,0aah,008h,0a6h,005h,066h,010h,0a6h,003h,0aah	; 9658  ...........f....
	defb 031h,0a6h,004h,066h,004h,0a6h,004h,066h,008h,0a6h,020h,0a1h,002h,0aah,005h,0a6h	; 9668  1..f...f.. .....
	defb 083h,0aah,0a6h,0a6h,005h,066h,007h,0a6h,081h,066h,029h,0a6h,082h,066h,0aah,006h	; 9678  .....f...f)..f..
	defb 0a6h,082h,066h,0aah,005h,066h,002h,0a6h,081h,0aah,006h,0a6h,018h,0a1h,081h,0aah	; 9688  ..f..f..........
	defb 004h,0a6h,003h,0aah,081h,0a6h,003h,066h,005h,0a6h,003h,066h,01eh,0a6h,005h,066h	; 9698  .......f...f...f
	defb 021h,0a6h,008h,0a1h,003h,000h,081h,0aah,004h,0a1h,083h,0a0h,010h,010h,005h,0a1h	; 96a8  !...............
	defb 085h,0aah,011h,0aah,0aah,011h,003h,0aah,002h,0a1h,002h,0aah,089h,011h,0aah,0a6h	; 96b8  ................
	defb 0a6h,0a1h,0a1h,0aah,0aah,011h,004h,0aah,0a4h,011h,0aah,0aah,011h,0aah,0a6h,0a6h	; 96c8  ................
	defb 0aah,011h,0aah,0aah,011h,0aah,0a6h,0a6h,0aah,011h,0aah,0aah,011h,0aah,0aah,0a6h	; 96d8  ................
	defb 0aah,011h,0aah,0aah,011h,0aah,0aah,0a6h,0a1h,0a1h,0aah,0aah,011h,003h,0aah,003h	; 96e8  ................
	defb 0a1h,088h,0aah,0a1h,0a1h,0aah,0aah,000h,000h,010h,005h,0a1h,003h,0a0h,002h,0aah	; 96f8  ................
	defb 00bh,0a1h,003h,0aah,008h,0a6h,005h,066h,003h,0aah,005h,0a6h,007h,0aah,081h,066h	; 9708  .......f.......f
	defb 007h,0aah,010h,0a6h,081h,066h,007h,0aah,009h,0a6h,003h,0aah,005h,0a6h,003h,0aah	; 9718  .....f..........
	defb 005h,0a6h,003h,0aah,00ah,0a6h,002h,0aah,003h,0a6h,003h,066h,010h,0a6h,002h,0aah	; 9728  ...........f....
	defb 081h,0a6h,015h,0a1h,002h,0aah,011h,0a6h,005h,066h,003h,0aah,008h,0a6h,004h,066h	; 9738  .........f.....f
	defb 00ah,0a6h,002h,0aah,006h,0a6h,081h,0aah,010h,0a6h,081h,0aah,007h,0a6h,081h,0aah	; 9748  ................
	defb 00ch,0a6h,004h,0aah,082h,0a6h,061h,004h,0a6h,082h,0aah,0fah,010h,0a6h,005h,0a1h	; 9758  ......a.........
	defb 003h,0aah,010h,0a1h,004h,0aah,004h,0a1h,007h,0a6h,081h,0aah,006h,0a6h,002h,0aah	; 9768  ................
	defb 007h,0a6h,081h,0aah,005h,0a6h,003h,0aah,007h,0a6h,081h,0aah,007h,0a6h,003h,0aah	; 9778  ................
	defb 005h,0a6h,083h,0aah,0a6h,0a6h,004h,066h,082h,0a6h,0aah,007h,0a6h,083h,0aah,0a6h	; 9788  .......f........
	defb 0a6h,003h,066h,002h,0a6h,081h,0fah,006h,0a6h,004h,0aah,005h,0a6h,003h,0aah,005h	; 9798  ..f.............
	defb 066h,085h,0aah,0a6h,0a6h,066h,066h,003h,0a6h,081h,0aah,004h,0a6h,003h,0aah,083h	; 97a8  f....ff.........
	defb 0a1h,0aah,0aah,00fh,0a1h,081h,0aah,006h,096h,002h,0a1h,002h,061h,004h,066h,084h	; 97b8  ............a.f.
	defb 0a1h,0aah,0a1h,061h,004h,066h,002h,0a1h,081h,061h,005h,066h,002h,0a9h,00ch,096h	; 97c8  ...a.f...a.f....
	defb 003h,066h,015h,096h,082h,0a6h,0f6h,010h,096h,008h,060h,081h,000h,007h,0f0h,081h	; 97d8  .f........`.....
	defb 000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h	; 97e8  ................
	defb 000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h	; 97f8  ................
	defb 000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h,060h,007h,0f0h,081h	; 9808  ............`...
	defb 000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,007h,0f0h,081h,000h,00fh,0f0h,000h	; 9818  ................
	defb 000h,000h,08bh,000h,000h,000h,000h,000h,000h,000h,000h,08ch,08dh,08eh,08fh,090h	; 9828  ................
	defb 091h,092h,000h,000h,000h,000h,093h,094h,095h,096h,097h,098h,000h,000h,099h,09ah	; 9838  ................
	defb 09bh,09ch,09dh,09eh,09fh,0a0h,0a1h,000h,0a2h,0a3h,0a4h,0a5h,0a6h,073h,0a7h,0a8h	; 9848  .............s..
	defb 0a9h,000h,0aah,0abh,0ach,0adh,0aeh,073h,0afh,0b0h,0b1h,0b2h,000h,0b3h,0b4h,0b5h	; 9858  .......s........
	defb 0b6h,0b7h,0b7h,0b9h,0bah,0bbh,000h,0bch,0bdh,0beh,0bfh,073h,0c0h,0c1h,0c2h,0c3h	; 9868  ...........s....
	defb 000h,000h,0c4h,0c5h,0c6h,0c7h,0c8h,0c9h,0cah,0cbh,000h,000h,0cch,0cdh,0ceh,0cfh	; 9878  ................
	defb 0d0h,0d1h,0d2h,0d3h,000h,000h,0d4h,0d5h,0d6h,0d6h,0d6h,0d6h,0d6h,0d7h,000h,000h	; 9888  ................
	defb 000h,0d8h,0d9h,0d9h,0d9h,0d9h,0dah,0dbh,060h,061h,062h,062h,062h,062h,062h,062h	; 9898  ........`abbbbbb
	defb 062h,062h,062h,062h,063h,064h,065h,066h,073h,073h,073h,073h,073h,073h,073h,073h	; 98a8  bbbbcdefssssssss
	defb 073h,073h,067h,065h,065h,066h,073h,073h,075h,076h,077h,076h,078h,079h,073h,073h	; 98b8  ssgeefssuvwvxyss
	defb 067h,065h,065h,066h,073h,073h,074h,074h,074h,074h,074h,074h,073h,073h,067h,065h	; 98c8  geefssttttttssge
	defb 065h,066h,073h,040h,073h,041h,042h,043h,044h,073h,073h,073h,067h,065h,065h,066h	; 98d8  efs@sABCDsssgeef
	defb 073h,073h,073h,073h,073h,073h,073h,073h,073h,073h,067h,065h,065h,066h,073h,07fh	; 98e8  ssssssssssgeefs.
	defb 073h,080h,081h,082h,083h,084h,085h,073h,067h,065h,065h,066h,073h,073h,073h,073h	; 98f8  s......sgeefssss
	defb 073h,073h,073h,073h,073h,073h,067h,065h,065h,066h,073h,086h,073h,087h,088h,089h	; 9908  ssssssgeefs.s...
	defb 08ah,073h,073h,073h,067h,065h,065h,068h,069h,069h,069h,069h,069h,069h,069h,069h	; 9918  .sssgeehiiiiiiii
	defb 069h,069h,06ah,065h,06bh,06ch,06ch,06ch,06ch,06ch,06ch,06ch,06ch,06ch,06ch,06ch	; 9928  iijeklllllllllll
	defb 06ch,06dh,06eh,06fh,070h,070h,070h,070h,070h,070h,070h,070h,070h,070h,071h,072h	; 9938  lmnoppppppppppqr
	defb 08dh,08eh,0e0h,0e1h,0e2h,092h,000h,000h,0e3h,0e4h,0e5h,0e6h,0e7h,098h,000h,000h	; 9948  ................
	defb 09bh,0e8h,0e9h,0eah,0ebh,0ech,0edh,000h,0a4h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,000h	; 9958  ................
	defb 0ach,0f4h,0aeh,073h,0afh,0f5h,0f6h,0f7h,0b4h,0f8h,0b6h,0b7h,0b7h,0f9h,0fah,0fbh	; 9968  ...s............
	defb 0bdh,0fch,0fdh,073h,0c0h,0c1h,0c2h,0c3h,0c4h,0feh,0ffh,0c7h,0c8h,0c9h,0cah,0cbh	; 9978  ...s............
	defb 000h,02bh,018h,000h,002h,007h,003h,00fh,002h,01fh,081h,03fh,008h,0ffh,002h,0f8h	; 9988  .+.........?....
	defb 003h,0f0h,003h,0e0h,07fh,000h,00dh,000h,087h,001h,003h,00fh,07fh,03fh,07fh,07fh	; 9998  .............?..
	defb 00ah,0ffh,082h,0fch,0f0h,003h,0c0h,002h,080h,07fh,000h,083h,001h,003h,007h,003h	; 99a8  ................
	defb 00fh,081h,03fh,009h,0ffh,087h,0feh,0fch,0f8h,0f8h,0f0h,0f8h,0c0h,00bh,000h,002h	; 99b8  ..?.............
	defb 001h,083h,003h,07fh,07fh,00bh,0ffh,002h,0feh,083h,0fch,080h,080h,006h,000h,002h	; 99c8  ................
	defb 03ch,002h,078h,092h,079h,0f3h,0f7h,0ffh,01fh,03eh,07ch,0f9h,0f3h,0e3h,0c3h,087h	; 99d8  <.x.y....>|.....
	defb 01fh,07fh,0f8h,0f0h,0e0h,0e0h,003h,0c0h,084h,0f0h,0f8h,078h,078h,003h,079h,002h	; 99e8  ...........xx.y.
	defb 07fh,083h,0ffh,0f7h,0f7h,003h,0e7h,002h,00fh,003h,01eh,003h,03ch,088h,003h,007h	; 99f8  ............<...
	defb 00fh,00eh,01eh,03ch,038h,078h,005h,0e0h,003h,0e1h,002h,07eh,083h,0feh,0f6h,0f6h	; 9a08  ...<8x.....~....
	defb 003h,0eeh,002h,00fh,088h,01fh,01dh,03dh,03bh,07bh,073h,0f1h,0f1h,003h,0e3h,003h	; 9a18  .......=.{s.....
	defb 0c7h,002h,0e0h,003h,0c0h,003h,080h,008h,000h,003h,01fh,003h,03fh,002h,07fh,008h	; 9a28  ............?...
	defb 0ffh,083h,0f0h,0e0h,0e0h,003h,0c0h,002h,080h,007h,000h,087h,007h,003h,007h,007h	; 9a38  ................
	defb 00fh,01fh,03fh,009h,0ffh,089h,0f8h,0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h,003h	; 9a48  ..?.............
	defb 001h,003h,003h,002h,007h,088h,0efh,0e7h,0e7h,0c7h,0c7h,0c3h,083h,083h,003h,087h	; 9a58  ................
	defb 003h,0c7h,092h,0e3h,0e0h,080h,080h,081h,081h,083h,0c7h,0ffh,0feh,0fbh,0f3h,0f3h	; 9a68  ................
	defb 0f7h,0e7h,0c7h,08fh,00fh,003h,0c7h,003h,087h,002h,007h,002h,078h,088h,079h,0f1h	; 9a78  ............x.y.
	defb 0f3h,0f7h,0e7h,0efh,070h,0f0h,003h,0ffh,002h,081h,081h,001h,003h,0e3h,003h,0e7h	; 9a88  ....p...........
	defb 002h,0efh,002h,0ceh,081h,0cfh,003h,08fh,002h,00fh,088h,0f7h,0e7h,0c7h,0cfh,08fh	; 9a98  ................
	defb 08fh,01eh,01eh,003h,08fh,003h,01eh,002h,03ch,090h,007h,008h,017h,014h,017h,014h	; 9aa8  ........<.......
	defb 008h,007h,080h,040h,020h,0a0h,020h,0a0h,040h,080h,011h,000h,085h,003h,00fh,01fh	; 9ab8  ...@ . .@.......
	defb 03fh,07fh,00bh,0ffh,086h,0fch,0f0h,0e0h,0c0h,080h,080h,07fh,000h,00ah,000h,003h	; 9ac8  ?...............
	defb 001h,003h,003h,002h,007h,009h,0ffh,002h,0feh,003h,0fch,002h,0f8h,07fh,000h,009h	; 9ad8  ................
	defb 000h,000h,07fh,090h,029h,090h,07fh,090h,029h,090h,020h,090h,020h,060h,068h,0e0h	; 9ae8  ....)...). . `h.
	defb 018h,090h,020h,060h,070h,0e0h,07fh,060h,029h,060h,07fh,060h,029h,060h,000h,07fh	; 9af8  .. `p..`)`.`)`..
	defb 090h,029h,090h,000h,07fh,090h,029h,090h,000h,020h,090h,020h,060h,068h,0e0h,000h	; 9b08  .)....).. . `h..
	defb 018h,090h,020h,060h,070h,0e0h,000h,07fh,060h,029h,060h,000h,07fh,060h,029h,060h	; 9b18  .. `p...`)`..`)`
	defb 000h,001h,002h,003h,0feh,0f8h,004h,005h,006h,007h,0feh,0f0h,008h,009h,00ah,00bh	; 9b28  ................
	defb 00eh,00fh,010h,011h,01bh,01ch,01dh,01eh,01fh,020h,021h,022h,023h,024h,025h,026h	; 9b38  ......... !"#$%&
	defb 0feh,000h,00ch,002h,00dh,012h,013h,014h,015h,027h,028h,029h,02ah,02bh,02ch,02dh	; 9b48  .........'()*+,-
	defb 02eh,02fh,030h,031h,032h,033h,034h,0feh,010h,016h,019h,017h,0feh,0f8h,018h,019h	; 9b58  ./01234.........
	defb 01ah,0ffh,007h,007h,00fh,00fh,00fh,01fh,01fh,03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b68  .........?......
	defb 0ffh,0ffh,0f8h,0f8h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,000h,000h,000h,000h,001h,003h	; 9b78  ................
	defb 00fh,07fh,03fh,07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fch	; 9b88  ..?.............
	defb 0f0h,0c0h,0c0h,0c0h,080h,080h,000h,000h,000h,000h,000h,000h,000h,001h,003h,007h	; 9b98  ................
	defb 00fh,00fh,00fh,03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0fch,0f8h	; 9ba8  ...?............
	defb 0f8h,0f0h,0f8h,0c0h,000h,000h,000h,000h,000h,000h,01fh,01fh,01fh,03fh,03fh,03fh	; 9bb8  .............???
	defb 07fh,07fh,0f0h,0e0h,0e0h,0c0h,0c0h,0c0h,080h,080h,000h,000h,000h,000h,000h,001h	; 9bc8  ................
	defb 001h,003h,07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh	; 9bd8  ................
	defb 0feh,0fch,080h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 9be8  ................
	defb 000h,007h,003h,007h,007h,00fh,01fh,03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bf8  .......?........
	defb 0ffh,0f8h,0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h,000h,003h,00fh,01fh,03fh,07fh	; 9c08  ..............?.
	defb 0ffh,0ffh,0ffh,0fch,0f0h,0e0h,0c0h,080h,080h,000h,001h,001h,001h,003h,003h,003h	; 9c18  ................
	defb 007h,007h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fch,0fch,0fch	; 9c28  ................
	defb 0f8h,0f8h,03ch,03ch,078h,078h,079h,0f3h,0f7h,0ffh,01fh,03eh,07ch,0f9h,0f3h,0e3h	; 9c38  ..<<xxy....>|...
	defb 0c3h,087h,01fh,07fh,0f8h,0f0h,0e0h,0e0h,0c0h,0c0h,0c0h,0f0h,0f8h,078h,078h,079h	; 9c48  .............xxy
	defb 079h,079h,07fh,07fh,0ffh,0f7h,0f7h,0e7h,0e7h,0e7h,00fh,00fh,01eh,01eh,01eh,03ch	; 9c58  yy.............<
	defb 03ch,03ch,003h,007h,00fh,00eh,01eh,03ch,038h,078h,0e0h,0e0h,0e0h,0e0h,0e0h,0e1h	; 9c68  <<.....<8x......
	defb 0e1h,0e1h,07eh,07eh,0feh,0f6h,0f6h,0eeh,0eeh,0eeh,00fh,00fh,01fh,01dh,03dh,03bh	; 9c78  ..~~..........=.
	defb 07bh,073h,0f1h,0f1h,0e3h,0e3h,0e3h,0c7h,0c7h,0c7h,0e0h,0e0h,0c0h,0c0h,0c0h,080h	; 9c88  {s..............
	defb 080h,080h,001h,001h,001h,003h,003h,003h,007h,007h,0efh,0e7h,0e7h,0c7h,0c7h,0c3h	; 9c98  ................
	defb 083h,083h,087h,087h,087h,0c7h,0c7h,0c7h,0e3h,0e0h,080h,080h,081h,081h,083h,0c7h	; 9ca8  ................
	defb 0ffh,0feh,0fbh,0f3h,0f3h,0f7h,0e7h,0c7h,08fh,00fh,0c7h,0c7h,0c7h,087h,087h,087h	; 9cb8  ................
	defb 007h,007h,078h,078h,079h,0f1h,0f3h,0f7h,0e7h,0efh,070h,0f0h,0ffh,0ffh,0ffh,080h	; 9cc8  ..xxy.....p.....
	defb 080h,000h,0e3h,0e3h,0e3h,0e7h,0e7h,0e7h,0efh,0efh,0ceh,0ceh,0cfh,08fh,08fh,08fh	; 9cd8  ................
	defb 00fh,00fh,0f7h,0e7h,0c7h,0cfh,08fh,08fh,01eh,01eh,08fh,08fh,08fh,01eh,01eh,01eh	; 9ce8  ................
	defb 03ch,03ch,007h,008h,017h,014h,017h,014h,008h,007h,080h,040h,020h,0a0h,020h,0a0h	; 9cf8  <<.........@ . .
	defb 040h,080h,002h,000h,082h,00fh,0f0h,00ch,000h,082h,00fh,0f0h,00eh,000h,081h,0ffh	; 9d08  @...............
	defb 010h,000h,081h,0ffh,00eh,000h,084h,0c0h,030h,00ch,003h,010h,000h,084h,0c0h,030h	; 9d18  ........0......0
	defb 00ch,003h,008h,000h,000h,002h,000h,002h,0e0h,003h,0f0h,027h,000h,002h,0ffh,00eh	; 9d28  ...........'....
	defb 000h,082h,0f8h,0f0h,007h,0ffh,004h,0feh,005h,0fch,085h,0e0h,0c0h,0c0h,080h,080h	; 9d38  ................
	defb 00bh,000h,005h,0fch,004h,0feh,007h,0ffh,00bh,000h,002h,080h,002h,0c0h,082h,0e0h	; 9d48  ................
	defb 0ffh,00fh,000h,081h,0f0h,012h,000h,002h,0ffh,086h,0feh,0fch,0f8h,0f8h,0f0h,0f0h	; 9d58  ................
	defb 003h,0e0h,002h,0c0h,003h,000h,081h,0c0h,00ch,000h,007h,0c0h,003h,0e0h,002h,0f0h	; 9d68  ................
	defb 002h,0f8h,082h,0fch,0feh,010h,000h,002h,0ffh,00fh,000h,081h,0c0h,00fh,000h,004h	; 9d78  ................
	defb 00fh,004h,007h,002h,003h,081h,001h,022h,000h,082h,01fh,00fh,00eh,000h,002h,0ffh	; 9d88  ......."........
	defb 085h,007h,003h,003h,001h,001h,00bh,000h,007h,0ffh,004h,07fh,005h,03fh,00bh,000h	; 9d98  .............?..
	defb 002h,001h,002h,003h,081h,007h,005h,03fh,004h,07fh,007h,0ffh,081h,00fh,00fh,000h	; 9da8  .......?........
	defb 081h,0ffh,012h,000h,081h,003h,00fh,000h,002h,0ffh,086h,07fh,03fh,01fh,01fh,00fh	; 9db8  ............?...
	defb 00fh,003h,007h,002h,003h,010h,000h,007h,003h,003h,007h,002h,00fh,002h,01fh,084h	; 9dc8  ................
	defb 03fh,07fh,000h,003h,00eh,000h,002h,0ffh,00eh,000h,000h,002h,000h,081h,0ffh,006h	; 9dd8  ?...............
	defb 000h,090h,03fh,040h,040h,07fh,003h,003h,07eh,000h,03fh,040h,040h,07fh,040h,040h	; 9de8  ..?@@...~.?@@.@@
	defb 07fh,000h,006h,040h,083h,07fh,000h,03fh,005h,040h,083h,03fh,000h,07eh,006h,018h	; 9df8  ...@...?.@.?.~..
	defb 08ch,000h,01ch,02eh,05fh,05fh,07fh,03eh,01ch,000h,03fh,040h,040h,003h,043h,083h	; 9e08  ....__.>..?@@.C.
	defb 03fh,000h,03eh,003h,043h,086h,07fh,043h,043h,000h,067h,05bh,005h,043h,093h,000h	; 9e18  ?.>.C..CC.g[.C..
	defb 03fh,040h,040h,07fh,040h,040h,07fh,000h,01ch,02eh,05fh,05fh,07fh,03eh,01ch,000h	; 9e28  ?@@.@@....__.>..
	defb 067h,05bh,005h,043h,082h,000h,03eh,005h,043h,083h,03eh,000h,07eh,005h,043h,082h	; 9e38  g[.C..>.C.>.~.C.
	defb 07eh,000h,007h,018h,085h,000h,03fh,040h,040h,07eh,003h,040h,084h,000h,043h,026h	; 9e48  ~.....?@@~.@..C&
	defb 01ch,004h,018h,099h,000h,01ch,02eh,05fh,05fh,07fh,03eh,01ch,000h,03fh,040h,040h	; 9e58  .......__.>..?@@
	defb 07fh,003h,003h,07eh,000h,03fh,040h,040h,07fh,040h,040h,07fh,000h,006h,040h,086h	; 9e68  ...~.?@@.@@...@.
	defb 07fh,000h,03fh,040h,040h,07eh,003h,040h,081h,000h,003h,07fh,004h,07eh,081h,000h	; 9e78  ..?@@~.@.....~..
	defb 003h,0ffh,003h,000h,082h,0c0h,000h,003h,0ffh,005h,000h,003h,0ffh,002h,000h,083h	; 9e88  ................
	defb 0feh,002h,000h,003h,0feh,00ch,07eh,004h,07fh,004h,000h,004h,0ffh,004h,000h,004h	; 9e98  ......~.........
	defb 0feh,008h,000h,003h,07fh,081h,000h,003h,07fh,081h,000h,003h,0ffh,081h,000h,003h	; 9ea8  ................
	defb 0ffh,081h,000h,003h,0ffh,081h,000h,003h,0feh,081h,000h,003h,0ffh,005h,000h,003h	; 9eb8  ................
	defb 0feh,009h,000h,008h,0dfh,008h,0fah,004h,0dfh,083h,0c0h,0ffh,080h,005h,0ffh,084h	; 9ec8  ................
	defb 000h,0ffh,000h,0ffh,004h,0fah,084h,002h,0feh,000h,0ffh,007h,000h,085h,0ffh,000h	; 9ed8  ................
	defb 080h,0e0h,0f8h,003h,0feh,086h,09eh,000h,00eh,01fh,01fh,00fh,003h,000h,081h,086h	; 9ee8  ................
	defb 003h,082h,084h,03ah,07eh,07eh,03ch,005h,000h,087h,001h,003h,007h,000h,003h,01fh	; 9ef8  ...:~~<.........
	defb 07fh,004h,0ffh,002h,00fh,002h,01fh,004h,03fh,008h,07fh,008h,007h,081h,07fh,004h	; 9f08  ........?.......
	defb 03fh,002h,01fh,082h,09fh,007h,003h,003h,002h,001h,002h,000h,005h,09fh,002h,0dfh	; 9f18  ?...............
	defb 099h,0ffh,0c0h,0f8h,0fch,0feh,0feh,0c2h,0f1h,0ffh,0e0h,0fch,0feh,0ffh,03fh,0c0h	; 9f28  ..............?.
	defb 0f1h,0ffh,0e0h,0fch,0ffh,0ffh,000h,0c0h,0f1h,0ffh,003h,000h,08dh,004h,00ch,01ch	; 9f38  ................
	defb 03ch,0fch,0f8h,0f8h,0f0h,0e0h,0e0h,0c0h,0f1h,0ffh,007h,000h,081h,080h,005h,000h	; 9f48  <...............
	defb 085h,001h,003h,003h,001h,001h,00ah,000h,006h,080h,007h,000h,005h,0ffh,002h,003h	; 9f58  ................
	defb 08ch,000h,080h,0e0h,0f8h,0fch,0f0h,0fch,0feh,0c0h,0c0h,09fh,09fh,004h,0dfh,082h	; 9f68  ................
	defb 040h,000h,003h,040h,085h,010h,008h,002h,007h,007h,006h,00fh,003h,0ffh,004h,0feh	; 9f78  @..@............
	defb 08dh,0ffh,00fh,08fh,087h,087h,083h,081h,000h,000h,0f0h,0f8h,07ch,00eh,004h,000h	; 9f88  ............|...
	defb 006h,0fbh,085h,078h,039h,01fh,03fh,03fh,005h,07fh,005h,0ffh,083h,09fh,0c7h,083h	; 9f98  ...x9.??........
	defb 004h,0ffh,085h,08fh,0bfh,08fh,0cfh,07fh,003h,03fh,085h,01fh,00fh,003h,000h,0b4h	; 9fa8  .........?......
	defb 004h,054h,085h,034h,008h,010h,003h,001h,006h,000h,081h,029h,003h,05ah,084h,052h	; 9fb8  .T.4.......).Z.R
	defb 05eh,021h,01eh,003h,000h,08eh,080h,0e0h,0cfh,0e7h,073h,0b3h,05bh,059h,059h,05dh	; 9fc8  ^!........s.[YY]
	defb 09ch,01ch,03ch,07ch,007h,0fdh,090h,01fh,08fh,08fh,087h,0c7h,0c3h,0e2h,0e2h,000h	; 9fd8  ..<|............
	defb 000h,080h,0ffh,0ffh,07fh,07fh,03fh,003h,000h,003h,040h,002h,0a0h,002h,03fh,002h	; 9fe8  ......?...@...?.
	defb 09fh,086h,08fh,0cfh,0cfh,0c7h,0fdh,0feh	; 9ff8  ........
