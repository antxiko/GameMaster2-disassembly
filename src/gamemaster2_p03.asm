; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS sin identificar  0xa000..0xa125  (293 bytes)
DATA_A000:
	defb 023h,0a0h,03ah,001h,0d3h,0feh,010h,028h,003h,021h,02bh,0a0h,078h,0cdh,0e6h,0a3h	; a000  #.:....(.!+.x...
	defb 0ebh,0f1h,047h,087h,080h,021h,050h,0e0h,0cdh,0e6h,0a3h,0ebh,013h,001h,002h,000h	; a010  ..G..!P.........
	defb 0edh,0b0h,0c9h,014h,000h,006h,000h,080h,000h,055h,000h,015h,000h,075h,000h,002h	; a020  .........U...u..
	defb 030h,004h,030h,0cdh,022h,0a1h,03ah,01ah,0d3h,06fh,0d6h,005h,038h,006h,03ch,00eh	; a030  0.0.".:..o..8.<.
	defb 005h,0cdh,01eh,0a2h,07dh,032h,052h,0e0h,0c9h,0cdh,022h,0a1h,03ah,01ah,0d3h,047h	; a040  ....}2R...".:..G
	defb 03dh,032h,05ch,0e0h,0feh,008h,038h,002h,03eh,008h,021h,080h,0a0h,0cdh,0e6h,0a3h	; a050  =2\...8.>.!.....
	defb 07eh,032h,05dh,0e0h,03eh,08ah,032h,056h,0e0h,078h,00eh,009h,0cdh,01eh,0a2h,07dh	; a060  ~2].>.2V.x.....}
	defb 087h,021h,089h,0a0h,0cdh,0e6h,0a3h,011h,054h,0e0h,001h,002h,000h,0edh,0b0h,0c9h	; a070  .!......T.......
	defb 077h,033h,0bbh,0eeh,011h,0bbh,0eeh,011h,011h,000h,000h,070h,00ch,020h,01ah,050h	; a080  w3.........p. .P
	defb 028h,030h,036h,0e0h,043h,040h,052h,0c0h,061h,0d0h,06eh,0c3h,022h,0a1h,03ah,01ah	; a090  (06.C@R.a.n.".:.
	defb 0d3h,03dh,0c3h,025h,0a1h,03ah,01ah,0d3h,00eh,003h,0cdh,01eh,0a2h,07dh,0c3h,025h	; a0a0  .=.%.:.......}.%
	defb 0a1h,03ah,01ah,0d3h,00eh,00dh,0cdh,01eh,0a2h,07dh,03ch,032h,060h,0e0h,03dh,087h	; a0b0  .:.......}<2`.=.
	defb 021h,0cfh,0a0h,0cdh,0e6h,0a3h,011h,05bh,0e0h,001h,002h,000h,0edh,0b0h,0c9h,006h	; a0c0  !......[........
	defb 080h,006h,070h,006h,070h,006h,070h,006h,060h,006h,050h,006h,050h,006h,050h,006h	; a0d0  ..p.p.p.`.P.P.P.
	defb 060h,006h,060h,006h,050h,006h,050h,000h,080h,03ah,01ah,0d3h,00eh,008h,0cdh,01eh	; a0e0  `.`.P.P..:......
	defb 0a2h,065h,02eh,000h,022h,0b8h,0e1h,0c3h,022h,0a1h,0cdh,022h,0a1h,03ah,01ah,0d3h	; a0f0  .e.."..."..".:..
	defb 0f5h,00eh,005h,0cdh,01eh,0a2h,07dh,032h,054h,0e0h,0f1h,0feh,006h,0d8h,047h,0d6h	; a100  ......}2T.....G.
	defb 005h,0feh,004h,038h,002h,03eh,003h,032h,056h,0e0h,078h,03dh,0e6h,003h,032h,059h	; a110  ...8.>.2V.x=..2Y
	defb 0e0h,0c9h,03ah,01bh,0d3h	; a120

; ======================================================================
; CODIGO 0xa125..0xa12a  (5 bytes)
; ======================================================================


L_A125:
	ld hl,(0d30ah)		;a125
	ld (hl),a			;a128
	ret			;a129

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa12a..0xa21e  (244 bytes)
DATA_A12A:
	defb 03ah,01ah,0d3h,00eh,00fh,0cdh,01eh,0a2h,07bh,032h,058h,0e0h,07dh,03ch,032h,055h	; a12a  :.......{2X.}<2U
	defb 0e0h,03dh,032h,054h,0e0h,021h,05bh,0a1h,087h,0cdh,0e6h,0a3h,07eh,032h,056h,0e0h	; a13a  .=2T.![.....~2V.
	defb 023h,07eh,032h,057h,0e0h,03ah,055h,0e0h,0feh,001h,028h,001h,0afh,032h,051h,0e0h	; a14a  #~2W.:U...(..2Q.
	defb 0c9h,008h,000h,004h,008h,004h,008h,001h,008h,008h,004h,008h,004h,004h,004h,004h	; a15a  ................
	defb 008h,001h,008h,008h,004h,008h,004h,004h,004h,004h,008h,004h,008h,001h,002h,008h	; a16a  ................
	defb 004h,03ah,01ah,0d3h,0feh,033h,038h,002h,0d6h,032h,03dh,032h,053h,0e0h,03ah,01bh	; a17a  .:...38..2=2S.:.
	defb 0d3h,0feh,051h,038h,003h,0d6h,050h,027h,032h,052h,0e0h,0c9h,03ah,01ah,0d3h,00eh	; a18a  ..Q8..P'2R..:...
	defb 008h,0cdh,01eh,0a2h,07dh,032h,003h,0e1h,021h,0c0h,000h,022h,0b8h,0e1h,0c9h,03ah	; a19a  ....}2..!.."...:
	defb 01ah,0d3h,00eh,006h,0cdh,01eh,0a2h,07bh,032h,042h,0e0h,07dh,02ah,00ah,0d3h,077h	; a1aa  .......{2B.}*..w
	defb 0cdh,03dh,0a2h,03eh,004h,032h,001h,0e0h,03eh,008h,032h,000h,0e0h,0c9h,0cdh,03dh	; a1ba  .=.>.2..>.2....=
	defb 0a2h,02ah,004h,0d3h,036h,007h,0c9h,03ah,01ah,0d3h,03dh,02ah,00ah,0d3h,077h,0c9h	; a1ca  .*..6..:..=*..w.
	defb 03ah,01ah,0d3h,03dh,032h,006h,0e2h,0cdh,022h,0a1h,03ah,01ah,0d3h,00eh,003h,0cdh	; a1da  :..=2...".:.....
	defb 01eh,0a2h,07bh,0e6h,00fh,00fh,00fh,00fh,00fh,085h,032h,007h,0e2h,03eh,009h,02ah	; a1ea  ..{.......2..>.*
	defb 004h,0d3h,077h,0c3h,03dh,0a2h,03ah,01ah,0d3h,00eh,008h,0cdh,01eh,0a2h,07dh,02ah	; a1fa  ..w.=.:.......}*
	defb 00ah,0d3h,077h,07bh,0feh,002h,038h,002h,03eh,002h,032h,06ah,0e0h,03ah,01bh,0d3h	; a20a  ..w{..8.>.2j.:..
	defb 032h,053h,0e0h,0c9h	; a21a

; ======================================================================
; CODIGO 0xa21e..0xa23d  (31 bytes)
; ======================================================================


L_A21E:
	dec a			;a21e
	ld e,a			;a21f
	ld d,000h		;a220
	ld b,d			;a222
	ld hl,00000h		;a223
	exx			;a226
	ld b,010h		;a227
L_A229:
	exx			;a229
	sla e		;a22a
	rl d		;a22c
	adc hl,hl		;a22e
	sbc hl,bc		;a230
	jr c,L_A237		;a232
	inc e			;a234
	jr L_A238		;a235
L_A237:
	add hl,bc			;a237
L_A238:
	exx			;a238
	djnz L_A229		;a239
	exx			;a23b
	ret			;a23c

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa23d..0xa24f  (18 bytes)
DATA_A23D:
	defb 021h,000h,038h,0afh,001h,000h,003h,0cdh,056h,000h,021h,000h,03bh,03eh,0d0h,0c3h	; a23d  !.8.....V.!..>..
	defb 04dh,000h	; a24d

; ======================================================================
; CODIGO 0xa24f..0xa2b1  (98 bytes)
; ======================================================================


L_A24F:
	call L_A2DE		;a24f
	call L_A263		;a252
	ld a,(0d301h)		;a255
	ld b,a			;a258
	cp 036h		;a259
	jr nz,$+112		;a25b
	ld a,004h		;a25d
	ld (0d312h),a		;a25f
	ret			;a262
L_A263:
	ld hl,(0d300h)		;a263
	ld a,l			;a266
	ld l,h			;a267
	ld h,a			;a268
	ld de,00754h		;a269
	rst 20h			;a26c
	jr c,L_A289		;a26d
	ld hl,04028h		;a26f
	ld de,0d4f6h		;a272
	ld bc,00006h		;a275
	call 08d74h		;a278
	ld hl,0d4f6h		;a27b
	ld a,(hl)			;a27e
	res 7,(hl)		;a27f
	add a,a			;a281
	ret nc			;a282
	ld a,001h		;a283
	ld (0d4d4h),a		;a285
	ret			;a288
L_A289:
	ex de,hl			;a289
	ld hl,0a2bdh		;a28a
L_A28D:
	ld a,(hl)			;a28d
	inc hl			;a28e
	cp 0ffh		;a28f
	jr z,L_A2A2		;a291
	cp e			;a293
	jr nz,L_A29A		;a294
	ld a,(hl)			;a296
	cp d			;a297
	jr z,L_A29D		;a298
L_A29A:
	inc hl			;a29a
	jr L_A28D		;a29b
L_A29D:
	ld hl,0a2b1h		;a29d
	jr L_A2A5		;a2a0
L_A2A2:
	ld hl,0a2b7h		;a2a2
L_A2A5:
	ld de,0d4f6h		;a2a5
	ld bc,00006h		;a2a8
	ldir		;a2ab
	call L_A370		;a2ad
	ret			;a2b0

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa2b1..0xa2cb  (26 bytes)
DATA_A2B1:
	defb 001h,001h,000h,002h,080h,0f6h,000h,000h,000h,000h,0ffh,0ffh,044h,007h,045h,007h	; a2b1  ............D.E.
	defb 047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh	; a2c1  G.H.P.S...

; ======================================================================
; CODIGO 0xa2cb..0xa392  (199 bytes)
; ======================================================================


L_A2CB:
	ld a,b			;a2cb
	sub 003h		;a2cc
	cp 002h		;a2ce
	jr c,L_A2D8		;a2d0
	ld a,b			;a2d2
	sub 010h		;a2d3
	cp 002h		;a2d5
	ret nc			;a2d7
L_A2D8:
	ld a,001h		;a2d8
	ld (0d339h),a		;a2da
	ret			;a2dd
L_A2DE:
	xor a			;a2de
	ld (0d4d4h),a		;a2df
	ld hl,045d0h		;a2e2
	ld de,0d300h		;a2e5
	ld bc,00016h		;a2e8
	ldir		;a2eb
	ld a,0ffh		;a2ed
	ld (0d313h),a		;a2ef
	ld hl,04010h		;a2f2
	call 08398h		;a2f5
	ld hl,04241h		;a2f8
	rst 20h			;a2fb
	jr nz,L_A30A		;a2fc
	ld hl,04012h		;a2fe
	ld de,0d300h		;a301
	ld bc,00013h		;a304
	jp 08d74h		;a307
L_A30A:
	ld hl,04645h		;a30a
	rst 20h			;a30d
	jr z,L_A317		;a30e
	ld hl,04443h		;a310
	rst 20h			;a313
	jp nz,L_A39E		;a314
L_A317:
	ld hl,04012h		;a317
	ld de,0d351h		;a31a
	ld bc,0002dh		;a31d
	call 08d74h		;a320
	call L_A370		;a323
	ld hl,0d351h		;a326
	ld de,0d300h		;a329
	ldi		;a32c
	ldi		;a32e
	ld a,0ffh		;a330
	ld (de),a			;a332
	inc de			;a333
	inc de			;a334
	ld a,(hl)			;a335
	rra			;a336
	jr c,L_A344		;a337
	inc hl			;a339
	ld bc,00002h		;a33a
	ldir		;a33d
	ld de,0d312h		;a33f
	ldi		;a342
L_A344:
	rra			;a344
	jr c,L_A353		;a345
	ld de,0d30ah		;a347
	ldi		;a34a
	ldi		;a34c
	ld de,0d313h		;a34e
	ldi		;a351
L_A353:
	ld ix,0a392h		;a353
	ld b,006h		;a357
L_A359:
	push bc			;a359
	rra			;a35a
	jr c,L_A368		;a35b
	ld e,(ix+000h)		;a35d
	ld d,(ix+001h)		;a360
	ld bc,00002h		;a363
	ldir		;a366
L_A368:
	pop bc			;a368
	inc ix		;a369
	inc ix		;a36b
	djnz L_A359		;a36d
	ret			;a36f
L_A370:
	ld hl,(0d351h)		;a370
	ld a,h			;a373
	ld h,l			;a374
	ld l,a			;a375
	ld de,00751h		;a376
	rst 20h			;a379
	jr z,L_A38C		;a37a
	ld de,00752h		;a37c
	rst 20h			;a37f
	jr z,L_A38C		;a380
	ld de,00758h		;a382
	rst 20h			;a385
	ret c			;a386
	ld a,(0d379h)		;a387
	add a,a			;a38a
	ret nc			;a38b
L_A38C:
	ld a,001h		;a38c
	ld (0d4d4h),a		;a38e
	ret			;a391

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa392..0xa39e  (12 bytes)
DATA_A392:
	defb 008h,0d3h,00ch,0d3h,00eh,0d3h,010h,0d3h,006h,0d3h,014h,0d3h	; a392  ............

; ======================================================================
; CODIGO 0xa39e..0xa3eb  (77 bytes)
; ======================================================================


L_A39E:
	ld a,(0d12fh)		;a39e
	ld de,00000h		;a3a1
	ld hl,05000h		;a3a4
	ld b,000h		;a3a7
L_A3A9:
	push af			;a3a9
	push bc			;a3aa
	push de			;a3ab
	call 0000ch		;a3ac   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;a3af
	pop bc			;a3b0
	add a,e			;a3b1
	ld e,a			;a3b2
	jr nc,L_A3B6		;a3b3
	inc d			;a3b5
L_A3B6:
	pop af			;a3b6
	inc hl			;a3b7
	djnz L_A3A9		;a3b8
	ld ix,044beh		;a3ba
L_A3BE:
	ld l,(ix+000h)		;a3be
	ld h,(ix+001h)		;a3c1
	ld a,l			;a3c4
	or h			;a3c5
	ret z			;a3c6
	rst 20h			;a3c7
	jr z,L_A3D4		;a3c8
	inc ix		;a3ca
	inc ix		;a3cc
	inc ix		;a3ce
	inc ix		;a3d0
	jr L_A3BE		;a3d2
L_A3D4:
	push de			;a3d4
	ld l,(ix+002h)		;a3d5
	ld h,(ix+003h)		;a3d8
	ld de,0d300h		;a3db
	ld bc,00013h		;a3de
	ldir		;a3e1
	pop de			;a3e3
	scf			;a3e4
	ret			;a3e5
L_A3E6:
	add a,l			;a3e6
	ld l,a			;a3e7
	ret nc			;a3e8
	inc h			;a3e9
	ret			;a3ea

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa3eb..0xa47f  (148 bytes)
DATA_A3EB:
	defb 083h,05fh,0d0h,014h,0c9h,0c5h,0e5h,047h,03ah,007h,000h,03ch,04fh,0f3h,0edh,041h	; a3eb  ._.....G:..<O..A
	defb 03eh,090h,0edh,079h,00ch,0edh,051h,0f5h,0f1h,0edh,059h,0e1h,0c1h,0fbh,0c9h,03ah	; a3fb  >..y..Q...Y....:
	defb 02dh,000h,0a7h,0c8h,021h,023h,0a4h,006h,010h,03eh,000h,056h,023h,05eh,023h,0f5h	; a40b  -...!#...>.V#^#.
	defb 0cdh,0f0h,0a3h,0f1h,03ch,010h,0f4h,0c9h,000h,000h,000h,000h,011h,006h,033h,007h	; a41b  ....<.........3.
	defb 017h,001h,027h,003h,051h,001h,027h,006h,071h,001h,073h,003h,061h,006h,064h,006h	; a42b  ..'.Q.'.q.s.a.d.
	defb 011h,004h,065h,002h,055h,005h,077h,007h,07eh,023h,03ch,0c8h,03dh,056h,023h,05eh	; a43b  ..e.U.w.~#<.=V#^
	defb 023h,0cdh,0f0h,0a3h,018h,0f2h,021h,077h,0a4h,001h,000h,008h,0c5h,046h,0cdh,047h	; a44b  #.....!w.....F.G
	defb 000h,0c1h,023h,00ch,010h,0f6h,03ah,02dh,000h,0a7h,0c8h,001h,017h,000h,0cdh,047h	; a45b  ..#...:-.......G
	defb 000h,03ah,0e8h,0ffh,0e6h,07fh,047h,00eh,009h,0c3h,047h,000h,002h,0e2h,00eh,07fh	; a46b  .:....G...G.....
	defb 007h,076h,003h,0e1h	; a47b

; ======================================================================
; CODIGO 0xa47f..0xa4b8  (57 bytes)
; ======================================================================


L_A47F:
	ld hl,03800h		;a47f
	ld bc,00300h		;a482
	xor a			;a485
	call 00056h		;a486   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;a489
	ld a,0d0h		;a48c
	jp 0004dh		;a48e   ; BIOS WRTVRM - Writes data in VRAM
L_A491:
	ld d,003h		;a491
L_A493:
	push bc			;a493
	push de			;a494
	call 00056h		;a495   ; BIOS FILVRM - Fills VRAM with value
	ld bc,00800h		;a498
	add hl,bc			;a49b
	pop de			;a49c
	pop bc			;a49d
	dec d			;a49e
	jr nz,L_A493		;a49f
	ret			;a4a1
L_A4A2:
	ld a,003h		;a4a2
L_A4A4:
	push af			;a4a4
	push bc			;a4a5
	push hl			;a4a6
	push de			;a4a7
	call 0005ch		;a4a8   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop de			;a4ab
	ld hl,00800h		;a4ac
	add hl,de			;a4af
	ex de,hl			;a4b0
	pop hl			;a4b1
	pop bc			;a4b2
	pop af			;a4b3
	dec a			;a4b4
	jr nz,L_A4A4		;a4b5
	ret			;a4b7

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa4b8..0xa4cb  (19 bytes)
DATA_A4B8:
	defb 006h,003h,0c5h,0e5h,0d5h,0cdh,0cfh,0a4h,0d1h,021h,000h,008h,019h,0ebh,0e1h,0c1h	; a4b8  .........!......
	defb 010h,0f0h,0c9h	; a4c8

; ======================================================================
; CODIGO 0xa4cb..0xa51c  (81 bytes)
; ======================================================================


L_A4CB:
	ld e,(hl)			;a4cb
	inc hl			;a4cc
	ld d,(hl)			;a4cd
	inc hl			;a4ce
L_A4CF:
	ex de,hl			;a4cf
	call L_A4FF		;a4d0
	ex de,hl			;a4d3
	ld a,(00007h)		;a4d4
	ld c,a			;a4d7
L_A4D8:
	ld a,(hl)			;a4d8
	and 07fh		;a4d9
	ld b,a			;a4db
	ld a,(hl)			;a4dc
	inc hl			;a4dd
	jr nz,L_A4E4		;a4de
	cp b			;a4e0
	jr nz,L_A4CB		;a4e1
	ret			;a4e3
L_A4E4:
	cp b			;a4e4
	jr z,L_A4F2		;a4e5
L_A4E7:
	ld a,(hl)			;a4e7
	inc hl			;a4e8
	out (c),a		;a4e9
	inc de			;a4eb
	push hl			;a4ec
	pop hl			;a4ed
	djnz L_A4E7		;a4ee
	jr L_A4D8		;a4f0
L_A4F2:
	ld a,(hl)			;a4f2
	inc hl			;a4f3
L_A4F4:
	out (c),a		;a4f4
	inc de			;a4f6
	push ix		;a4f7
	pop ix		;a4f9
	djnz L_A4F4		;a4fb
	jr L_A4D8		;a4fd
L_A4FF:
	push af			;a4ff
	ld a,(0002dh)		;a500
	and a			;a503
	jr nz,L_A50B		;a504
	call 00053h		;a506   ; BIOS SETWRT - Enables VDP to write
	pop af			;a509
	ret			;a50a
L_A50B:
	call 00171h		;a50b   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	pop af			;a50e
	ret			;a50f
L_A510:
	pop hl			;a510
	add a,a			;a511
	add a,l			;a512
	ld l,a			;a513
	jr nc,L_A517		;a514
	inc h			;a516
L_A517:
	ld e,(hl)			;a517
	inc hl			;a518
	ld d,(hl)			;a519
	ex de,hl			;a51a
	jp (hl)			;a51b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa51c..0xa520  (4 bytes)
DATA_A51C:
	defb 00eh,000h,018h,006h	; a51c

; ======================================================================
; CODIGO 0xa520..0xa54b  (43 bytes)
; ======================================================================


L_A520:
	ld c,0ffh		;a520
	jr L_A52A		;a522
L_A524:
	ld c,0ffh		;a524
L_A526:
	ld e,(hl)			;a526
	inc hl			;a527
	ld d,(hl)			;a528
	inc hl			;a529
L_A52A:
	ld a,(hl)			;a52a
	inc hl			;a52b
	ld b,a			;a52c
	inc b			;a52d
	ret z			;a52e
	inc b			;a52f
	jr z,L_A526		;a530
	and c			;a532
	ex de,hl			;a533
	call 0004dh		;a534   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;a537
	inc de			;a538
	jr L_A52A		;a539
L_A53B:
	push bc			;a53b
	ld b,000h		;a53c
	push af			;a53e
	call 00056h		;a53f   ; BIOS FILVRM - Fills VRAM with value
	pop af			;a542
	ld bc,00020h		;a543
	add hl,bc			;a546
	pop bc			;a547
	djnz L_A53B		;a548
	ret			;a54a

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa54b..0xa56e  (35 bytes)
DATA_A54B:
	defb 006h,010h,011h,000h,000h,029h,07bh,08fh,027h,05fh,07ah,08fh,027h,057h,010h,0f5h	; a54b  .....){.'_z.'W..
	defb 0c9h,04fh,0e6h,0f0h,00fh,00fh,00fh,00fh,087h,047h,087h,087h,080h,047h,079h,0e6h	; a55b  .O.......G...Gy.
	defb 00fh,080h,0c9h	; a56b

; ======================================================================
; CODIGO 0xa56e..0xa64b  (221 bytes)
; ======================================================================


L_A56E:
	ld bc,00613h		;a56e
	ld hl,(0d16eh)		;a571
	xor a			;a574
	jp L_A53B		;a575
L_A578:
	ld hl,0d12ah		;a578
	ld a,(hl)			;a57b
	or a			;a57c
	ret nz			;a57d
	dec a			;a57e
	ld (hl),a			;a57f
	ld de,0d8b1h		;a580
	ld hl,01000h		;a583
	ld bc,00080h		;a586
	call L_A5DC		;a589
	ld de,0d500h		;a58c
	ld hl,01180h		;a58f
	ld bc,00158h		;a592
	call L_A5DC		;a595
	ld hl,03a00h		;a598
	ld de,0d7b0h		;a59b
	ld bc,00100h		;a59e
	call 00059h		;a5a1   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,03b00h		;a5a4
	ld de,0d8b0h		;a5a7
	ld bc,00001h		;a5aa
	call 00059h		;a5ad   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,01000h		;a5b0
	ld bc,00008h		;a5b3
	ld a,055h		;a5b6
	call 00056h		;a5b8   ; BIOS FILVRM - Fills VRAM with value
	call L_A655		;a5bb
	ld ix,0409dh		;a5be
	ld iy,(0d12dh)		;a5c2
	call 0001ch		;a5c6   ; BIOS CALSLT - Executes inter-slot call
	ld hl,01180h		;a5c9
	ld a,0f5h		;a5cc
	ld bc,00158h		;a5ce
	call 00056h		;a5d1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;a5d4
	ld a,0d0h		;a5d7
	jp 0004dh		;a5d9   ; BIOS WRTVRM - Writes data in VRAM
L_A5DC:
	push bc			;a5dc
	push de			;a5dd
	push hl			;a5de
	call 00059h		;a5df   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;a5e2
	ld bc,02000h		;a5e3
	add hl,bc			;a5e6
	pop de			;a5e7
	pop bc			;a5e8
	ex de,hl			;a5e9
	add hl,bc			;a5ea
	ex de,hl			;a5eb
	jp 00059h		;a5ec   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_A5EF:
	ld hl,0d12ah		;a5ef
	ld a,(hl)			;a5f2
	or a			;a5f3
	ret z			;a5f4
	xor a			;a5f5
	ld (hl),a			;a5f6
	call L_A655		;a5f7
	ld hl,0d8b1h		;a5fa
	ld de,01000h		;a5fd
	ld bc,00080h		;a600
	call L_A62A		;a603
	ld hl,0d500h		;a606
	ld de,01180h		;a609
	ld bc,00158h		;a60c
	call L_A62A		;a60f
	ld hl,0d7b0h		;a612
	ld de,03a00h		;a615
	ld bc,00100h		;a618
	call 0005ch		;a61b   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0d8b0h		;a61e
	ld de,03b00h		;a621
	ld bc,00001h		;a624
	jp 0005ch		;a627   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_A62A:
	push bc			;a62a
	push hl			;a62b
	push de			;a62c
	call 0005ch		;a62d   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;a630
	ld bc,02000h		;a631
	add hl,bc			;a634
	pop de			;a635
	pop bc			;a636
	ex de,hl			;a637
	add hl,bc			;a638
	jp 0005ch		;a639   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_A63C:
	ld a,(0d13dh)		;a63c
	or a			;a63f
	ret z			;a640
	jp L_A578		;a641
L_A644:
	ld a,(0d13dh)		;a644
	or a			;a647
	ret z			;a648
	jr L_A5EF		;a649

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa64b..0xa655  (10 bytes)
DATA_A64B:
	defb 03ah,06dh,0d1h,0feh,03ah,021h,000h,039h,038h,003h	; a64b  :m..:!.98.

; ======================================================================
; CODIGO 0xa655..0xa770  (283 bytes)
; ======================================================================


L_A655:
	ld hl,03a00h		;a655
	ld bc,00100h		;a658
	xor a			;a65b
	jp 00056h		;a65c   ; BIOS FILVRM - Fills VRAM with value
L_A65F:
	ld (0d167h),a		;a65f
	or a			;a662
	ld a,b			;a663
	jr nz,L_A668		;a664
	ld a,008h		;a666
L_A668:
	ld (0d164h),a		;a668
	ld (0d168h),hl		;a66b
	ld (0d16ah),hl		;a66e
	call L_A778		;a671
	call L_A731		;a674
L_A677:
	call 0009fh		;a677   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;a67a
	ld b,a			;a67c
	jr nz,L_A687		;a67d
	ld a,(0d165h)		;a67f
	ld (0d163h),a		;a682
	or a			;a685
	ret			;a686
L_A687:
	cp 01dh		;a687
	jr z,L_A68F		;a689
	cp 008h		;a68b
	jr nz,L_A6B4		;a68d
L_A68F:
	call L_A78F		;a68f
	ld a,(0d165h)		;a692
	ld hl,0d141h		;a695
	call L_A3E6		;a698
	ld a,(hl)			;a69b
	sub 03ch		;a69c
	jr nz,L_A6A3		;a69e
	ld (0d166h),a		;a6a0
L_A6A3:
	ld hl,0d165h		;a6a3
	dec (hl)			;a6a6
	call L_A788		;a6a7
	dec hl			;a6aa
	ld (0d168h),hl		;a6ab
	call L_A778		;a6ae
	jp L_A677		;a6b1
L_A6B4:
	cp 02eh		;a6b4
	jr nz,L_A6CF		;a6b6
	ld a,(0d167h)		;a6b8
	cp 0feh		;a6bb
	jp nz,L_A677		;a6bd
	call L_A78F		;a6c0
	ld a,03ch		;a6c3
	ld hl,0d166h		;a6c5
	cp (hl)			;a6c8
	jp z,L_A677		;a6c9
	ld (hl),a			;a6cc
	jr L_A6F9		;a6cd
L_A6CF:
	ld c,a			;a6cf
	sub 030h		;a6d0
	cp 00ah		;a6d2
	jr nc,L_A6D9		;a6d4
	ld a,c			;a6d6
	jr L_A6F9		;a6d7
L_A6D9:
	ld a,c			;a6d9
	sub 041h		;a6da
	cp 01ah		;a6dc
	jr nc,L_A6EC		;a6de
	ld a,c			;a6e0
L_A6E1:
	ex af,af'			;a6e1
	ld a,(0d167h)		;a6e2
	inc a			;a6e5
	jp z,L_A677		;a6e6
	ex af,af'			;a6e9
	jr L_A6F9		;a6ea
L_A6EC:
	ld a,c			;a6ec
	sub 061h		;a6ed
	cp 01ah		;a6ef
	jp nc,L_A677		;a6f1
	ld a,c			;a6f4
	sub 020h		;a6f5
	jr L_A6E1		;a6f7
L_A6F9:
	ld b,a			;a6f9
	ld hl,0d165h		;a6fa
	ld a,(0d164h)		;a6fd
	cp (hl)			;a700
	jp z,L_A677		;a701
	inc (hl)			;a704
	ld a,(hl)			;a705
	cp 001h		;a706
	jr nz,L_A716		;a708
	push bc			;a70a
	ld hl,(0d16ah)		;a70b
	ld bc,0000eh		;a70e
	xor a			;a711
	call 00056h		;a712   ; BIOS FILVRM - Fills VRAM with value
	pop bc			;a715
L_A716:
	ld hl,(0d168h)		;a716
	ld a,b			;a719
	call 0004dh		;a71a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a71d
	ld (0d168h),hl		;a71e
	call L_A778		;a721
	ld a,(0d165h)		;a724
	ld hl,0d141h		;a727
	call L_A3E6		;a72a
	ld (hl),b			;a72d
	jp L_A677		;a72e
L_A731:
	ld hl,0d142h		;a731
	ld de,0d143h		;a734
	ld (hl),000h		;a737
	ld bc,0001fh		;a739
	ldir		;a73c
	call L_A74F		;a73e
	call 00156h		;a741   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;a744
	ld (0d163h),a		;a745
	ld (0d165h),a		;a748
	ld (0d166h),a		;a74b
	ret			;a74e
L_A74F:
	ld hl,0a770h		;a74f
	ld bc,00008h		;a752
	ld a,(0d13dh)		;a755
	or a			;a758
	jr nz,L_A76A		;a759
	ld a,(0d4d3h)		;a75b
	and a			;a75e
	ld de,021d0h		;a75f
	jr z,L_A767		;a762
	ld de,02080h		;a764
L_A767:
	jp L_A4A2		;a767
L_A76A:
	ld de,031d0h		;a76a
	jp 0005ch		;a76d   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa770..0xa778  (8 bytes)
DATA_A770:
	defb 000h,010h,018h,0fch,0feh,0fch,018h,010h	; a770  ........

; ======================================================================
; CODIGO 0xa778..0xa941  (457 bytes)
; ======================================================================


L_A778:
	ld hl,(0d168h)		;a778
	ld a,(0d4d3h)		;a77b
	and a			;a77e
	ld a,03ah		;a77f
	jr z,L_A785		;a781
	ld a,010h		;a783
L_A785:
	jp 0004dh		;a785   ; BIOS WRTVRM - Writes data in VRAM
L_A788:
	ld hl,(0d168h)		;a788
	xor a			;a78b
	jp 0004dh		;a78c   ; BIOS WRTVRM - Writes data in VRAM
L_A78F:
	ld a,(0d165h)		;a78f
	or a			;a792
	ret nz			;a793
	pop hl			;a794
	jp L_A677		;a795
L_A798:
	call L_A7D1		;a798
	call L_A818		;a79b
L_A79E:
	call 0009fh		;a79e   ; BIOS CHGET - One character input (waiting)
	cp 020h		;a7a1
	jr z,L_A7C0		;a7a3
	cp 01bh		;a7a5
	jr z,L_A7AF		;a7a7
	ld b,a			;a7a9
	call L_A7E3		;a7aa
	jr L_A79E		;a7ad
L_A7AF:
	or 0ffh		;a7af
	ret			;a7b1
L_A7B2:
	call L_A7D1		;a7b2
	call L_A818		;a7b5
L_A7B8:
	call 0009fh		;a7b8   ; BIOS CHGET - One character input (waiting)
	cp 020h		;a7bb
	ld b,a			;a7bd
	jr nz,L_A7CB		;a7be
L_A7C0:
	call L_A788		;a7c0
	ld a,(0d165h)		;a7c3
	ld (0d163h),a		;a7c6
	or a			;a7c9
	ret			;a7ca
L_A7CB:
	call L_A7E3		;a7cb
	jp L_A7B8		;a7ce
L_A7D1:
	ld a,b			;a7d1
	dec a			;a7d2
	ld (0d164h),a		;a7d3
	ld (0d16ah),hl		;a7d6
	ld a,(hl)			;a7d9
	inc hl			;a7da
	ld h,(hl)			;a7db
	ld l,a			;a7dc
	ld (0d168h),hl		;a7dd
	jp L_A778		;a7e0
L_A7E3:
	ld c,0ffh		;a7e3
	cp 01eh		;a7e5
	jr z,L_A7EE		;a7e7
	ld c,001h		;a7e9
	cp 01fh		;a7eb
	ret nz			;a7ed
L_A7EE:
	ld hl,0d164h		;a7ee
	ld de,0d165h		;a7f1
	ld a,(de)			;a7f4
	add a,c			;a7f5
	jp p,L_A7FA		;a7f6
	ld a,(hl)			;a7f9
L_A7FA:
	cp (hl)			;a7fa
	jr c,L_A800		;a7fb
	jr z,L_A800		;a7fd
	xor a			;a7ff
L_A800:
	ld (de),a			;a800
	ld b,a			;a801
	ld hl,(0d16ah)		;a802
	add a,a			;a805
	call L_A3E6		;a806
	ld a,(hl)			;a809
	inc hl			;a80a
	ld h,(hl)			;a80b
	ld l,a			;a80c
	push hl			;a80d
	call L_A788		;a80e
	pop hl			;a811
	ld (0d168h),hl		;a812
	jp L_A778		;a815
L_A818:
	call L_A74F		;a818
	call 00156h		;a81b   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;a81e
	ld (0d163h),a		;a81f
	ld (0d165h),a		;a822
	ld (0d166h),a		;a825
	ret			;a828
L_A829:
	ld hl,0c442h		;a829
	ld de,0c002h		;a82c
L_A82F:
	ld a,081h		;a82f
	ld (0d13eh),a		;a831
	ld c,(hl)			;a834
	ld (0d13fh),de		;a835
	inc de			;a839
	ld a,c			;a83a
	ld (de),a			;a83b
	inc hl			;a83c
	inc de			;a83d
	call L_A8B2		;a83e
	jp z,L_A8D1		;a841
	ld a,c			;a844
	cp (hl)			;a845
	jr z,L_A885		;a846
	ld a,001h		;a848
	ld (0d13eh),a		;a84a
L_A84D:
	ld c,(hl)			;a84d
	inc hl			;a84e
	ld a,c			;a84f
	ld (de),a			;a850
	inc de			;a851
	call L_A8B2		;a852
	jp z,L_A8C8		;a855
	cp (hl)			;a858
	jr nz,L_A878		;a859
	inc hl			;a85b
	call L_A8B2		;a85c
	jr z,L_A8BD		;a85f
	cp (hl)			;a861
	dec hl			;a862
	jr nz,L_A878		;a863
L_A865:
	dec hl			;a865
	dec de			;a866
	push hl			;a867
	ld hl,(0d13fh)		;a868
	ld a,(0d13eh)		;a86b
	set 7,a		;a86e
	ld (hl),a			;a870
	pop hl			;a871
	ld (0d13fh),de		;a872
	jr L_A82F		;a876
L_A878:
	ld a,(0d13eh)		;a878
	cp 07bh		;a87b
	jr z,L_A865		;a87d
	inc a			;a87f
	ld (0d13eh),a		;a880
	jr L_A84D		;a883
L_A885:
	ld a,002h		;a885
	ld (0d13eh),a		;a887
L_A88A:
	inc hl			;a88a
	call L_A8B2		;a88b
	jr z,L_A8D1		;a88e
	ld a,c			;a890
	cp (hl)			;a891
	jr z,L_A8A5		;a892
L_A894:
	ld de,(0d13fh)		;a894
	ld a,(0d13eh)		;a898
	ld (de),a			;a89b
	inc de			;a89c
	inc de			;a89d
	ld (0d13fh),de		;a89e
	jp L_A82F		;a8a2
L_A8A5:
	ld a,(0d13eh)		;a8a5
	cp 07bh		;a8a8
	jr z,L_A894		;a8aa
	inc a			;a8ac
	ld (0d13eh),a		;a8ad
	jr L_A88A		;a8b0
L_A8B2:
	push hl			;a8b2
	push de			;a8b3
	ld de,0c4c2h		;a8b4
	and a			;a8b7
	sbc hl,de		;a8b8
	pop de			;a8ba
	pop hl			;a8bb
	ret			;a8bc
L_A8BD:
	dec hl			;a8bd
	ld a,(hl)			;a8be
	ld (de),a			;a8bf
	inc de			;a8c0
	ld a,(0d13eh)		;a8c1
	inc a			;a8c4
	ld (0d13eh),a		;a8c5
L_A8C8:
	ld a,(0d13eh)		;a8c8
	inc a			;a8cb
	set 7,a		;a8cc
	ld (0d13eh),a		;a8ce
L_A8D1:
	xor a			;a8d1
	ld (de),a			;a8d2
	ld a,(0d13eh)		;a8d3
	ld hl,(0d13fh)		;a8d6
	ld (hl),a			;a8d9
	ex de,hl			;a8da
	ld de,0c001h		;a8db
	and a			;a8de
	sbc hl,de		;a8df
	ld (0c000h),hl		;a8e1
	ret			;a8e4
L_A8E5:
	di			;a8e5
	ld hl,0a965h		;a8e6
	ld de,0fd9fh		;a8e9
	ld bc,00003h		;a8ec
	ldir		;a8ef
	ld hl,00000h		;a8f1
	add hl,sp			;a8f4
	ld (0f000h),hl		;a8f5
	ei			;a8f8
	call 0448dh		;a8f9
	ld hl,0e000h		;a8fc
	ld de,0e001h		;a8ff
	ld bc,00fffh		;a902
	ld (hl),000h		;a905
	ldir		;a907
	ld hl,(00004h)		;a909
	ld de,02000h		;a90c
	ld bc,007f0h		;a90f
	call L_A4A2		;a912
	ld hl,00000h		;a915
	ld bc,007f0h		;a918
	ld a,0f0h		;a91b
	call L_A491		;a91d
	ld a,(0d12eh)		;a920
	ld (0e000h),a		;a923
	ld a,001h		;a926
	ld (0d4d3h),a		;a928
L_A92B:
	ld hl,04123h		;a92b
	call L_A524		;a92e
	ld b,004h		;a931
	ld hl,04175h		;a933
	call L_A7B2		;a936
	push af			;a939
	call 044adh		;a93a
	pop af			;a93d
	call L_A510		;a93e

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa941..0xa949  (8 bytes)
DATA_A941:
	defb 053h,0a9h,059h,0a9h,05fh,0a9h,049h,0a9h	; a941  S.Y._.I.

; ======================================================================
; CODIGO 0xa949..0xa98c  (67 bytes)
; ======================================================================


L_A949:
	ld a,0c9h		;a949
	ld (0fd9fh),a		;a94b
	xor a			;a94e
	ld (0d4d3h),a		;a94f
	ret			;a952
L_A953:
	call 0417dh		;a953
	jp L_A92B		;a956
L_A959:
	call 04209h		;a959
	jp L_A92B		;a95c
L_A95F:
	call 04333h		;a95f
	jp L_A92B		;a962
L_A965:
	jp L_A968		;a965
L_A968:
	ld a,006h		;a968
	call 00141h		;a96a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;a96d
	jp nz,0013eh		;a96f   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;a972
	call 00141h		;a974   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;a977
	jp c,0013eh		;a978   ; BIOS RDVDP - Reads VDP status register
	xor a			;a97b
	ld (0d4d3h),a		;a97c
	ld a,0c9h		;a97f
	ld (0fd9fh),a		;a981
	call 0013eh		;a984   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f000h)		;a987
	ld sp,hl			;a98a
	ret			;a98b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa98c..0xc000  (5748 bytes)
DATA_A98C:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a98c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a99c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aaac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aabc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aacc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aadc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aaec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aafc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; accc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; addc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aeac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aebc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aecc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aedc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aeec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aefc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; affc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b00c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b01c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b02c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b03c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b04c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b05c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b06c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b07c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b08c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b09c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b10c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b11c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b12c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b13c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b14c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b15c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b16c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b17c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b18c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b19c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b20c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b21c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b22c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b23c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b24c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b25c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b26c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b27c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b28c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b29c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b30c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b31c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b32c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b33c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b34c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b35c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b36c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b37c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b38c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b39c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b40c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b41c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b42c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b43c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b44c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b45c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b46c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b47c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b48c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b49c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b50c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b51c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b52c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b53c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b54c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b55c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b56c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b57c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b58c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b59c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b60c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b61c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b62c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b63c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b64c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b65c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b66c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b67c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b68c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b69c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b70c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b71c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b72c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b73c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b74c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b75c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b76c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b77c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b78c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b79c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b80c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b81c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b82c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b83c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b84c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b85c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b86c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b87c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b88c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b89c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b90c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b91c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b92c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b93c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b94c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b95c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b96c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b97c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b98c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b99c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; baac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; babc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bacc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; badc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; baec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bafc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bccc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bddc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bebc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; becc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bedc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; befc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfec  ................
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
