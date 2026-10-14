; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x6000..0x603a  (58 bytes)
DATA_6000:
	defb 053h,04bh,000h,055h,054h,049h,04ch,049h,054h,059h,0feh,0a7h,039h,054h,045h,04eh	; 6000  SK.UTILITY..9TEN
	defb 04eh,049h,053h,000h,041h,04eh,044h,000h,048h,04fh,043h,04bh,045h,059h,0feh,0e7h	; 6010  NIS.AND.HOCKEY..
	defb 039h,042h,049h,04fh,052h,059h,054h,048h,04dh,0feh,027h,03ah,045h,04eh,044h,0ffh	; 6020  9BIORYTHM.':END.
	defb 026h,039h,066h,039h,0a6h,039h,0e6h,039h,026h,03ah	; 6030  &9f9.9.9&:

; ======================================================================
; CODIGO 0x603a..0x605f  (37 bytes)
; ======================================================================


L_603A:
	call 05f0dh		;603a
	call L_6762		;603d
	call L_62D3		;6040
	ld hl,06273h		;6043
	call L_738F		;6046
	ld de,0384dh		;6049
	call 05c32h		;604c
	ld hl,062c4h		;604f
	ld b,003h		;6052
	call L_7676		;6054
	cp 0ffh		;6057
	jp z,L_665E		;6059
	call L_737B		;605c

; ----------------------------------------------------------------------
; DATOS saltos_605F: tabla de 3 palabras del despachador (call 0x408D en
;   0x605C); lo leen el despachador (6 bytes)
;   0x605f..0x6065  (6 bytes)
DATA_saltos_605F:
	defb 06ah,060h	; 605f
	defb 0e4h,060h	; 6061
	defb 06fh,062h	; 6063

; ======================================================================
; CODIGO 0x6065..0x60b8  (83 bytes)
; ======================================================================


L_6065:
	ld a,(0f281h)		;6065
	inc a			;6068
	ret			;6069
L_606A:
	call L_6065		;606a
	jr z,$-51		;606d
	ld a,(0f282h)		;606f
	inc a			;6072
	jr nz,L_607E		;6073
	ld hl,(0f28ah)		;6075
	ld a,h			;6078
	or l			;6079
	jr z,$-64		;607a
	jr L_6086		;607c
L_607E:
	ld hl,06cd7h		;607e
	call L_683A		;6081
	jr nz,$-74		;6084
L_6086:
	call L_62D3		;6086
	ld hl,060b8h		;6089
	call L_738F		;608c
	ld hl,03974h		;608f
	call L_62CC		;6092
	jp z,L_6266		;6095
	ld hl,0f29bh		;6098
	call L_62DD		;609b
	jp z,L_6266		;609e
	ld hl,0f29ch		;60a1
	call L_6304		;60a4
	ld hl,(0f294h)		;60a7
	ld a,h			;60aa
	or l			;60ab
	ld hl,0f298h		;60ac
	jr z,L_60B3		;60af
	set 2,(hl)		;60b1
L_60B3:
	set 1,(hl)		;60b3
	jp L_6266		;60b5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x60b8..0x60e4  (44 bytes)
DATA_60B8:
	defb 0c5h,038h,040h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,053h,054h,041h,047h	; 60b8  .8@@@MODIFY.STAG
	defb 045h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,040h,0feh,067h,039h,053h,054h	; 60c8  E.NUMBER@@@.g9ST
	defb 041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh	; 60d8  AGE.NUMBER>.

; ======================================================================
; CODIGO 0x60e4..0x6137  (83 bytes)
; ======================================================================


L_60E4:
	call L_6065		;60e4
	jp z,L_603A		;60e7
	ld a,(0f282h)		;60ea
	inc a			;60ed
	jr nz,L_60FA		;60ee
	ld hl,(0f288h)		;60f0
	ld a,h			;60f3
	or l			;60f4
	jp z,L_603A		;60f5
	jr L_6103		;60f8
L_60FA:
	ld hl,06ca6h		;60fa
	call L_683A		;60fd
	jp nz,L_603A		;6100
L_6103:
	call L_62D3		;6103
	ld hl,06137h		;6106
	call L_738F		;6109
	ld hl,03975h		;610c
	call L_62CC		;610f
	jp z,L_6266		;6112
	ld hl,0f299h		;6115
	call L_62DD		;6118
	jp z,L_6266		;611b
	ld hl,0f29ah		;611e
	call L_6304		;6121
	ld hl,0f298h		;6124
	set 0,(hl)		;6127
	ld de,(0f294h)		;6129
	ld a,d			;612d
	or e			;612e
	jp z,L_6266		;612f
	set 2,(hl)		;6132
	jp L_6266		;6134

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6137..0x623b  (260 bytes)
DATA_6137:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h	; 6137  .8@@MODIFY.PLAYE
	defb 052h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,0feh,067h,039h,050h,04ch,041h	; 6147  R.NUMBER@@.g9PLA
	defb 059h,045h,052h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh,0cdh,065h,060h,0cah	; 6157  YER.NUMBER>..e`.
	defb 03ah,060h,02ah,08eh,0f2h,07ch,0b5h,0cah,03ah,060h,0cdh,0d3h,062h,021h,09fh,061h	; 6167  :`*..|..:`..b!.a
	defb 0cdh,08fh,073h,021h,0deh,061h,006h,003h,0cdh,090h,076h,0cdh,07bh,073h,015h,062h	; 6177  ..s!.a....v.{s.b
	defb 08bh,061h,066h,062h,0cdh,0e4h,061h,021h,098h,0f2h,0cbh,0feh,0c3h,066h,062h,04bh	; 6187  .afb..a!.....fbK
	defb 04fh,04eh,041h,04dh,049h,000h,000h,001h,0c6h,038h,040h,040h,052h,041h,04eh,04bh	; 6197  ONAMI....8@@RANK
	defb 049h,04eh,047h,000h,04dh,04fh,044h,045h,040h,040h,0feh,027h,039h,04ch,04fh,041h	; 61a7  ING.MODE@@.'9LOA
	defb 044h,000h,044h,049h,053h,04bh,000h,044h,041h,054h,041h,0feh,067h,039h,043h,04ch	; 61b7  D.DISK.DATA.g9CL
	defb 045h,041h,052h,000h,052h,041h,04eh,04bh,049h,04eh,047h,000h,044h,041h,054h,041h	; 61c7  EAR.RANKING.DATA
	defb 0feh,0a7h,039h,045h,04eh,044h,0ffh,026h,039h,066h,039h,0a6h,039h,021h,039h,092h	; 61d7  ..9END.&9f9.9!9.
	defb 011h,03ah,092h,036h,000h,001h,01dh,000h,0edh,0b0h,021h,057h,092h,011h,058h,092h	; 61e7  .:.6......!W..X.
	defb 036h,03ch,001h,059h,000h,0edh,0b0h,011h,058h,092h,021h,096h,061h,001h,006h,000h	; 61f7  6<.Y....X.!.a...
	defb 0edh,0b0h,011h,039h,092h,021h,09ch,061h,001h,003h,000h,0edh,0b0h,0c9h,0cdh,0b9h	; 6207  ...9.!.a........
	defb 050h,0cah,07ah,061h,03eh,023h,032h,00bh,0f1h,0cdh,03bh,062h,0cdh,0a8h,053h,0dah	; 6217  P.za>#2....b..S.
	defb 071h,061h,021h,0a1h,052h,0cdh,065h,052h,0cdh,0d3h,062h,0cdh,04fh,04ch,0d2h,08eh	; 6227  qa!.R.eR..b.OL..
	defb 061h,0c3h,071h,061h	; 6237

; ======================================================================
; CODIGO 0x623b..0x6273  (56 bytes)
; ======================================================================


L_623B:
	call L_62D3		;623b
	call 05f0dh		;623e
	call 05cfeh		;6241
	call 05d56h		;6244
	call 05d9ah		;6247
	ld hl,052bah		;624a
	call 05265h		;624d
	xor a			;6250
	ld (0922ch),a		;6251
	ld (0922eh),a		;6254
	ld hl,0396ch		;6257
	ld (09231h),hl		;625a
	ld (09233h),hl		;625d
	ld a,080h		;6260
	ld (0922dh),a		;6262
	ret			;6265
L_6266:
	call L_6762		;6266
	call L_62D3		;6269
	jp L_603A		;626c
L_626F:
	di			;626f
	jp L_66BF		;6270

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6273..0x62cc  (89 bytes)
DATA_6273:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,04dh,04fh,044h,045h,000h	; 6273  .8@@MODIFY.MODE.
	defb 04dh,045h,04eh,055h,040h,040h,0feh,027h,039h,04dh,04fh,044h,049h,046h,059h,000h	; 6283  MENU@@.'9MODIFY.
	defb 053h,054h,041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,0feh,067h,039h,04dh	; 6293  STAGE.NUMBER.g9M
	defb 04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h,052h,000h,04eh,055h,04dh	; 62a3  ODIFY.PLAYER.NUM
	defb 042h,045h,052h,0feh,0a7h,039h,053h,054h,041h,052h,054h,000h,047h,041h,04dh,045h	; 62b3  BER..9START.GAME
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h	; 62c3  .&9f9.9.9

; ======================================================================
; CODIGO 0x62cc..0x6384  (184 bytes)
; ======================================================================


L_62CC:
	ld a,0ffh		;62cc
	ld b,002h		;62ce
	jp L_750E		;62d0
L_62D3:
	ld hl,03880h		;62d3
	ld bc,00200h		;62d6
	xor a			;62d9
	jp 00056h		;62da   ; BIOS FILVRM - Fills VRAM with value
L_62DD:
	xor a			;62dd
	ld (hl),a			;62de
	ld a,(0922ch)		;62df
	or a			;62e2
	ret z			;62e3
	ld de,0920bh		;62e4
	cp 001h		;62e7
	jr nz,L_62F1		;62e9
	ld a,(de)			;62eb
	and 00fh		;62ec
	ld (hl),a			;62ee
	or a			;62ef
	ret			;62f0
L_62F1:
	cp 002h		;62f1
	ret nz			;62f3
	ld a,(de)			;62f4
	and 00fh		;62f5
	add a,a			;62f7
	ld b,a			;62f8
	add a,a			;62f9
	add a,a			;62fa
	add a,b			;62fb
	ld b,a			;62fc
	inc de			;62fd
	ld a,(de)			;62fe
	and 00fh		;62ff
	add a,b			;6301
	ld (hl),a			;6302
	ret			;6303
L_6304:
	xor a			;6304
	ld (hl),a			;6305
	ld a,(0922ch)		;6306
	or a			;6309
	ret z			;630a
	ld de,0920bh		;630b
	cp 001h		;630e
	jr nz,L_6318		;6310
	ld a,(de)			;6312
	and 00fh		;6313
	ld (hl),a			;6315
	or a			;6316
	ret			;6317
L_6318:
	cp 002h		;6318
	ret nz			;631a
	ld a,(de)			;631b
	and 00fh		;631c
	add a,a			;631e
	add a,a			;631f
	add a,a			;6320
	add a,a			;6321
	ld b,a			;6322
	inc de			;6323
	ld a,(de)			;6324
	and 00fh		;6325
	add a,b			;6327
	ld (hl),a			;6328
	ret			;6329
L_632A:
	ld hl,06395h		;632a
	ld de,0f130h		;632d
	ld bc,00045h		;6330
	ldir		;6333
	push de			;6335
	ld hl,(0f107h)		;6336
	ld bc,000c0h		;6339
	call L_6371		;633c
	xor a			;633f
	ld (0f11bh),a		;6340
	pop hl			;6343
	push hl			;6344
	ld e,0a0h		;6345
	call L_6353		;6347
	pop hl			;634a
	ret z			;634b
	ld a,001h		;634c
	ld (0f11bh),a		;634e
	ld e,09bh		;6351
L_6353:
	ld bc,00100h		;6353
L_6356:
	ld a,e			;6356
	cpir		;6357
	ret nz			;6359
	jp po,L_636E		;635a
	ld a,0fdh		;635d
	cp (hl)			;635f
	jr nz,L_6356		;6360
	dec hl			;6362
	ld de,06384h		;6363
	ex de,hl			;6366
	ld bc,00005h		;6367
	ldir		;636a
	xor a			;636c
	ret			;636d
L_636E:
	or 0ffh		;636e
	ret			;6370
L_6371:
	push bc			;6371
	push de			;6372
	ld a,(0f104h)		;6373
	call 0000ch		;6376   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;6379
	pop bc			;637a
	ld (de),a			;637b
	inc hl			;637c
	inc de			;637d
	dec bc			;637e
	ld a,b			;637f
	or c			;6380
	jr nz,L_6371		;6381
	ret			;6383

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6384..0x6389  (5 bytes)
DATA_6384:
	defb 005h,0f1h,0cdh,030h,0f1h	; 6384

; ======================================================================
; CODIGO 0x6389..0x669e  (789 bytes)
; ======================================================================


L_6389:
	ld hl,L_64C6		;6389
	ld de,0f230h		;638c
	ld bc,00016h		;638f
	ldir		;6392
	ret			;6394
L_6395:
	di			;6395
	ld a,(0f11eh)		;6396
	and a			;6399
	jr z,L_63A4		;639a
	ld a,(0f103h)		;639c
	ld h,080h		;639f
	call 00024h		;63a1   ; BIOS ENASLT - Switches to specified slot and page definitively
L_63A4:
	ld a,0c3h		;63a4
	ld (0fd9ah),a		;63a6
	ld hl,0f230h		;63a9
	ld (0fd9bh),hl		;63ac
	pop hl			;63af
	dec hl			;63b0
	dec hl			;63b1
	dec hl			;63b2
	ld de,0f175h		;63b3
	and a			;63b6
	sbc hl,de		;63b7
	ld de,(0f107h)		;63b9
	add hl,de			;63bd
	jp (hl)			;63be
L_63BF:
	ld a,(0f104h)		;63bf
	ld hl,04000h		;63c2
	call 00024h		;63c5   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0f175h		;63c8
	ld hl,(0fedch)		;63cb
	ld de,(0f107h)		;63ce
	and a			;63d2
	sbc hl,de		;63d3
	ld de,0f175h		;63d5
	add hl,de			;63d8
	jp (hl)			;63d9
L_63DA:
	di			;63da
	ld a,(0f110h)		;63db
	or a			;63de
	ret nz			;63df
	call 0013eh		;63e0   ; BIOS RDVDP - Reads VDP status register
	ld ix,(0f105h)		;63e3
	ld iy,(0f102h)		;63e7
	ld a,007h		;63eb
	call 00141h		;63ed   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;63f0
	and 010h		;63f1
	ld b,a			;63f3
	ld a,008h		;63f4
	call 00141h		;63f6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;63f9
	rrca			;63fa
	and 006h		;63fb
	or b			;63fd
	ld hl,0f10ch		;63fe
	ld c,(hl)			;6401
	ld (hl),a			;6402
	xor c			;6403
	and (hl)			;6404
	ld c,a			;6405
	ld (0f29eh),a		;6406
	di			;6409
	bit 4,a		;640a
	jr z,L_6415		;640c
	ld ix,L_651F		;640e
	jp 0001ch		;6412   ; BIOS CALSLT - Executes inter-slot call
L_6415:
	ld a,(0f298h)		;6415
	or a			;6418
	jr z,L_6433		;6419
	ld hl,(0f284h)		;641b
	ld a,(hl)			;641e
	ld hl,0f297h		;641f
	cp (hl)			;6422
	jr z,L_6433		;6423
	ld (hl),a			;6425
	ld a,(0f292h)		;6426
	cp (hl)			;6429
	jr nz,L_6433		;642a
	ld ix,06789h		;642c
	jp 0001ch		;6430   ; BIOS CALSLT - Executes inter-slot call
L_6433:
	ld a,(0f109h)		;6433
	rra			;6436
	jr c,L_643B		;6437
	jp (ix)		;6439
L_643B:
	ld a,(0f103h)		;643b
	ld h,040h		;643e
	call 00024h		;6440   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_6468		;6443
	ld a,(0f104h)		;6446
	ld h,040h		;6449
	push af			;644b
	call 00024h		;644c   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;644f
	ld h,080h		;6450
	jp 00024h		;6452   ; BIOS ENASLT - Switches to specified slot and page definitively
L_6455:
	ld h,040h		;6455
	ld a,(0f104h)		;6457
	push af			;645a
	call 00024h		;645b   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;645e
	ld h,080h		;645f
	call 00024h		;6461   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(0f105h)		;6464
	jp (hl)			;6467
L_6468:
	ld a,(0f2a0h)		;6468
	ld h,080h		;646b
	call 00024h		;646d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f29eh)		;6470
	ld c,a			;6473
	ld a,(0f10ah)		;6474
	cp 002h		;6477
	jr z,L_647E		;6479
	jp L_6594		;647b
L_647E:
	ld hl,0f10fh		;647e
	ld de,0f10eh		;6481
	bit 1,c		;6484
	jr z,L_64A0		;6486
	ld a,(hl)			;6488
	or a			;6489
	ret z			;648a
	sub 00dh		;648b
	jr z,L_6491		;648d
	jr nc,L_649C		;648f
L_6491:
	push hl			;6491
	push de			;6492
	call L_656C		;6493
	call L_6534		;6496
	pop de			;6499
	pop hl			;649a
	xor a			;649b
L_649C:
	ld (hl),a			;649c
	xor a			;649d
	ld (de),a			;649e
	ret			;649f
L_64A0:
	bit 2,c		;64a0
	jr z,L_64B8		;64a2
	ld a,00dh		;64a4
	add a,(hl)			;64a6
	jr nc,L_64AB		;64a7
	ld a,0ffh		;64a9
L_64AB:
	ld (hl),a			;64ab
	cp 00dh		;64ac
	jr nz,L_64B5		;64ae
	push de			;64b0
	call L_65EA		;64b1
	pop de			;64b4
L_64B5:
	xor a			;64b5
	ld (de),a			;64b6
	ret			;64b7
L_64B8:
	ld a,(hl)			;64b8
	or a			;64b9
	jr z,L_64C3		;64ba
	ld a,(de)			;64bc
	add a,(hl)			;64bd
	ld (de),a			;64be
	ret nc			;64bf
	jp 0f1abh		;64c0
L_64C3:
	jp L_6534		;64c3
L_64C6:
	di			;64c6
	ld ix,L_64DC		;64c7
	ld iy,(0f102h)		;64cb
	call 0001ch		;64cf   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0f104h)		;64d2
	ld h,080h		;64d5
	call 00024h		;64d7   ; BIOS ENASLT - Switches to specified slot and page definitively
	ei			;64da
	ret			;64db
L_64DC:
	ld a,0c9h		;64dc
	ld (0fd9ah),a		;64de
	ld (0fd9fh),a		;64e1
	ld a,(0f11bh)		;64e4
	ld hl,0fd9fh		;64e7
	and a			;64ea
	jr z,L_64F0		;64eb
	ld hl,0fd9ah		;64ed
L_64F0:
	ld a,0c3h		;64f0
	ld de,0f130h		;64f2
	ld (hl),a			;64f5
	inc hl			;64f6
	ld (hl),e			;64f7
	inc hl			;64f8
	ld (hl),d			;64f9
	ld a,(0f2a0h)		;64fa
	ld h,080h		;64fd
	call 00024h		;64ff   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f11eh)		;6502
	and a			;6505
	jr z,L_6513		;6506
	ld hl,09b80h		;6508
	ld de,0c000h		;650b
	ld bc,01100h		;650e
	ldir		;6511
L_6513:
	ld hl,L_63DA		;6513
	ld de,0f130h		;6516
	ld bc,0008eh		;6519
	ldir		;651c
	ret			;651e
L_651F:
	call 0013eh		;651f   ; BIOS RDVDP - Reads VDP status register
	ld hl,0f109h		;6522
	inc (hl)			;6525
	ld a,(hl)			;6526
	rra			;6527
	jr nc,L_6585		;6528
	xor a			;652a
	ld (0f10ah),a		;652b
	call 00132h		;652e   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call L_656C		;6531
L_6534:
	ld e,000h		;6534
	ld a,008h		;6536
	call 00093h		;6538   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;653b
	call 00093h		;653c   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;653f
	call 00093h		;6540   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f124h)		;6543
	and a			;6546
	ret z			;6547
	ld e,03fh		;6548
	ld a,(0f104h)		;654a
	ld hl,09000h		;654d
	call 00014h		;6550   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,000h		;6553
	ld a,(0f104h)		;6555
	ld hl,0988fh		;6558
	call 00014h		;655b   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;655e
	ld e,a			;6561
	ld a,(0f104h)		;6562
	ld hl,09000h		;6565
	call 00014h		;6568   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;656b
L_656C:
	ld a,008h		;656c
	call 00096h		;656e   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f100h),a		;6571
	ld a,009h		;6574
	call 00096h		;6576   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f101h),a		;6579
	ld a,00ah		;657c
	call 00096h		;657e   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f102h),a		;6581
	ret			;6584
L_6585:
	ld (hl),000h		;6585
	ld a,0ffh		;6587
	call 00132h		;6589   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call L_65EA		;658c
	xor a			;658f
	ld (0f10ah),a		;6590
	ret			;6593
L_6594:
	ld a,001h		;6594
	ld (0f110h),a		;6596
	call L_65A1		;6599
	xor a			;659c
	ld (0f110h),a		;659d
	ret			;65a0
L_65A1:
	call L_6534		;65a1
	ld ix,(0f105h)		;65a4
	ld iy,(0f103h)		;65a8
	ld a,(0f10ah)		;65ac
	or a			;65af
	jp nz,05a0fh		;65b0
	call L_662E		;65b3
	ld a,c			;65b6
	rla			;65b7
	jr c,L_65CE		;65b8
	rla			;65ba
	jr c,L_65E4		;65bb
	rla			;65bd
	jr c,L_65C1		;65be
	ret			;65c0
L_65C1:
	ld a,002h		;65c1
	ld (0f10ah),a		;65c3
	xor a			;65c6
	ld (0f10fh),a		;65c7
	ld (0f10eh),a		;65ca
	ret			;65cd
L_65CE:
	call L_65EA		;65ce
	push ix		;65d1
	push iy		;65d3
	ld a,(0f104h)		;65d5
	ld h,080h		;65d8
	call 00024h		;65da   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop iy		;65dd
	pop ix		;65df
	jp 0001ch		;65e1   ; BIOS CALSLT - Executes inter-slot call
L_65E4:
	ld a,001h		;65e4
	ld (0f10ah),a		;65e6
	ret			;65e9
L_65EA:
	ld a,(0f100h)		;65ea
	ld e,a			;65ed
	ld a,008h		;65ee
	call 00093h		;65f0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f101h)		;65f3
	ld e,a			;65f6
	ld a,009h		;65f7
	call 00093h		;65f9   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f102h)		;65fc
	ld e,a			;65ff
	ld a,00ah		;6600
	call 00093h		;6602   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f124h)		;6605
	and a			;6608
	ret z			;6609
	ld e,03fh		;660a
	ld a,(0f104h)		;660c
	ld hl,09000h		;660f
	call 00014h		;6612   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,01fh		;6615
	ld a,(0f104h)		;6617
	ld hl,0988fh		;661a
	call 00014h		;661d   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;6620
	ld e,a			;6623
	ld a,(0f104h)		;6624
	ld hl,09000h		;6627
	call 00014h		;662a   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;662d
L_662E:
	ld a,001h		;662e
	call 00141h		;6630   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;6633
	and 080h		;6634
	ld d,a			;6636
	ld a,006h		;6637
	call 00141h		;6639   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;663c
	and 0e2h		;663d
	bit 1,a		;663f
	jr z,L_6645		;6641
	or 008h		;6643
L_6645:
	and 0e8h		;6645
	ld e,a			;6647
	ld a,007h		;6648
	call 00141h		;664a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;664d
	and 007h		;664e
	or e			;6650
	rlca			;6651
	rlca			;6652
	rlca			;6653
	or d			;6654
	ld hl,0f10dh		;6655
	ld c,(hl)			;6658
	ld (hl),a			;6659
	xor c			;665a
	and (hl)			;665b
	ld c,a			;665c
	ret			;665d
L_665E:
	call L_66A9		;665e
	call L_672D		;6661
	call 0801bh		;6664
	jr L_6681		;6667
L_6669:
	call L_66A9		;6669
	call L_672D		;666c
	call 08043h		;666f
	call 080d2h		;6672
	call 08117h		;6675
	call 08846h		;6678
	call 08133h		;667b
	call 08134h		;667e
L_6681:
	call 082cah		;6681
	call 0846dh		;6684
	push af			;6687
	call L_673F		;6688
	call 05ec2h		;668b
	call L_672D		;668e
	call L_72EA		;6691
	call 08191h		;6694
	call L_673F		;6697
	pop af			;669a
	call L_737B		;669b

; ----------------------------------------------------------------------
; DATOS saltos_669E: tabla de 3 palabras del despachador (call 0x408D en
;   0x669B); lo leen el despachador (6 bytes)
;   0x669e..0x66a4  (6 bytes)
DATA_saltos_669E:
	defb 0b0h,066h	; 669e
	defb 0e6h,066h	; 66a0
	defb 0f1h,066h	; 66a2

; ======================================================================
; CODIGO 0x66a4..0x6751  (173 bytes)
; ======================================================================


L_66A4:
	call L_672D		;66a4
	jr $-38		;66a7
L_66A9:
	ld a,(0f111h)		;66a9
	ld (0e000h),a		;66ac
	ret			;66af
L_66B0:
	ld a,(0f111h)		;66b0
	inc a			;66b3
	jr nz,L_66A4		;66b4
	ld bc,00107h		;66b6
	call 00047h		;66b9   ; BIOS WRTVDP - Writes data in the VDP-register
	call L_72EA		;66bc
L_66BF:
	di			;66bf
	ld hl,0fd9ah		;66c0
	ld a,0c9h		;66c3
	ld b,00ah		;66c5
L_66C7:
	ld (hl),a			;66c7
	inc hl			;66c8
	djnz L_66C7		;66c9
	xor a			;66cb
	ld (0f109h),a		;66cc
	ld (0f110h),a		;66cf
	jp 0563fh		;66d2
L_66D5:
	ld sp,0f380h		;66d5
	ld a,0ffh		;66d8
	call 00132h		;66da   ; BIOS CHGCAP - Alternates the CAPS lamp status
	xor a			;66dd
	ld (0f298h),a		;66de
	ld (092c7h),a		;66e1
	jr L_66BF		;66e4
L_66E6:
	ld a,(0f111h)		;66e6
	inc a			;66e9
	jp nz,L_66A4		;66ea
	ld a,002h		;66ed
	jr L_66F3		;66ef
L_66F1:
	ld a,001h		;66f1
L_66F3:
	ld (092cfh),a		;66f3
	ld bc,00107h		;66f6
	call 00047h		;66f9   ; BIOS WRTVDP - Writes data in the VDP-register
	call L_72EA		;66fc
	call L_672D		;66ff
	call 08191h		;6702
	call L_673F		;6705
	ld a,(092cfh)		;6708
	cp 002h		;670b
	jp z,L_603A		;670d
	jp 05de5h		;6710
L_6713:
	ld a,(0002dh)		;6713
	and a			;6716
	jr nz,L_6723		;6717
	ld hl,00000h		;6719
	ld bc,04000h		;671c
	xor a			;671f
	jp 00056h		;6720   ; BIOS FILVRM - Fills VRAM with value
L_6723:
	ld hl,00000h		;6723
	ld bc,00000h		;6726
	xor a			;6729
	jp 0016bh		;672a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
L_672D:
	ld a,(0f103h)		;672d
	ld h,080h		;6730
	call 00024h		;6732   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,009h		;6735
	ld (08000h),a		;6737
	inc a			;673a
	ld (0a000h),a		;673b
	ret			;673e
L_673F:
	ld a,002h		;673f
	ld (08000h),a		;6741
	inc a			;6744
	ld (0a000h),a		;6745
	ld a,(0f2a0h)		;6748
	ld h,080h		;674b
	call 00024h		;674d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ret			;6750

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6751..0x6753  (2 bytes)
DATA_6751:
	defb 006h,001h	; 6751

; ======================================================================
; CODIGO 0x6753..0x68ce  (379 bytes)
; ======================================================================


L_6753:
	ld hl,00000h		;6753
L_6756:
	dec hl			;6756
	call 0009ch		;6757   ; BIOS CHSNS - Tests the status of the keyboard buffer
	ret nz			;675a
	ld a,h			;675b
	or l			;675c
	jr nz,L_6756		;675d
	djnz L_6753		;675f
	ret			;6761
L_6762:
	ld hl,03800h		;6762
	ld b,002h		;6765
L_6767:
	push bc			;6767
	ld c,004h		;6768
	call L_6774		;676a
	pop bc			;676d
	ld hl,03a80h		;676e
	djnz L_6767		;6771
	ret			;6773
L_6774:
	ld b,010h		;6774
	ld a,001h		;6776
L_6778:
	call 0004dh		;6778   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;677b
	call 0004dh		;677c   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;677f
	inc a			;6780
	and 00fh		;6781
	djnz L_6778		;6783
	dec c			;6785
	jr nz,L_6774		;6786
	ret			;6788
L_6789:
	ld a,(0f298h)		;6789
	ld b,a			;678c
	bit 0,b		;678d
	call nz,L_67F3		;678f
	bit 1,b		;6792
	call nz,L_6804		;6794
	bit 2,b		;6797
	call nz,L_6819		;6799
	ld a,b			;679c
	and 0f8h		;679d
	ld d,a			;679f
	call L_68E1		;67a0
	jr z,L_67B5		;67a3
	ld a,(0f281h)		;67a5
	cp 015h		;67a8
	jr z,L_67B5		;67aa
	ld hl,0f29dh		;67ac
	inc (hl)			;67af
	bit 1,(hl)		;67b0
	jr nz,L_67B5		;67b2
	ld d,b			;67b4
L_67B5:
	ld hl,0f298h		;67b5
	ld (hl),d			;67b8
	bit 7,d		;67b9
	ret z			;67bb
	res 7,(hl)		;67bc
	ld a,0ffh		;67be
	ld (0f110h),a		;67c0
	ld hl,092b7h		;67c3
	ld de,092b8h		;67c6
	ld (hl),03ch		;67c9
	ld bc,0000fh		;67cb
	ldir		;67ce
	ld hl,092b1h		;67d0
	ld de,092b2h		;67d3
	ld (hl),000h		;67d6
	ld bc,00005h		;67d8
	ldir		;67db
	call L_6534		;67dd
	call L_749E		;67e0
	call L_684A		;67e3
	call L_74BF		;67e6
	xor a			;67e9
	ld (0f110h),a		;67ea
	ld a,0ffh		;67ed
	ld (092c7h),a		;67ef
	ret			;67f2
L_67F3:
	ld a,(0f282h)		;67f3
	inc a			;67f6
	jr z,L_67FE		;67f7
	ld hl,06ca6h		;67f9
	jr L_680D		;67fc
L_67FE:
	push bc			;67fe
	call L_6D2F		;67ff
	pop bc			;6802
	ret			;6803
L_6804:
	ld a,(0f282h)		;6804
	inc a			;6807
	jr z,L_6813		;6808
	ld hl,06cd7h		;680a
L_680D:
	push bc			;680d
	call L_6827		;680e
	pop bc			;6811
	ret			;6812
L_6813:
	push bc			;6813
	call L_6D41		;6814
	pop bc			;6817
	ret			;6818
L_6819:
	push bc			;6819
	ld ix,(0f294h)		;681a
	ld iy,(0f103h)		;681e
	call 0001ch		;6822   ; BIOS CALSLT - Executes inter-slot call
	pop bc			;6825
	ret			;6826
L_6827:
	ld a,(hl)			;6827
	inc a			;6828
	ret z			;6829
	ld a,(0f281h)		;682a
	cp (hl)			;682d
	inc hl			;682e
	jr z,L_6835		;682f
	inc hl			;6831
	inc hl			;6832
	jr L_6827		;6833
L_6835:
	ld e,(hl)			;6835
	inc hl			;6836
	ld d,(hl)			;6837
	ex de,hl			;6838
	jp (hl)			;6839
L_683A:
	ld a,(hl)			;683a
	inc a			;683b
	jr z,L_6848		;683c
	ld a,(0f281h)		;683e
	cp (hl)			;6841
	ret z			;6842
	inc hl			;6843
	inc hl			;6844
	inc hl			;6845
	jr L_683A		;6846
L_6848:
	inc a			;6848
	ret			;6849
L_684A:
	ld hl,03a8ch		;684a
	ld bc,00312h		;684d
	xor a			;6850
	call L_73E1		;6851
	ld hl,06958h		;6854
	call L_738F		;6857
	call L_6926		;685a
	ld hl,03acch		;685d
	call L_68D3		;6860
	jr z,L_687E		;6863
	ld hl,0920bh		;6865
	ld de,092b7h		;6868
	ld bc,00008h		;686b
	ldir		;686e
	ld hl,092b1h		;6870
	call L_68DA		;6873
	ld a,031h		;6876
	call L_6912		;6878
	call L_6926		;687b
L_687E:
	call L_68E1		;687e
	jr z,L_68B3		;6881
	ld hl,06972h		;6883
	call L_738F		;6886
	ld hl,03acch		;6889
	push hl			;688c
	ld bc,0000ah		;688d
	xor a			;6890
	call L_6B32		;6891
	pop hl			;6894
	call L_68D3		;6895
	jr z,L_68B3		;6898
	ld hl,0920bh		;689a
	ld de,092bfh		;689d
	ld bc,00008h		;68a0
	ldir		;68a3
	ld hl,092b4h		;68a5
	call L_68DA		;68a8
	ld a,032h		;68ab
	call L_6912		;68ad
	call L_6926		;68b0
L_68B3:
	ld hl,03a8ch		;68b3
	ld bc,00312h		;68b6
	xor a			;68b9
	call L_73E1		;68ba
	ld hl,0699ch		;68bd
	call L_738F		;68c0
	ld hl,069a9h		;68c3
	ld b,002h		;68c6
	call L_7690		;68c8
	call L_737B		;68cb

; ----------------------------------------------------------------------
; DATOS saltos_68CE: tabla de 2 palabras del despachador (call 0x408D en
;   0x68CB); lo leen el despachador (4 bytes)
;   0x68ce..0x68d2  (4 bytes)
DATA_saltos_68CE:
	defb 0d2h,068h	; 68ce
	defb 04ah,068h	; 68d0

; ======================================================================
; CODIGO 0x68d2..0x6958  (134 bytes)
; ======================================================================


L_68D2:
	ret			;68d2
L_68D3:
	ld a,0feh		;68d3
	ld b,008h		;68d5
	jp L_750E		;68d7
L_68DA:
	xor a			;68da
	ld (hl),a			;68db
	inc hl			;68dc
	ld (hl),a			;68dd
	inc hl			;68de
	ld (hl),a			;68df
	ret			;68e0
L_68E1:
	ld hl,(0f290h)		;68e1
	ld a,h			;68e4
	or l			;68e5
	ret z			;68e6
	ld hl,(0f286h)		;68e7
	ld a,h			;68ea
	or l			;68eb
	ret z			;68ec
	ld a,(0f281h)		;68ed
	ld c,a			;68f0
	sub 003h		;68f1
	cp 002h		;68f3
	jr c,L_6907		;68f5
	ld a,c			;68f7
	sub 010h		;68f8
	cp 002h		;68fa
	jr nc,L_6903		;68fc
	ld a,(hl)			;68fe
	cpl			;68ff
	and 001h		;6900
	ret			;6902
L_6903:
	ld a,(hl)			;6903
	bit 5,a		;6904
	ret			;6906
L_6907:
	ld a,(hl)			;6907
	and 001h		;6908
	ret			;690a
L_690B:
	ld a,031h		;690b
	call L_6912		;690d
	ld a,032h		;6910
L_6912:
	ld hl,09257h		;6912
	ld b,00ah		;6915
	ld c,a			;6917
L_6918:
	ld a,c			;6918
	cp (hl)			;6919
	jr nz,L_691E		;691a
	ld (hl),000h		;691c
L_691E:
	ld a,009h		;691e
	call L_7251		;6920
	djnz L_6918		;6923
	ret			;6925
L_6926:
	ld hl,03a2ch		;6926
	ld bc,00212h		;6929
	xor a			;692c
	call L_73E1		;692d
	ld hl,06982h		;6930
	call L_738F		;6933
	ld hl,092b7h		;6936
	ld de,03a36h		;6939
	ld bc,00008h		;693c
	call L_6B48		;693f
	call L_68E1		;6942
	ret z			;6945
	ld hl,0698fh		;6946
	call L_738F		;6949
	ld hl,092bfh		;694c
	ld de,03a56h		;694f
	ld bc,00008h		;6952
	jp L_6B48		;6955

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6958..0x69ad  (85 bytes)
DATA_6958:
	defb 021h,03ah,052h,041h,04eh,04bh,049h,04eh,047h,0feh,08ch,03ah,049h,04eh,050h,055h	; 6958  !:RANKING..:INPU
	defb 054h,000h,031h,050h,000h,04eh,041h,04dh,045h,0ffh,08ch,03ah,049h,04eh,050h,055h	; 6968  T.1P.NAME..:INPU
	defb 054h,000h,032h,050h,000h,04eh,041h,04dh,045h,0ffh,02ch,03ah,031h,050h,000h,04eh	; 6978  T.2P.NAME.,:1P.N
	defb 041h,04dh,045h,000h,03eh,000h,0ffh,04ch,03ah,032h,050h,000h,04eh,041h,04dh,045h	; 6988  AME.>..L:2P.NAME
	defb 000h,03eh,000h,0ffh,08ch,03ah,04fh,04bh,0feh,0cch,03ah,052h,045h,054h,052h,059h	; 6998  .>...:OK..:RETRY
	defb 0ffh,08bh,03ah,0cbh,03ah	; 69a8

; ======================================================================
; CODIGO 0x69ad..0x6c35  (648 bytes)
; ======================================================================


L_69AD:
	ld hl,092b3h		;69ad
	ld a,031h		;69b0
	call L_69BE		;69b2
	call L_68E1		;69b5
	ret z			;69b8
	ld hl,092b6h		;69b9
	ld a,032h		;69bc
L_69BE:
	ld de,09257h		;69be
	ex de,hl			;69c1
	ld c,a			;69c2
	ld b,00ah		;69c3
L_69C5:
	ld a,c			;69c5
	cp (hl)			;69c6
	jr z,L_69D4		;69c7
	ld a,009h		;69c9
	call L_7251		;69cb
	djnz L_69C5		;69ce
	ld b,009h		;69d0
	jr L_69DB		;69d2
L_69D4:
	ld a,00ah		;69d4
	sub b			;69d6
	ld b,a			;69d7
	jp z,L_6A0F		;69d8
L_69DB:
	ld a,c			;69db
	ld c,000h		;69dc
	ld hl,0923bh		;69de
L_69E1:
	push af			;69e1
	push bc			;69e2
	push hl			;69e3
	push de			;69e4
	ld b,003h		;69e5
	ex de,hl			;69e7
L_69E8:
	ld a,(de)			;69e8
	cp (hl)			;69e9
	jr c,L_69F2		;69ea
	jr nz,L_69FF		;69ec
	dec de			;69ee
	dec hl			;69ef
	djnz L_69E8		;69f0
L_69F2:
	pop de			;69f2
	pop hl			;69f3
	pop bc			;69f4
	pop af			;69f5
	call L_6A14		;69f6
	call L_6A59		;69f9
	jp L_6A7A		;69fc
L_69FF:
	pop de			;69ff
	pop hl			;6a00
	pop bc			;6a01
	pop af			;6a02
	inc hl			;6a03
	inc hl			;6a04
	inc hl			;6a05
	inc c			;6a06
	djnz L_69E1		;6a07
	call L_6A59		;6a09
	jp L_6A7A		;6a0c
L_6A0F:
	ld a,c			;6a0f
	ld c,b			;6a10
	jp L_6A59		;6a11
L_6A14:
	ld ix,09238h		;6a14
	ld iy,0923bh		;6a18
	ld d,000h		;6a1c
	call L_6A2B		;6a1e
	ld ix,09256h		;6a21
	ld iy,0925fh		;6a25
	ld d,001h		;6a29
L_6A2B:
	push af			;6a2b
	push bc			;6a2c
	ld e,b			;6a2d
	ld a,c			;6a2e
	add a,b			;6a2f
	ld b,a			;6a30
	add a,a			;6a31
	add a,b			;6a32
	bit 0,d		;6a33
	jr z,L_6A3A		;6a35
	ld b,a			;6a37
	add a,a			;6a38
	add a,b			;6a39
L_6A3A:
	ld c,a			;6a3a
	ld b,000h		;6a3b
	add ix,bc		;6a3d
	add iy,bc		;6a3f
	ld a,e			;6a41
	add a,a			;6a42
	add a,e			;6a43
	bit 0,d		;6a44
	jr z,L_6A4B		;6a46
	ld b,a			;6a48
	add a,a			;6a49
	add a,b			;6a4a
L_6A4B:
	ld c,a			;6a4b
	ld b,000h		;6a4c
	push ix		;6a4e
	pop hl			;6a50
	push iy		;6a51
	pop de			;6a53
	lddr		;6a54
	pop bc			;6a56
	pop af			;6a57
	ret			;6a58
L_6A59:
	push af			;6a59
	push bc			;6a5a
	push af			;6a5b
	ld a,c			;6a5c
	ld b,a			;6a5d
	add a,a			;6a5e
	add a,b			;6a5f
	ld hl,09239h		;6a60
	call L_7251		;6a63
	pop af			;6a66
	ld de,092b1h		;6a67
	cp 032h		;6a6a
	jr nz,L_6A71		;6a6c
	ld de,092b4h		;6a6e
L_6A71:
	ex de,hl			;6a71
	ld bc,00003h		;6a72
	ldir		;6a75
	pop bc			;6a77
	pop af			;6a78
	ret			;6a79
L_6A7A:
	push af			;6a7a
	push bc			;6a7b
	push af			;6a7c
	ld a,c			;6a7d
	ld b,a			;6a7e
	add a,a			;6a7f
	add a,b			;6a80
	ld b,a			;6a81
	add a,a			;6a82
	add a,b			;6a83
	ld hl,09257h		;6a84
	call L_7251		;6a87
	pop af			;6a8a
	ld de,092b7h		;6a8b
	cp 032h		;6a8e
	jr nz,L_6A95		;6a90
	ld de,092bfh		;6a92
L_6A95:
	ex de,hl			;6a95
	ld (de),a			;6a96
	inc de			;6a97
	ld bc,00008h		;6a98
	ldir		;6a9b
	pop bc			;6a9d
	pop af			;6a9e
	ret			;6a9f
L_6AA0:
	ld hl,03a29h		;6aa0
	ld bc,00616h		;6aa3
	xor a			;6aa6
	call L_73E1		;6aa7
	call L_7600		;6aaa
	xor a			;6aad
	ld (0922ch),a		;6aae
	ld (0922eh),a		;6ab1
	ld hl,03a29h		;6ab4
	ld (09233h),hl		;6ab7
	inc hl			;6aba
	ld (09231h),hl		;6abb
	ld a,0c0h		;6abe
	ld (0922dh),a		;6ac0
	call L_7633		;6ac3
L_6AC6:
	call L_6B62		;6ac6
	call 00156h		;6ac9   ; BIOS KILBUF - Clears keyboard buffer
L_6ACC:
	ld hl,0922ch		;6acc
	ld de,0922eh		;6acf
	call 0009fh		;6ad2   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;6ad5
	jr z,L_6B1C		;6ad7
	cp 01fh		;6ad9
	jr z,L_6AE2		;6adb
	cp 020h		;6add
	jr nz,L_6ACC		;6adf
	ret			;6ae1
L_6AE2:
	ld a,009h		;6ae2
	cp (hl)			;6ae4
	jr z,L_6ACC		;6ae5
	inc (hl)			;6ae7
	ld a,(de)			;6ae8
	ld b,a			;6ae9
	ld a,(hl)			;6aea
	sub b			;6aeb
	cp 005h		;6aec
	jr c,L_6AF8		;6aee
	inc b			;6af0
	ld a,b			;6af1
	ld (de),a			;6af2
	ld bc,00000h		;6af3
	jr L_6AFB		;6af6
L_6AF8:
	ld bc,00020h		;6af8
L_6AFB:
	ld a,(hl)			;6afb
	cp 009h		;6afc
	jr nz,L_6B01		;6afe
	dec bc			;6b00
L_6B01:
	call L_7642		;6b01
	add hl,bc			;6b04
	push hl			;6b05
	ld de,(09233h)		;6b06
	and a			;6b0a
	sbc hl,de		;6b0b
	ld a,(0922dh)		;6b0d
	ld d,000h		;6b10
	ld e,a			;6b12
	rst 20h			;6b13
	pop hl			;6b14
	jr nc,L_6B1A		;6b15
	ld (09231h),hl		;6b17
L_6B1A:
	jr L_6AC6		;6b1a
L_6B1C:
	ld a,(hl)			;6b1c
	or a			;6b1d
	jr z,L_6ACC		;6b1e
	dec (hl)			;6b20
	ex de,hl			;6b21
	ld a,(de)			;6b22
	cp (hl)			;6b23
	jr nc,L_6B27		;6b24
	dec (hl)			;6b26
L_6B27:
	ld bc,0ffe0h		;6b27
	ld a,(de)			;6b2a
	cp 008h		;6b2b
	jr nz,L_6B30		;6b2d
	inc bc			;6b2f
L_6B30:
	jr L_6B01		;6b30
L_6B32:
	call L_73B5		;6b32
	ld a,000h		;6b35
	jp nz,00056h		;6b37   ; BIOS FILVRM - Fills VRAM with value
L_6B3A:
	call L_7646		;6b3a
	inc hl			;6b3d
	dec c			;6b3e
	jr nz,L_6B3A		;6b3f
	ld a,(0f122h)		;6b41
	ld (0faf6h),a		;6b44
	ret			;6b47
L_6B48:
	call L_73B5		;6b48
	jp nz,0005ch		;6b4b   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_6B4E:
	ld a,(hl)			;6b4e
	ex de,hl			;6b4f
	call L_7646		;6b50
	ex de,hl			;6b53
	inc hl			;6b54
	inc de			;6b55
	dec bc			;6b56
	ld a,b			;6b57
	or c			;6b58
	jr nz,L_6B4E		;6b59
	ld a,(0f122h)		;6b5b
	ld (0faf6h),a		;6b5e
	ret			;6b61
L_6B62:
	ld a,(0922eh)		;6b62
	call L_6C38		;6b65
	push hl			;6b68
	pop ix		;6b69
	ld a,(0922eh)		;6b6b
	call L_6C46		;6b6e
	push hl			;6b71
	pop iy		;6b72
	ld hl,(09233h)		;6b74
	inc hl			;6b77
	ld a,(0922eh)		;6b78
	add a,031h		;6b7b
	ld c,a			;6b7d
	ld b,005h		;6b7e
L_6B80:
	push bc			;6b80
	push hl			;6b81
	push hl			;6b82
	push bc			;6b83
	xor a			;6b84
	ld bc,00015h		;6b85
	call L_6B32		;6b88
	call L_7633		;6b8b
	pop bc			;6b8e
	pop hl			;6b8f
	ld a,c			;6b90
	cp 03ah		;6b91
	jr z,L_6B9B		;6b93
	inc hl			;6b95
	call L_7646		;6b96
	jr L_6BA6		;6b99
L_6B9B:
	ld a,031h		;6b9b
	call L_7646		;6b9d
	inc hl			;6ba0
	ld a,030h		;6ba1
	call L_7646		;6ba3
L_6BA6:
	inc hl			;6ba6
	ld a,03bh		;6ba7
	call L_7646		;6ba9
	inc hl			;6bac
	push ix		;6bad
	pop de			;6baf
	ex de,hl			;6bb0
	ld bc,00008h		;6bb1
	push de			;6bb4
	push bc			;6bb5
	call L_6B48		;6bb6
	ld hl,0e000h		;6bb9
	ld a,(iy+002h)		;6bbc
	call 05099h		;6bbf
	inc hl			;6bc2
	ld a,(iy+001h)		;6bc3
	call 05099h		;6bc6
	inc hl			;6bc9
	ld a,(iy+000h)		;6bca
	call 05099h		;6bcd
	pop bc			;6bd0
	pop hl			;6bd1
	add hl,bc			;6bd2
	ld a,03eh		;6bd3
	call L_7646		;6bd5
	inc hl			;6bd8
	ld de,0e000h		;6bd9
	ld bc,00600h		;6bdc
	ld a,(0f281h)		;6bdf
	cp 029h		;6be2
	jr nz,L_6BE9		;6be4
	inc de			;6be6
	dec b			;6be7
	inc c			;6be8
L_6BE9:
	ld a,(de)			;6be9
	cp 030h		;6bea
	jr nz,L_6BFD		;6bec
	inc hl			;6bee
	inc de			;6bef
	djnz L_6BE9		;6bf0
	bit 0,c		;6bf2
	jr nz,L_6BF7		;6bf4
	dec hl			;6bf6
L_6BF7:
	call L_7646		;6bf7
	inc hl			;6bfa
	jr L_6C15		;6bfb
L_6BFD:
	push bc			;6bfd
	ld c,b			;6bfe
	ld b,000h		;6bff
	ex de,hl			;6c01
	push bc			;6c02
	push de			;6c03
	call L_6B48		;6c04
	pop hl			;6c07
	pop bc			;6c08
	add hl,bc			;6c09
	pop bc			;6c0a
	bit 0,c		;6c0b
	jr z,L_6C15		;6c0d
	ld a,030h		;6c0f
	call L_7646		;6c11
	inc hl			;6c14
L_6C15:
	ld de,06c35h		;6c15
	ex de,hl			;6c18
	ld bc,00003h		;6c19
	call L_6B48		;6c1c
	ld bc,00009h		;6c1f
	add ix,bc		;6c22
	ld bc,00003h		;6c24
	add iy,bc		;6c27
	pop hl			;6c29
	ld bc,00020h		;6c2a
	add hl,bc			;6c2d
	pop bc			;6c2e
	inc c			;6c2f
	dec b			;6c30
	jp nz,L_6B80		;6c31
	ret			;6c34

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6c35..0x6c38  (3 bytes)
DATA_6C35:
	defb 050h,054h,053h	; 6c35

; ======================================================================
; CODIGO 0x6c38..0x6c50  (24 bytes)
; ======================================================================


L_6C38:
	ld b,a			;6c38
	add a,a			;6c39
	add a,b			;6c3a
	ld b,a			;6c3b
	add a,a			;6c3c
	add a,b			;6c3d
	ld hl,09257h		;6c3e
	call L_7251		;6c41
	inc hl			;6c44
	ret			;6c45
L_6C46:
	ld b,a			;6c46
	add a,a			;6c47
	add a,b			;6c48
	ld hl,09239h		;6c49
	call L_7251		;6c4c
	ret			;6c4f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6c50..0x6d17  (199 bytes)
DATA_6C50:
	defb 000h,080h,02ah,02ah,02ah,020h,052h,043h,02dh,037h,020h,020h,020h,053h,043h,04fh	; 6c50  ..*** RC-7   SCO
	defb 052h,045h,020h,052h,041h,04eh,04bh,049h,04eh,047h,020h,02ah,02ah,02ah,0feh,03ah	; 6c60  RE RANKING ***.:
	defb 080h,052h,061h,06eh,06bh,02eh,020h,020h,04eh,061h,06dh,065h,02eh,020h,020h,020h	; 6c70  .Rank.  Name.
	defb 053h,063h,06fh,072h,065h,02eh,0feh,054h,080h,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 6c80  Score..T.-------
	defb 02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 6c90  ----------------
	defb 02dh,02dh,02dh,02dh,02dh,0ffh,000h,027h,06dh,002h,027h,06dh,003h,027h,06dh,004h	; 6ca0  -----..'m.'m.'m.
	defb 027h,06dh,005h,027h,06dh,006h,027h,06dh,012h,027h,06dh,013h,027h,06dh,014h,027h	; 6cb0  'm.'m.'m.'m.'m.'
	defb 06dh,016h,027h,06dh,025h,017h,06dh,021h,027h,06dh,027h,027h,06dh,028h,034h,06dh	; 6cc0  m.'m%.m!'m''m(4m
	defb 029h,02fh,06dh,037h,02fh,06dh,0ffh,000h,0d8h,06dh,001h,0fdh,06dh,010h,038h,06eh	; 6cd0  )/m7/m...m..m.8n
	defb 011h,038h,06eh,012h,081h,06eh,013h,097h,06eh,014h,0e9h,06eh,015h,0ech,06eh,016h	; 6ce0  .8n..n..n..n..n.
	defb 0d8h,06dh,017h,0f3h,06eh,018h,0ffh,06eh,021h,037h,06fh,025h,048h,06fh,027h,078h	; 6cf0  .m..n..n!7o%Ho'x
	defb 06fh,028h,0c9h,06fh,029h,0e4h,06fh,030h,0f7h,06fh,032h,016h,070h,033h,01fh,070h	; 6d00  o(.o).o0.o2.p3.p
	defb 036h,028h,070h,037h,04eh,070h,0ffh	; 6d10

; ======================================================================
; CODIGO 0x6d17..0x6d87  (112 bytes)
; ======================================================================


L_6D17:
	ld a,0ffh		;6d17
	ld (0e052h),a		;6d19
	ld a,(0f299h)		;6d1c
	cp 00bh		;6d1f
	jr c,L_6D25		;6d21
	ld a,00ah		;6d23
L_6D25:
	jr L_6D2A		;6d25
L_6D27:
	ld a,(0f299h)		;6d27
L_6D2A:
	ld hl,(0f288h)		;6d2a
	ld (hl),a			;6d2d
	ret			;6d2e
L_6D2F:
	ld a,(0f29ah)		;6d2f
	jr L_6D2A		;6d32
L_6D34:
	ld a,(0f299h)		;6d34
	ld (0e050h),a		;6d37
	ld a,(0f29ah)		;6d3a
	ld (0e051h),a		;6d3d
	ret			;6d40
L_6D41:
	ld a,(0f293h)		;6d41
	ld c,a			;6d44
	ld a,(0f29bh)		;6d45
	call L_706C		;6d48
	ld a,l			;6d4b
	inc a			;6d4c
	ld hl,(0f28ah)		;6d4d
	ld (hl),a			;6d50
	push hl			;6d51
	push af			;6d52
	call L_6DB1		;6d53
	pop af			;6d56
	pop hl			;6d57
	dec c			;6d58
	ret m			;6d59
	jr z,$+67		;6d5a
	dec c			;6d5c
	jr z,$+61		;6d5d
	dec c			;6d5f
	jr z,$+58		;6d60
	ld c,a			;6d62
	ld l,a			;6d63
	xor a			;6d64
	ld b,008h		;6d65
L_6D67:
	rl l		;6d67
	adc a,a			;6d69
	daa			;6d6a
	djnz L_6D67		;6d6b
	ld (0c411h),a		;6d6d
	ld a,c			;6d70
	ld (0d000h),a		;6d71
	ld hl,06d87h		;6d74
	call L_7251		;6d77
	ld a,(hl)			;6d7a
	ld (0d002h),a		;6d7b
	xor a			;6d7e
	ld (0d001h),a		;6d7f
	inc a			;6d82
	ld (0c40dh),a		;6d83
	ret			;6d86

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6d87..0x6d9a  (19 bytes)
DATA_6D87:
	defb 000h,000h,000h,000h,001h,001h,001h,002h,002h,002h,003h,003h,003h,004h,004h,004h	; 6d87  ................
	defb 005h,005h,005h	; 6d97

; ======================================================================
; CODIGO 0x6d9a..0x6dc9  (47 bytes)
; ======================================================================


L_6D9A:
	dec a			;6d9a
	ld (hl),a			;6d9b
	ret			;6d9c
L_6D9D:
	ld (0c481h),a		;6d9d
	dec a			;6da0
	ld (0c482h),a		;6da1
	ld l,a			;6da4
	add a,a			;6da5
	add a,l			;6da6
	inc a			;6da7
	ld (0c480h),a		;6da8
	ld a,001h		;6dab
	ld (0c483h),a		;6dad
	ret			;6db0
L_6DB1:
	ld hl,06dc9h		;6db1
	ld de,(0f280h)		;6db4
L_6DB8:
	ld b,(hl)			;6db8
	inc hl			;6db9
	ld a,(hl)			;6dba
	or b			;6dbb
	ld a,(hl)			;6dbc
	inc hl			;6dbd
	ld c,(hl)			;6dbe
	ret z			;6dbf
	inc hl			;6dc0
	cp e			;6dc1
	jr nz,L_6DB8		;6dc2
	ld a,b			;6dc4
	cp d			;6dc5
	ret z			;6dc6
	jr L_6DB8		;6dc7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6dc9..0x6dd8  (15 bytes)
DATA_6DC9:
	defb 047h,007h,001h,048h,007h,002h,053h,007h,003h,044h,007h,004h,000h,000h,000h	; 6dc9  G..H..S..D.....

; ======================================================================
; CODIGO 0x6dd8..0x6e24  (76 bytes)
; ======================================================================


L_6DD8:
	ld a,(0f29bh)		;6dd8
	dec a			;6ddb
	ld l,a			;6ddc
	ld h,000h		;6ddd
	add hl,hl			;6ddf
	ld b,h			;6de0
	ld c,l			;6de1
	add hl,hl			;6de2
	add hl,hl			;6de3
	add hl,bc			;6de4
	call L_746C		;6de5
	ld a,e			;6de8
	ld (0e059h),a		;6de9
	push af			;6dec
	add a,010h		;6ded
	daa			;6def
	ld (0e05ah),a		;6df0
	pop af			;6df3
	call L_747D		;6df4
	ld (0e054h),a		;6df7
	jp L_6F70		;6dfa
L_6DFD:
	ld a,(0f29bh)		;6dfd
	ld c,00ah		;6e00
	call L_706C		;6e02
	ld a,l			;6e05
	ld (0e0e1h),a		;6e06
	ld (0e0e8h),a		;6e09
	ld b,a			;6e0c
	ld a,(0f283h)		;6e0d
	or a			;6e10
	ld hl,06e24h		;6e11
	jr z,L_6E19		;6e14
	ld hl,06e2eh		;6e16
L_6E19:
	ld a,b			;6e19
	call L_7251		;6e1a
	ld a,(hl)			;6e1d
	ld (0e0e2h),a		;6e1e
	jp L_6F70		;6e21

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6e24..0x6e38  (20 bytes)
DATA_6E24:
	defb 000h,006h,00dh,013h,01ah,022h,027h,02dh,033h,035h,000h,007h,00fh,014h,01ah,020h	; 6e24  ....."'-35.....
	defb 022h,02fh,035h,03ch	; 6e34

; ======================================================================
; CODIGO 0x6e38..0x6e71  (57 bytes)
; ======================================================================


L_6E38:
	ld a,(0f29bh)		;6e38
	ld c,004h		;6e3b
	call L_706C		;6e3d
	ld a,l			;6e40
	inc a			;6e41
	ld hl,(0f28ah)		;6e42
	ld (hl),a			;6e45
	ld (0e015h),a		;6e46
	dec a			;6e49
	push af			;6e4a
	add a,a			;6e4b
	ld b,a			;6e4c
	ld hl,06e71h		;6e4d
	ld a,(0f281h)		;6e50
	cp 010h		;6e53
	jr z,L_6E5A		;6e55
	ld hl,06e79h		;6e57
L_6E5A:
	ld a,b			;6e5a
	call L_7251		;6e5b
	ex de,hl			;6e5e
	pop af			;6e5f
	ld b,a			;6e60
	add a,a			;6e61
	add a,b			;6e62
	ld hl,0e050h		;6e63
	call L_7251		;6e66
	ex de,hl			;6e69
	inc de			;6e6a
	ld bc,00002h		;6e6b
	ldir		;6e6e
	ret			;6e70

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6e71..0x6e81  (16 bytes)
DATA_6E71:
	defb 014h,000h,006h,000h,080h,000h,055h,000h,015h,000h,075h,000h,002h,030h,004h,030h	; 6e71  ......U...u..0.0

; ======================================================================
; CODIGO 0x6e81..0x6ece  (77 bytes)
; ======================================================================


L_6E81:
	call L_6F70		;6e81
	ld a,(0f29bh)		;6e84
	ld l,a			;6e87
	sub 005h		;6e88
	jr c,L_6E92		;6e8a
	inc a			;6e8c
	ld c,005h		;6e8d
	call L_706C		;6e8f
L_6E92:
	ld a,l			;6e92
	ld (0e052h),a		;6e93
	ret			;6e96
L_6E97:
	call L_6F70		;6e97
	ld a,(0f29bh)		;6e9a
	ld b,a			;6e9d
	dec a			;6e9e
	ld (0e05ch),a		;6e9f
	cp 008h		;6ea2
	jr c,L_6EA8		;6ea4
	ld a,008h		;6ea6
L_6EA8:
	ld hl,06eceh		;6ea8
	call L_7251		;6eab
	ld a,(hl)			;6eae
	ld (0e05dh),a		;6eaf
	ld a,08ah		;6eb2
	ld (0e056h),a		;6eb4
	ld a,b			;6eb7
	ld c,009h		;6eb8
	call L_706C		;6eba
	ld a,l			;6ebd
	add a,a			;6ebe
	ld hl,06ed7h		;6ebf
	call L_7251		;6ec2
	ld de,0e054h		;6ec5
	ld bc,00002h		;6ec8
	ldir		;6ecb
	ret			;6ecd

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6ece..0x6ee9  (27 bytes)
DATA_6ECE:
	defb 077h,033h,0bbh,0eeh,011h,0bbh,0eeh,011h,011h,000h,000h,070h,00ch,020h,01ah,050h	; 6ece  w3.........p. .P
	defb 028h,030h,036h,0e0h,043h,040h,052h,0c0h,061h,0d0h,06eh	; 6ede  (06.C@R.a.n

; ======================================================================
; CODIGO 0x6ee9..0x6f1d  (52 bytes)
; ======================================================================


L_6EE9:
	jp L_6F70		;6ee9
L_6EEC:
	ld a,(0f29bh)		;6eec
	dec a			;6eef
	jp L_6F73		;6ef0
L_6EF3:
	ld a,(0f29bh)		;6ef3
	ld c,003h		;6ef6
	call L_706C		;6ef8
	ld a,l			;6efb
	jp L_6F73		;6efc
L_6EFF:
	ld a,(0f29bh)		;6eff
	ld c,00dh		;6f02
	call L_706C		;6f04
	ld a,l			;6f07
	inc a			;6f08
	ld (0e060h),a		;6f09
	dec a			;6f0c
	add a,a			;6f0d
	ld hl,06f1dh		;6f0e
	call L_7251		;6f11
	ld de,0e05bh		;6f14
	ld bc,00002h		;6f17
	ldir		;6f1a
	ret			;6f1c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6f1d..0x6f37  (26 bytes)
DATA_6F1D:
	defb 006h,080h,006h,070h,006h,070h,006h,070h,006h,060h,006h,050h,006h,050h,006h,050h	; 6f1d  ...p.p.p.`.P.P.P
	defb 006h,060h,006h,060h,006h,050h,006h,050h,000h,080h	; 6f2d  .`.`.P.P..

; ======================================================================
; CODIGO 0x6f37..0x6fa9  (114 bytes)
; ======================================================================


L_6F37:
	ld a,(0f29bh)		;6f37
	ld c,008h		;6f3a
	call L_706C		;6f3c
	ld h,l			;6f3f
	ld l,000h		;6f40
	ld (0e1b8h),hl		;6f42
	jp L_6F70		;6f45
L_6F48:
	call L_6F70		;6f48
	ld a,(0f29bh)		;6f4b
	push af			;6f4e
	ld c,005h		;6f4f
	call L_706C		;6f51
	ld a,l			;6f54
	ld (0e054h),a		;6f55
	pop af			;6f58
	cp 006h		;6f59
	ret c			;6f5b
	ld b,a			;6f5c
	sub 005h		;6f5d
	cp 004h		;6f5f
	jr c,L_6F65		;6f61
	ld a,003h		;6f63
L_6F65:
	ld (0e056h),a		;6f65
	ld a,b			;6f68
	dec a			;6f69
	and 003h		;6f6a
	ld (0e059h),a		;6f6c
	ret			;6f6f
L_6F70:
	ld a,(0f29ch)		;6f70
L_6F73:
	ld hl,(0f28ah)		;6f73
	ld (hl),a			;6f76
	ret			;6f77
L_6F78:
	ld a,(0f29bh)		;6f78
	ld c,00fh		;6f7b
	call L_706C		;6f7d
	ld a,e			;6f80
	ld (0e058h),a		;6f81
	ld a,l			;6f84
	inc a			;6f85
	ld (0e055h),a		;6f86
	dec a			;6f89
	ld (0e054h),a		;6f8a
	ld hl,06fa9h		;6f8d
	add a,a			;6f90
	call L_7251		;6f91
	ld a,(hl)			;6f94
	ld (0e056h),a		;6f95
	inc hl			;6f98
	ld a,(hl)			;6f99
	ld (0e057h),a		;6f9a
	ld a,(0e055h)		;6f9d
	cp 001h		;6fa0
	jr z,L_6FA5		;6fa2
	xor a			;6fa4
L_6FA5:
	ld (0e051h),a		;6fa5
	ret			;6fa8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6fa9..0x6fc9  (32 bytes)
DATA_6FA9:
	defb 008h,000h,004h,008h,004h,008h,001h,008h,008h,004h,008h,004h,004h,004h,004h,008h	; 6fa9  ................
	defb 001h,008h,008h,004h,008h,004h,004h,004h,004h,008h,004h,008h,001h,002h,008h,004h	; 6fb9  ................

; ======================================================================
; CODIGO 0x6fc9..0x70f8  (303 bytes)
; ======================================================================


L_6FC9:
	ld a,(0f29bh)		;6fc9
	cp 033h		;6fcc
	jr c,L_6FD2		;6fce
	sub 032h		;6fd0
L_6FD2:
	dec a			;6fd2
	ld (0e053h),a		;6fd3
	ld a,(0f29ch)		;6fd6
	cp 051h		;6fd9
	jr c,L_6FE0		;6fdb
	sub 050h		;6fdd
	daa			;6fdf
L_6FE0:
	ld (0e052h),a		;6fe0
	ret			;6fe3
L_6FE4:
	ld a,(0f29bh)		;6fe4
	ld c,008h		;6fe7
	call L_706C		;6fe9
	ld a,l			;6fec
	ld (0e103h),a		;6fed
	ld hl,000c0h		;6ff0
	ld (0e1b8h),hl		;6ff3
	ret			;6ff6
L_6FF7:
	ld a,(0f29bh)		;6ff7
	ld c,006h		;6ffa
	call L_706C		;6ffc
	ld a,e			;6fff
	ld (0e042h),a		;7000
	ld a,l			;7003
	ld hl,(0f28ah)		;7004
	ld (hl),a			;7007
	call L_708B		;7008
	ld a,004h		;700b
	ld (0e001h),a		;700d
	ld a,008h		;7010
	ld (0e000h),a		;7012
	ret			;7015
L_7016:
	call L_708B		;7016
	ld hl,(0f284h)		;7019
	ld (hl),007h		;701c
	ret			;701e
L_701F:
	ld a,(0f29bh)		;701f
	dec a			;7022
	ld hl,(0f28ah)		;7023
	ld (hl),a			;7026
	ret			;7027
L_7028:
	ld a,(0f29bh)		;7028
	dec a			;702b
	ld (0e206h),a		;702c
	call L_6F70		;702f
	ld a,(0f29bh)		;7032
	ld c,003h		;7035
	call L_706C		;7037
	ld a,e			;703a
	and 00fh		;703b
	rrca			;703d
	rrca			;703e
	rrca			;703f
	rrca			;7040
	add a,l			;7041
	ld (0e207h),a		;7042
	ld a,009h		;7045
	ld hl,(0f284h)		;7047
	ld (hl),a			;704a
	jp L_708B		;704b
L_704E:
	ld a,(0f29bh)		;704e
	ld c,008h		;7051
	call L_706C		;7053
	ld a,l			;7056
	ld hl,(0f28ah)		;7057
	ld (hl),a			;705a
	ld a,e			;705b
	cp 002h		;705c
	jr c,L_7062		;705e
	ld a,002h		;7060
L_7062:
	ld (0e06ah),a		;7062
	ld a,(0f29ch)		;7065
	ld (0e053h),a		;7068
	ret			;706b
L_706C:
	dec a			;706c
	ld e,a			;706d
	ld d,000h		;706e
	ld b,d			;7070
	ld hl,00000h		;7071
	exx			;7074
	ld b,010h		;7075
L_7077:
	exx			;7077
	sla e		;7078
	rl d		;707a
	adc hl,hl		;707c
	sbc hl,bc		;707e
	jr c,L_7085		;7080
	inc e			;7082
	jr L_7086		;7083
L_7085:
	add hl,bc			;7085
L_7086:
	exx			;7086
	djnz L_7077		;7087
	exx			;7089
	ret			;708a
L_708B:
	ld hl,03800h		;708b
	xor a			;708e
	ld bc,00300h		;708f
	call 00056h		;7092   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;7095
	ld a,0d0h		;7098
	jp 0004dh		;709a   ; BIOS WRTVRM - Writes data in VRAM
L_709D:
	call L_7112		;709d
	call L_70AA		;70a0
	ld hl,(0f120h)		;70a3
	ld (0f118h),hl		;70a6
	ret			;70a9
L_70AA:
	ld hl,(0f280h)		;70aa
	ld a,l			;70ad
	ld l,h			;70ae
	ld h,a			;70af
	ld de,00754h		;70b0
	rst 20h			;70b3
	jr c,L_70D0		;70b4
	ld hl,04028h		;70b6
	ld de,0f11ch		;70b9
	ld bc,00006h		;70bc
	call L_6371		;70bf
	ld hl,0f11ch		;70c2
	ld a,(hl)			;70c5
	res 7,(hl)		;70c6
	add a,a			;70c8
	ret nc			;70c9
	ld a,001h		;70ca
	ld (0f124h),a		;70cc
	ret			;70cf
L_70D0:
	ex de,hl			;70d0
	ld hl,07104h		;70d1
L_70D4:
	ld a,(hl)			;70d4
	inc hl			;70d5
	cp 0ffh		;70d6
	jr z,L_70E9		;70d8
	cp e			;70da
	jr nz,L_70E1		;70db
	ld a,(hl)			;70dd
	cp d			;70de
	jr z,L_70E4		;70df
L_70E1:
	inc hl			;70e1
	jr L_70D4		;70e2
L_70E4:
	ld hl,070f8h		;70e4
	jr L_70EC		;70e7
L_70E9:
	ld hl,070feh		;70e9
L_70EC:
	ld de,0f11ch		;70ec
	ld bc,00006h		;70ef
	ldir		;70f2
	call L_71D7		;70f4
	ret			;70f7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x70f8..0x7112  (26 bytes)
DATA_70F8:
	defb 001h,001h,000h,002h,080h,0f6h,000h,000h,000h,000h,0ffh,0ffh,044h,007h,045h,007h	; 70f8  ............D.E.
	defb 047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh	; 7108  G.H.P.S...

; ======================================================================
; CODIGO 0x7112..0x71ed  (219 bytes)
; ======================================================================


L_7112:
	call L_7136		;7112
	ld a,(0f281h)		;7115
	ld b,a			;7118
	cp 036h		;7119
	jr nz,L_7123		;711b
	ld a,004h		;711d
	ld (0f292h),a		;711f
	ret			;7122
L_7123:
	ld a,b			;7123
	sub 003h		;7124
	cp 002h		;7126
	jr c,L_7130		;7128
	ld a,b			;712a
	sub 010h		;712b
	cp 002h		;712d
	ret nc			;712f
L_7130:
	ld a,001h		;7130
	ld (092ceh),a		;7132
	ret			;7135
L_7136:
	ld hl,045d0h		;7136
	ld de,0f280h		;7139
	ld bc,00016h		;713c
	ldir		;713f
	ld a,0ffh		;7141
	ld (0f293h),a		;7143
	ld hl,04010h		;7146
	call 0576bh		;7149
	ld hl,04241h		;714c
	rst 20h			;714f
	jr nz,L_715E		;7150
	ld hl,04012h		;7152
	ld de,0f280h		;7155
	ld bc,00013h		;7158
	jp L_6371		;715b
L_715E:
	ld hl,04645h		;715e
	rst 20h			;7161
	jr z,L_716B		;7162
	ld hl,04443h		;7164
	rst 20h			;7167
	jp nz,L_71F9		;7168
L_716B:
	ld hl,04012h		;716b
	ld de,0e000h		;716e
	ld bc,0002dh		;7171
	call L_6371		;7174
	ld hl,0e000h		;7177
L_717A:
	ld de,0f280h		;717a
	ldi		;717d
	ldi		;717f
	ld a,0ffh		;7181
	ld (de),a			;7183
	inc de			;7184
	inc de			;7185
	ld bc,(0f280h)		;7186
	ld a,c			;718a
	cp 007h		;718b
	jr nz,L_719C		;718d
	ld a,b			;718f
	cp 048h		;7190
	jr z,L_7199		;7192
	cp 050h		;7194
	ret z			;7196
	jr L_719C		;7197
L_7199:
	ld hl,04828h		;7199
L_719C:
	ld a,(hl)			;719c
	rra			;719d
	jr c,L_71AB		;719e
	inc hl			;71a0
	ld bc,00002h		;71a1
	ldir		;71a4
	ld de,0f292h		;71a6
	ldi		;71a9
L_71AB:
	rra			;71ab
	jr c,L_71BA		;71ac
	ld de,0f28ah		;71ae
	ldi		;71b1
	ldi		;71b3
	ld de,0f293h		;71b5
	ldi		;71b8
L_71BA:
	ld ix,071edh		;71ba
	ld b,006h		;71be
L_71C0:
	push bc			;71c0
	rra			;71c1
	jr c,L_71CF		;71c2
	ld e,(ix+000h)		;71c4
	ld d,(ix+001h)		;71c7
	ld bc,00002h		;71ca
	ldir		;71cd
L_71CF:
	pop bc			;71cf
	inc ix		;71d0
	inc ix		;71d2
	djnz L_71C0		;71d4
	ret			;71d6
L_71D7:
	ld hl,(0e000h)		;71d7
	ld a,h			;71da
	ld h,l			;71db
	ld l,a			;71dc
	ld de,00751h		;71dd
	rst 20h			;71e0
	jr z,L_71E7		;71e1
	ld de,00752h		;71e3
	rst 20h			;71e6
L_71E7:
	ld a,001h		;71e7
	ld (0f124h),a		;71e9
	ret			;71ec

; ----------------------------------------------------------------------
; DATOS sin identificar  0x71ed..0x71f9  (12 bytes)
DATA_71ED:
	defb 088h,0f2h,08ch,0f2h,08eh,0f2h,090h,0f2h,086h,0f2h,094h,0f2h	; 71ed  ............

; ======================================================================
; CODIGO 0x71f9..0x728e  (149 bytes)
; ======================================================================


L_71F9:
	ld a,(0f104h)		;71f9
	ld de,00000h		;71fc
	ld hl,05000h		;71ff
	ld b,000h		;7202
L_7204:
	push af			;7204
	push bc			;7205
	push de			;7206
	call 0000ch		;7207   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;720a
	pop bc			;720b
	add a,e			;720c
	ld e,a			;720d
	jr nc,L_7211		;720e
	inc d			;7210
L_7211:
	pop af			;7211
	inc hl			;7212
	djnz L_7204		;7213
	ld ix,044beh		;7215
L_7219:
	ld l,(ix+000h)		;7219
	ld h,(ix+001h)		;721c
	ld a,l			;721f
	or h			;7220
	ret z			;7221
	rst 20h			;7222
	jr z,L_722F		;7223
	inc ix		;7225
	inc ix		;7227
	inc ix		;7229
	inc ix		;722b
	jr L_7219		;722d
L_722F:
	push de			;722f
	ld l,(ix+002h)		;7230
	ld h,(ix+003h)		;7233
	push hl			;7236
	ld d,(hl)			;7237
	inc hl			;7238
	ld e,(hl)			;7239
	ld hl,00744h		;723a
	ex de,hl			;723d
	rst 20h			;723e
	pop hl			;723f
	jr nc,L_724D		;7240
	ld de,0f280h		;7242
	ld bc,00013h		;7245
	ldir		;7248
	pop de			;724a
	scf			;724b
	ret			;724c
L_724D:
	pop de			;724d
	jp L_717A		;724e
L_7251:
	add a,l			;7251
	ld l,a			;7252
	ret nc			;7253
	inc h			;7254
	ret			;7255
L_7256:
	add a,e			;7256
	ld e,a			;7257
	ret nc			;7258
	inc d			;7259
	ret			;725a
L_725B:
	push bc			;725b
	push hl			;725c
	ld b,a			;725d
	ld a,(00007h)		;725e
	inc a			;7261
	ld c,a			;7262
	di			;7263
	out (c),b		;7264
	ld a,090h		;7266
	out (c),a		;7268
	inc c			;726a
	out (c),d		;726b
	push af			;726d
	pop af			;726e
	out (c),e		;726f
	pop hl			;7271
	pop bc			;7272
	ei			;7273
	ret			;7274
L_7275:
	ld a,(0002dh)		;7275
	and a			;7278
	ret z			;7279
	ld hl,0728eh		;727a
	ld b,010h		;727d
	ld a,000h		;727f
L_7281:
	ld d,(hl)			;7281
	inc hl			;7282
	ld e,(hl)			;7283
	inc hl			;7284
	push af			;7285
	call L_725B		;7286
	pop af			;7289
	inc a			;728a
	djnz L_7281		;728b
	ret			;728d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x728e..0x72ae  (32 bytes)
DATA_728E:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 728e  ......3...'.Q.'.
	defb 071h,001h,073h,003h,061h,006h,064h,006h,011h,004h,065h,002h,055h,005h,077h,007h	; 729e  q.s.a.d...e.U.w.

; ======================================================================
; CODIGO 0x72ae..0x72e2  (52 bytes)
; ======================================================================


L_72AE:
	ld a,(hl)			;72ae
	inc hl			;72af
	inc a			;72b0
	ret z			;72b1
	dec a			;72b2
	ld d,(hl)			;72b3
	inc hl			;72b4
	ld e,(hl)			;72b5
	inc hl			;72b6
	call L_725B		;72b7
	jr L_72AE		;72ba
L_72BC:
	ld hl,072e2h		;72bc
	ld bc,00800h		;72bf
L_72C2:
	push bc			;72c2
	ld b,(hl)			;72c3
	call 00047h		;72c4   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;72c7
	inc hl			;72c8
	inc c			;72c9
	djnz L_72C2		;72ca
	ld a,(0002dh)		;72cc
	and a			;72cf
	ret z			;72d0
	ld bc,00017h		;72d1
	call 00047h		;72d4   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0ffe8h)		;72d7
	and 07fh		;72da
	ld b,a			;72dc
	ld c,009h		;72dd
	jp 00047h		;72df   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; DATOS sin identificar  0x72e2..0x72ea  (8 bytes)
DATA_72E2:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 72e2  .....v..

; ======================================================================
; CODIGO 0x72ea..0x7387  (157 bytes)
; ======================================================================


L_72EA:
	ld hl,03800h		;72ea
	ld bc,00300h		;72ed
	xor a			;72f0
	call 00056h		;72f1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;72f4
	ld a,0d0h		;72f7
	jp 0004dh		;72f9   ; BIOS WRTVRM - Writes data in VRAM
L_72FC:
	ld d,003h		;72fc
L_72FE:
	push bc			;72fe
	push de			;72ff
	call 00056h		;7300   ; BIOS FILVRM - Fills VRAM with value
	ld bc,00800h		;7303
	add hl,bc			;7306
	pop de			;7307
	pop bc			;7308
	dec d			;7309
	jr nz,L_72FE		;730a
	ret			;730c
L_730D:
	ld a,003h		;730d
L_730F:
	push af			;730f
	push bc			;7310
	push hl			;7311
	push de			;7312
	call 0005ch		;7313   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop de			;7316
	ld hl,00800h		;7317
	add hl,de			;731a
	ex de,hl			;731b
	pop hl			;731c
	pop bc			;731d
	pop af			;731e
	dec a			;731f
	jr nz,L_730F		;7320
	ret			;7322
L_7323:
	ld b,003h		;7323
L_7325:
	push bc			;7325
	push hl			;7326
	push de			;7327
	call L_733A		;7328
	pop de			;732b
	ld hl,00800h		;732c
	add hl,de			;732f
	ex de,hl			;7330
	pop hl			;7331
	pop bc			;7332
	djnz L_7325		;7333
	ret			;7335
L_7336:
	ld e,(hl)			;7336
	inc hl			;7337
	ld d,(hl)			;7338
	inc hl			;7339
L_733A:
	ex de,hl			;733a
	call L_736A		;733b
	ex de,hl			;733e
	ld a,(00007h)		;733f
	ld c,a			;7342
L_7343:
	ld a,(hl)			;7343
	and 07fh		;7344
	ld b,a			;7346
	ld a,(hl)			;7347
	inc hl			;7348
	jr nz,L_734F		;7349
	cp b			;734b
	jr nz,L_7336		;734c
	ret			;734e
L_734F:
	cp b			;734f
	jr z,L_735D		;7350
L_7352:
	ld a,(hl)			;7352
	inc hl			;7353
	out (c),a		;7354
	inc de			;7356
	push hl			;7357
	pop hl			;7358
	djnz L_7352		;7359
	jr L_7343		;735b
L_735D:
	ld a,(hl)			;735d
	inc hl			;735e
L_735F:
	out (c),a		;735f
	inc de			;7361
	push ix		;7362
	pop ix		;7364
	djnz L_735F		;7366
	jr L_7343		;7368
L_736A:
	push af			;736a
	ld a,(0002dh)		;736b
	and a			;736e
	jr nz,L_7376		;736f
	call 00053h		;7371   ; BIOS SETWRT - Enables VDP to write
	pop af			;7374
	ret			;7375
L_7376:
	call 00171h		;7376   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	pop af			;7379
	ret			;737a
L_737B:
	pop hl			;737b
	add a,a			;737c
	add a,l			;737d
	ld l,a			;737e
	jr nc,L_7382		;737f
	inc h			;7381
L_7382:
	ld e,(hl)			;7382
	inc hl			;7383
	ld d,(hl)			;7384
	ex de,hl			;7385
	jp (hl)			;7386

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7387..0x738b  (4 bytes)
DATA_7387:
	defb 00eh,000h,018h,006h	; 7387

; ======================================================================
; CODIGO 0x738b..0x74cc  (321 bytes)
; ======================================================================


L_738B:
	ld c,0ffh		;738b
	jr L_7395		;738d
L_738F:
	ld c,0ffh		;738f
L_7391:
	ld e,(hl)			;7391
	inc hl			;7392
	ld d,(hl)			;7393
	inc hl			;7394
L_7395:
	call L_73B5		;7395
	jr z,L_73AB		;7398
	ld a,(hl)			;739a
	inc hl			;739b
	ld b,a			;739c
	inc b			;739d
	ret z			;739e
	inc b			;739f
	jr z,L_7391		;73a0
	and c			;73a2
	ex de,hl			;73a3
	call 0004dh		;73a4   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;73a7
	inc de			;73a8
	jr L_7395		;73a9
L_73AB:
	call L_78BA		;73ab
	ld a,(0f122h)		;73ae
	ld (0faf6h),a		;73b1
	ret			;73b4
L_73B5:
	push hl			;73b5
	push de			;73b6
	push af			;73b7
	ld a,(0fcafh)		;73b8
	sub 005h		;73bb
	jr c,L_73CB		;73bd
	ld a,(0faf6h)		;73bf
	ld (0f122h),a		;73c2
	ld a,(0faf5h)		;73c5
	ld (0faf6h),a		;73c8
L_73CB:
	ld a,(0f3dfh)		;73cb
	and 00eh		;73ce
	ld l,a			;73d0
	ld a,(0f3e0h)		;73d1
	and 018h		;73d4
	ld h,a			;73d6
	pop af			;73d7
	ld de,00006h		;73d8
	and a			;73db
	sbc hl,de		;73dc
	pop de			;73de
	pop hl			;73df
	ret			;73e0
L_73E1:
	call L_73B5		;73e1
	jr z,L_73F6		;73e4
L_73E6:
	push bc			;73e6
	ld b,000h		;73e7
	push af			;73e9
	call 00056h		;73ea   ; BIOS FILVRM - Fills VRAM with value
	pop af			;73ed
	ld bc,00020h		;73ee
	add hl,bc			;73f1
	pop bc			;73f2
	djnz L_73E6		;73f3
	ret			;73f5
L_73F6:
	push af			;73f6
	push bc			;73f7
	push hl			;73f8
	exx			;73f9
	ld a,(00006h)		;73fa
	ld c,a			;73fd
	exx			;73fe
	ld a,(0fff6h)		;73ff
	ld l,000h		;7402
	ld h,a			;7404
	srl h		;7405
	rr l		;7407
	ld a,(0f3e1h)		;7409
	and 040h		;740c
	jr z,L_7412		;740e
	set 7,h		;7410
L_7412:
	ld (0f2d1h),hl		;7412
	pop hl			;7415
	ld de,0c800h		;7416
	add hl,de			;7419
	ld a,l			;741a
	and 01fh		;741b
	add a,a			;741d
	add a,a			;741e
	ld c,a			;741f
	ld b,000h		;7420
	ld a,l			;7422
	and 0e0h		;7423
	ld l,a			;7425
	add hl,hl			;7426
	add hl,hl			;7427
	add hl,hl			;7428
	add hl,hl			;7429
	add hl,hl			;742a
	add hl,bc			;742b
	ld de,(0f2d1h)		;742c
	ld a,h			;7430
	add hl,de			;7431
	xor h			;7432
	and 080h		;7433
	call nz,L_7467		;7435
	pop bc			;7438
	ld a,c			;7439
	add a,a			;743a
	add a,a			;743b
	ld c,a			;743c
	ld a,b			;743d
	add a,a			;743e
	add a,a			;743f
	add a,a			;7440
	ld b,a			;7441
	pop af			;7442
L_7443:
	push bc			;7443
	push af			;7444
	call L_736A		;7445
	pop af			;7448
L_7449:
	exx			;7449
	out (c),a		;744a
	exx			;744c
	dec c			;744d
	jr nz,L_7449		;744e
	pop bc			;7450
	ex af,af'			;7451
	ld a,h			;7452
	ld de,00080h		;7453
	add hl,de			;7456
	xor h			;7457
	and 080h		;7458
	call nz,L_7467		;745a
	ex af,af'			;745d
	djnz L_7443		;745e
	ld a,(0f122h)		;7460
	ld (0faf6h),a		;7463
	ret			;7466
L_7467:
	ld a,h			;7467
	xor 080h		;7468
	ld h,a			;746a
	ret			;746b
L_746C:
	ld b,010h		;746c
	ld de,00000h		;746e
L_7471:
	add hl,hl			;7471
	ld a,e			;7472
	adc a,a			;7473
	daa			;7474
	ld e,a			;7475
	ld a,d			;7476
	adc a,a			;7477
	daa			;7478
	ld d,a			;7479
	djnz L_7471		;747a
	ret			;747c
L_747D:
	ld c,a			;747d
	and 0f0h		;747e
	rrca			;7480
	rrca			;7481
	rrca			;7482
	rrca			;7483
	add a,a			;7484
	ld b,a			;7485
	add a,a			;7486
	add a,a			;7487
	add a,b			;7488
	ld b,a			;7489
	ld a,c			;748a
	and 00fh		;748b
	add a,b			;748d
	ret			;748e
L_748F:
	ld bc,00613h		;748f
	ld hl,(09237h)		;7492
	xor a			;7495
	jp L_73E1		;7496
L_7499:
	ld a,(0f112h)		;7499
	or a			;749c
	ret z			;749d
L_749E:
	call L_74FD		;749e
	ld a,002h		;74a1
	ld (08000h),a		;74a3
	call 08000h		;74a6
L_74A9:
	push af			;74a9
	push hl			;74aa
	push de			;74ab
	push bc			;74ac
	ld a,(0f2a0h)		;74ad
	ld h,080h		;74b0
	call 00024h		;74b2   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop bc			;74b5
	pop de			;74b6
	pop hl			;74b7
	pop af			;74b8
	ret			;74b9
L_74BA:
	ld a,(0f112h)		;74ba
	or a			;74bd
	ret z			;74be
L_74BF:
	call L_74FD		;74bf
	ld a,002h		;74c2
	ld (08000h),a		;74c4
	call 080e4h		;74c7
	jr L_74A9		;74ca

; ----------------------------------------------------------------------
; DATOS sin identificar  0x74cc..0x74d6  (10 bytes)
DATA_74CC:
	defb 03ah,036h,092h,0feh,03ah,021h,000h,039h,038h,003h	; 74cc  :6..:!.98.

; ======================================================================
; CODIGO 0x74d6..0x762b  (341 bytes)
; ======================================================================


L_74D6:
	ld hl,03a00h		;74d6
	push hl			;74d9
	ld a,(0f3dfh)		;74da
	and 00eh		;74dd
	ld l,a			;74df
	ld a,(0f3e0h)		;74e0
	and 018h		;74e3
	ld h,a			;74e5
	ld de,00006h		;74e6
	rst 20h			;74e9
	pop hl			;74ea
	jr z,L_74F4		;74eb
	ld bc,00100h		;74ed
	xor a			;74f0
	jp 00056h		;74f1   ; BIOS FILVRM - Fills VRAM with value
L_74F4:
	call L_74FD		;74f4
	call 08080h		;74f7
	jp L_74A9		;74fa
L_74FD:
	push hl			;74fd
	push de			;74fe
	push bc			;74ff
	push af			;7500
	ld a,(0f103h)		;7501
	ld h,080h		;7504
	call 00024h		;7506   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;7509
	pop bc			;750a
	pop de			;750b
	pop hl			;750c
	ret			;750d
L_750E:
	ld (09230h),a		;750e
	or a			;7511
	ld a,b			;7512
	jr nz,L_7517		;7513
	ld a,008h		;7515
L_7517:
	ld (0922dh),a		;7517
	ld (09231h),hl		;751a
	ld (09233h),hl		;751d
	call L_7633		;7520
	call L_75E2		;7523
L_7526:
	call 0009fh		;7526   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;7529
	ld b,a			;752b
	jr nz,L_7536		;752c
	ld a,(0922eh)		;752e
	ld (0922ch),a		;7531
	or a			;7534
	ret			;7535
L_7536:
	cp 01dh		;7536
	jr z,L_753E		;7538
	cp 008h		;753a
	jr nz,L_7563		;753c
L_753E:
	call L_766D		;753e
	ld a,(0922eh)		;7541
	ld hl,0920ah		;7544
	call L_7251		;7547
	ld a,(hl)			;754a
	sub 03ch		;754b
	jr nz,L_7552		;754d
	ld (0922fh),a		;754f
L_7552:
	ld hl,0922eh		;7552
	dec (hl)			;7555
	call L_7642		;7556
	dec hl			;7559
	ld (09231h),hl		;755a
	call L_7633		;755d
	jp L_7526		;7560
L_7563:
	cp 02eh		;7563
	jr nz,L_757E		;7565
	ld a,(09230h)		;7567
	cp 0feh		;756a
	jp nz,L_7526		;756c
	call L_766D		;756f
	ld a,03ch		;7572
	ld hl,0922fh		;7574
	cp (hl)			;7577
	jp z,L_7526		;7578
	ld (hl),a			;757b
	jr L_75A8		;757c
L_757E:
	ld c,a			;757e
	sub 030h		;757f
	cp 00ah		;7581
	jr nc,L_7588		;7583
	ld a,c			;7585
	jr L_75A8		;7586
L_7588:
	ld a,c			;7588
	sub 041h		;7589
	cp 01ah		;758b
	jr nc,L_759B		;758d
	ld a,c			;758f
L_7590:
	ex af,af'			;7590
	ld a,(09230h)		;7591
	inc a			;7594
	jp z,L_7526		;7595
	ex af,af'			;7598
	jr L_75A8		;7599
L_759B:
	ld a,c			;759b
	sub 061h		;759c
	cp 01ah		;759e
	jp nc,L_7526		;75a0
	ld a,c			;75a3
	sub 020h		;75a4
	jr L_7590		;75a6
L_75A8:
	ld b,a			;75a8
	ld hl,0922eh		;75a9
	ld a,(0922dh)		;75ac
	cp (hl)			;75af
	jp z,L_7526		;75b0
	inc (hl)			;75b3
	ld a,(hl)			;75b4
	cp 001h		;75b5
	jr nz,L_75C7		;75b7
	push bc			;75b9
	ld hl,(09233h)		;75ba
	ld b,00eh		;75bd
	xor a			;75bf
L_75C0:
	call L_7646		;75c0
	inc hl			;75c3
	djnz L_75C0		;75c4
	pop bc			;75c6
L_75C7:
	ld hl,(09231h)		;75c7
	ld a,b			;75ca
	call L_7646		;75cb
	inc hl			;75ce
	ld (09231h),hl		;75cf
	call L_7633		;75d2
	ld a,(0922eh)		;75d5
	ld hl,0920ah		;75d8
	call L_7251		;75db
	ld (hl),b			;75de
	jp L_7526		;75df
L_75E2:
	ld hl,0920bh		;75e2
	ld de,0920ch		;75e5
	ld (hl),000h		;75e8
	ld bc,0001fh		;75ea
	ldir		;75ed
	call L_7600		;75ef
	call 00156h		;75f2   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;75f5
	ld (0922ch),a		;75f6
	ld (0922eh),a		;75f9
	ld (0922fh),a		;75fc
	ret			;75ff
L_7600:
	call L_73B5		;7600
	ld a,(0f122h)		;7603
	ld (0faf6h),a		;7606
	ret z			;7609
	ld hl,0762bh		;760a
	ld bc,00008h		;760d
	ld a,(0f112h)		;7610
	or a			;7613
	jr nz,L_7625		;7614
	ld a,(0f2e6h)		;7616
	and a			;7619
	ld de,021d0h		;761a
	jr z,L_7622		;761d
	ld de,02080h		;761f
L_7622:
	jp L_730D		;7622
L_7625:
	ld de,031d0h		;7625
	jp 0005ch		;7628   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0x762b..0x7633  (8 bytes)
DATA_762B:
	defb 000h,010h,018h,0fch,0feh,0fch,018h,010h	; 762b  ........

; ======================================================================
; CODIGO 0x7633..0x79cf  (924 bytes)
; ======================================================================


L_7633:
	ld hl,(09231h)		;7633
	ld a,(0f2e6h)		;7636
	and a			;7639
	ld a,03ah		;763a
	jr z,L_7640		;763c
	ld a,010h		;763e
L_7640:
	jr L_7646		;7640
L_7642:
	ld hl,(09231h)		;7642
	xor a			;7645
L_7646:
	push af			;7646
	push bc			;7647
	push hl			;7648
	push de			;7649
	call L_7652		;764a
	pop de			;764d
	pop hl			;764e
	pop bc			;764f
	pop af			;7650
	ret			;7651
L_7652:
	ex af,af'			;7652
	call L_73B5		;7653
	jr z,L_765C		;7656
	ex af,af'			;7658
	jp 0004dh		;7659   ; BIOS WRTVRM - Writes data in VRAM
L_765C:
	ex af,af'			;765c
	ex de,hl			;765d
	call L_74FD		;765e
	call L_796E		;7661
	ld a,(0f122h)		;7664
	ld (0faf6h),a		;7667
	jp L_74A9		;766a
L_766D:
	ld a,(0922eh)		;766d
	or a			;7670
	ret nz			;7671
	pop hl			;7672
	jp L_7526		;7673
L_7676:
	call L_76AF		;7676
	call L_76F6		;7679
L_767C:
	call 0009fh		;767c   ; BIOS CHGET - One character input (waiting)
	cp 020h		;767f
	jr z,L_769E		;7681
	cp 01bh		;7683
	jr z,L_768D		;7685
	ld b,a			;7687
	call L_76C1		;7688
	jr L_767C		;768b
L_768D:
	or 0ffh		;768d
	ret			;768f
L_7690:
	call L_76AF		;7690
	call L_76F6		;7693
L_7696:
	call 0009fh		;7696   ; BIOS CHGET - One character input (waiting)
	cp 020h		;7699
	ld b,a			;769b
	jr nz,L_76A9		;769c
L_769E:
	call L_7642		;769e
	ld a,(0922eh)		;76a1
	ld (0922ch),a		;76a4
	or a			;76a7
	ret			;76a8
L_76A9:
	call L_76C1		;76a9
	jp L_7696		;76ac
L_76AF:
	ld a,b			;76af
	dec a			;76b0
	ld (0922dh),a		;76b1
	ld (09233h),hl		;76b4
	ld a,(hl)			;76b7
	inc hl			;76b8
	ld h,(hl)			;76b9
	ld l,a			;76ba
	ld (09231h),hl		;76bb
	jp L_7633		;76be
L_76C1:
	ld c,0ffh		;76c1
	cp 01eh		;76c3
	jr z,L_76CC		;76c5
	ld c,001h		;76c7
	cp 01fh		;76c9
	ret nz			;76cb
L_76CC:
	ld hl,0922dh		;76cc
	ld de,0922eh		;76cf
	ld a,(de)			;76d2
	add a,c			;76d3
	jp p,L_76D8		;76d4
	ld a,(hl)			;76d7
L_76D8:
	cp (hl)			;76d8
	jr c,L_76DE		;76d9
	jr z,L_76DE		;76db
	xor a			;76dd
L_76DE:
	ld (de),a			;76de
	ld b,a			;76df
	ld hl,(09233h)		;76e0
	add a,a			;76e3
	call L_7251		;76e4
	ld a,(hl)			;76e7
	inc hl			;76e8
	ld h,(hl)			;76e9
	ld l,a			;76ea
	push hl			;76eb
	call L_7642		;76ec
	pop hl			;76ef
	ld (09231h),hl		;76f0
	jp L_7633		;76f3
L_76F6:
	call L_7600		;76f6
	call 00156h		;76f9   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;76fc
	ld (0922ch),a		;76fd
	ld (0922eh),a		;7700
	ld (0922fh),a		;7703
	ret			;7706
L_7707:
	ld hl,08802h		;7707
	ld de,08002h		;770a
L_770D:
	ld a,081h		;770d
	ld (0dd93h),a		;770f
	ld c,(hl)			;7712
	ld (0dd94h),de		;7713
	inc de			;7717
	ld a,c			;7718
	ld (de),a			;7719
	inc hl			;771a
	inc de			;771b
	call L_7790		;771c
	jp z,L_77AF		;771f
	ld a,c			;7722
	cp (hl)			;7723
	jr z,L_7763		;7724
	ld a,001h		;7726
	ld (0dd93h),a		;7728
L_772B:
	ld c,(hl)			;772b
	inc hl			;772c
	ld a,c			;772d
	ld (de),a			;772e
	inc de			;772f
	call L_7790		;7730
	jp z,L_77A6		;7733
	cp (hl)			;7736
	jr nz,L_7756		;7737
	inc hl			;7739
	call L_7790		;773a
	jr z,L_779B		;773d
	cp (hl)			;773f
	dec hl			;7740
	jr nz,L_7756		;7741
L_7743:
	dec hl			;7743
	dec de			;7744
	push hl			;7745
	ld hl,(0dd94h)		;7746
	ld a,(0dd93h)		;7749
	set 7,a		;774c
	ld (hl),a			;774e
	pop hl			;774f
	ld (0dd94h),de		;7750
	jr L_770D		;7754
L_7756:
	ld a,(0dd93h)		;7756
	cp 07bh		;7759
	jr z,L_7743		;775b
	inc a			;775d
	ld (0dd93h),a		;775e
	jr L_772B		;7761
L_7763:
	ld a,002h		;7763
	ld (0dd93h),a		;7765
L_7768:
	inc hl			;7768
	call L_7790		;7769
	jr z,L_77AF		;776c
	ld a,c			;776e
	cp (hl)			;776f
	jr z,L_7783		;7770
L_7772:
	ld de,(0dd94h)		;7772
	ld a,(0dd93h)		;7776
	ld (de),a			;7779
	inc de			;777a
	inc de			;777b
	ld (0dd94h),de		;777c
	jp L_770D		;7780
L_7783:
	ld a,(0dd93h)		;7783
	cp 07bh		;7786
	jr z,L_7772		;7788
	inc a			;778a
	ld (0dd93h),a		;778b
	jr L_7768		;778e
L_7790:
	push hl			;7790
	push de			;7791
	ld de,08882h		;7792
	and a			;7795
	sbc hl,de		;7796
	pop de			;7798
	pop hl			;7799
	ret			;779a
L_779B:
	dec hl			;779b
	ld a,(hl)			;779c
	ld (de),a			;779d
	inc de			;779e
	ld a,(0dd93h)		;779f
	inc a			;77a2
	ld (0dd93h),a		;77a3
L_77A6:
	ld a,(0dd93h)		;77a6
	inc a			;77a9
	set 7,a		;77aa
	ld (0dd93h),a		;77ac
L_77AF:
	xor a			;77af
	ld (de),a			;77b0
	ld a,(0dd93h)		;77b1
	ld hl,(0dd94h)		;77b4
	ld (hl),a			;77b7
	ex de,hl			;77b8
	ld de,08001h		;77b9
	and a			;77bc
	sbc hl,de		;77bd
	ld (08000h),hl		;77bf
	ret			;77c2
L_77C3:
	ld a,(0f2a0h)		;77c3
	ld h,080h		;77c6
	call 00024h		;77c8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld de,08000h		;77cb
	ld hl,01000h		;77ce
	ld bc,00080h		;77d1
	call L_7834		;77d4
	ld de,08100h		;77d7
	ld hl,01180h		;77da
	ld bc,00158h		;77dd
	call L_7834		;77e0
	ld de,083b0h		;77e3
	ld hl,01400h		;77e6
	ld bc,00040h		;77e9
	call L_7834		;77ec
	ld hl,03a00h		;77ef
	ld de,08430h		;77f2
	ld bc,00300h		;77f5
	call 00059h		;77f8   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,03b00h		;77fb
	ld de,08730h		;77fe
	ld bc,00001h		;7801
	call 00059h		;7804   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,01000h		;7807
	ld bc,00008h		;780a
	ld a,055h		;780d
	call 00056h		;780f   ; BIOS FILVRM - Fills VRAM with value
	call L_78A0		;7812
	ld hl,0483fh		;7815
	ld de,03180h		;7818
	ld bc,00158h		;781b
	call 0005ch		;781e   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,01180h		;7821
	ld a,0f5h		;7824
	ld bc,00158h		;7826
	call 00056h		;7829   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;782c
	ld a,0d0h		;782f
	jp 0004dh		;7831   ; BIOS WRTVRM - Writes data in VRAM
L_7834:
	push bc			;7834
	push de			;7835
	push hl			;7836
	call 00059h		;7837   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;783a
	ld bc,02000h		;783b
	add hl,bc			;783e
	pop de			;783f
	pop bc			;7840
	ex de,hl			;7841
	add hl,bc			;7842
	ex de,hl			;7843
	jp 00059h		;7844   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_7847:
	ld a,(0f2a0h)		;7847
	ld h,080h		;784a
	call 00024h		;784c   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_78A0		;784f
	ld hl,08000h		;7852
	ld de,01000h		;7855
	ld bc,00080h		;7858
	call L_788E		;785b
	ld hl,08100h		;785e
	ld de,01180h		;7861
	ld bc,00158h		;7864
	call L_788E		;7867
	ld hl,083b0h		;786a
	ld de,01400h		;786d
	ld bc,00040h		;7870
	call L_788E		;7873
	ld hl,08430h		;7876
	ld de,03a00h		;7879
	ld bc,00300h		;787c
	call 0005ch		;787f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,08730h		;7882
	ld de,03b00h		;7885
	ld bc,00001h		;7888
	jp 0005ch		;788b   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_788E:
	push bc			;788e
	push hl			;788f
	push de			;7890
	call 0005ch		;7891   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;7894
	ld bc,02000h		;7895
	add hl,bc			;7898
	pop de			;7899
	pop bc			;789a
	ex de,hl			;789b
	add hl,bc			;789c
	jp 0005ch		;789d   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_78A0:
	ld hl,(0f2a1h)		;78a0
	ld de,00002h		;78a3
	rst 20h			;78a6
	jp z,L_74D6		;78a7
	ld de,00004h		;78aa
	rst 20h			;78ad
	jp z,L_74D6		;78ae
	jp L_72EA		;78b1
L_78B4:
	ld c,0ffh		;78b4
	ld e,(hl)			;78b6
	inc hl			;78b7
	ld d,(hl)			;78b8
	inc hl			;78b9
L_78BA:
	call L_78D0		;78ba
L_78BD:
	ld a,(hl)			;78bd
	and c			;78be
	inc hl			;78bf
	ld b,a			;78c0
	inc b			;78c1
	ret z			;78c2
	inc b			;78c3
	jr z,L_78B4		;78c4
	and c			;78c6
	call L_790D		;78c7
	inc de			;78ca
	inc de			;78cb
	inc de			;78cc
	inc de			;78cd
	jr L_78BD		;78ce
L_78D0:
	push af			;78d0
	push hl			;78d1
	ld hl,0c800h		;78d2
	add hl,de			;78d5
	ld a,l			;78d6
	and 01fh		;78d7
	add a,a			;78d9
	add a,a			;78da
	ld (0f2b1h),a		;78db
	ld a,l			;78de
	and 0e0h		;78df
	ld l,a			;78e1
	add hl,hl			;78e2
	add hl,hl			;78e3
	add hl,hl			;78e4
	add hl,hl			;78e5
	add hl,hl			;78e6
	ld a,(0f2b1h)		;78e7
	ld e,a			;78ea
	ld d,000h		;78eb
	add hl,de			;78ed
	ld a,(0f3e1h)		;78ee
	and 020h		;78f1
	jr z,L_78F7		;78f3
	set 7,h		;78f5
L_78F7:
	ld a,(0fff6h)		;78f7
	ld e,000h		;78fa
	ld d,a			;78fc
	srl d		;78fd
	rr e		;78ff
	ld a,h			;7901
	add hl,de			;7902
	xor h			;7903
	and 080h		;7904
	ex de,hl			;7906
	call nz,L_7969		;7907
	pop hl			;790a
	pop af			;790b
	ret			;790c
L_790D:
	push hl			;790d
	push bc			;790e
	push de			;790f
	sub 02fh		;7910
	jr nc,L_7915		;7912
	xor a			;7914
L_7915:
	ld de,04837h		;7915
	ld l,a			;7918
	ld h,000h		;7919
	add hl,hl			;791b
	add hl,hl			;791c
	add hl,hl			;791d
	add hl,de			;791e
	ex de,hl			;791f
	ld hl,0f2b1h		;7920
	ld c,008h		;7923
L_7925:
	ld b,004h		;7925
	ld a,(de)			;7927
	inc de			;7928
L_7929:
	add a,a			;7929
	ld (hl),000h		;792a
	jr nc,L_7930		;792c
	ld (hl),0e0h		;792e
L_7930:
	add a,a			;7930
	jr nc,L_7939		;7931
	ex af,af'			;7933
	ld a,(hl)			;7934
	or 00eh		;7935
	ld (hl),a			;7937
	ex af,af'			;7938
L_7939:
	inc hl			;7939
	djnz L_7929		;793a
	dec c			;793c
	jr nz,L_7925		;793d
	pop de			;793f
	push de			;7940
	ld a,(00007h)		;7941
	ld c,a			;7944
	ld hl,0f2b1h		;7945
	ld b,008h		;7948
L_794A:
	push bc			;794a
	ex de,hl			;794b
	call 00171h		;794c   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	ex de,hl			;794f
	ld b,004h		;7950
	otir		;7952
	ld a,d			;7954
	push hl			;7955
	ld hl,00080h		;7956
	add hl,de			;7959
	ex de,hl			;795a
	pop hl			;795b
	xor d			;795c
	and 080h		;795d
	call nz,L_7969		;795f
	pop bc			;7962
	djnz L_794A		;7963
	pop de			;7965
	pop bc			;7966
	pop hl			;7967
	ret			;7968
L_7969:
	ld a,d			;7969
	xor 080h		;796a
	ld d,a			;796c
	ret			;796d
L_796E:
	call L_78D0		;796e
	jr L_790D		;7971
L_7973:
	di			;7973
	ld hl,079f3h		;7974
	ld de,0fd9fh		;7977
	ld bc,00003h		;797a
	ldir		;797d
	ld hl,00000h		;797f
	add hl,sp			;7982
	ld (0f000h),hl		;7983
	ei			;7986
	call 0448dh		;7987
	ld hl,0e000h		;798a
	ld de,0e001h		;798d
	ld bc,00fffh		;7990
	ld (hl),000h		;7993
	ldir		;7995
	ld hl,(00004h)		;7997
	ld de,02000h		;799a
	ld bc,007f0h		;799d
	call L_730D		;79a0
	ld hl,00000h		;79a3
	ld bc,007f0h		;79a6
	ld a,0f0h		;79a9
	call L_72FC		;79ab
	ld a,(0f103h)		;79ae
	ld (0e000h),a		;79b1
	ld a,001h		;79b4
	ld (0f2e6h),a		;79b6
L_79B9:
	ld hl,04123h		;79b9
	call L_738F		;79bc
	ld b,004h		;79bf
	ld hl,04175h		;79c1
	call L_7690		;79c4
	push af			;79c7
	call 044adh		;79c8
	pop af			;79cb
	call L_737B		;79cc

; ----------------------------------------------------------------------
; DATOS saltos_79CF: tabla de 4 palabras del despachador (call 0x408D en
;   0x79CC); lo leen el despachador (8 bytes)
;   0x79cf..0x79d7  (8 bytes)
DATA_saltos_79CF:
	defb 0e1h,079h	; 79cf
	defb 0e7h,079h	; 79d1
	defb 0edh,079h	; 79d3
	defb 0d7h,079h	; 79d5

; ======================================================================
; CODIGO 0x79d7..0x7a1a  (67 bytes)
; ======================================================================


L_79D7:
	ld a,0c9h		;79d7
	ld (0fd9fh),a		;79d9
	xor a			;79dc
	ld (0f2e6h),a		;79dd
	ret			;79e0
L_79E1:
	call 0417dh		;79e1
	jp L_79B9		;79e4
L_79E7:
	call 04209h		;79e7
	jp L_79B9		;79ea
L_79ED:
	call 04333h		;79ed
	jp L_79B9		;79f0
L_79F3:
	jp L_79F6		;79f3
L_79F6:
	ld a,006h		;79f6
	call 00141h		;79f8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;79fb
	jp nz,0013eh		;79fd   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;7a00
	call 00141h		;7a02   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;7a05
	jp c,0013eh		;7a06   ; BIOS RDVDP - Reads VDP status register
	xor a			;7a09
	ld (0f2e6h),a		;7a0a
	ld a,0c9h		;7a0d
	ld (0fd9fh),a		;7a0f
	call 0013eh		;7a12   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f000h)		;7a15
	ld sp,hl			;7a18
	ret			;7a19

; ----------------------------------------------------------------------
; DATOS relleno_ff: 1510 bytes a 0xFF hasta el final del banco: relleno; lo
;   leen nadie (1510 bytes)
;   0x7a1a..0x8000  (1510 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aaa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7ada  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7afa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7baa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7caa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7daa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eaa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7efa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7faa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7ffa
