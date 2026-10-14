; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x4000..0x4020  (32 bytes)
DATA_4000:
	defb 041h,042h,083h,055h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.U............
	defb 059h,05ah,000h,000h,000h,000h,000h,000h,0c3h,0e5h,056h,000h,000h,000h,000h,000h	; 4010  YZ........V.....

; ======================================================================
; CODIGO 0x4020..0x40ae  (142 bytes)
; ======================================================================


L_4020:
	push ix		;4020
	push iy		;4022
	push de			;4024
	push bc			;4025
	call L_5752		;4026
	ld h,080h		;4029
	call 00024h		;402b   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;402e
	ld (08000h),a		;4030
	ld a,010h		;4033
	ld (0a000h),a		;4035
	pop bc			;4038
	pop de			;4039
	push de			;403a
	call 08000h		;403b
	push af			;403e
	ld a,002h		;403f
	ld (08000h),a		;4041
	inc a			;4044
	ld (0a000h),a		;4045
	pop af			;4048
	pop de			;4049
	pop iy		;404a
	pop ix		;404c
	ret			;404e
L_404F:
	call L_40D6		;404f
	call 08043h		;4052
	jp L_40E5		;4055
L_4058:
	call L_40D6		;4058
	call 0801bh		;405b
	jp L_40E5		;405e
L_4061:
	call L_40D6		;4061
	call 080d2h		;4064
	jr $+126		;4067
L_4069:
	call L_40D6		;4069
	call 08117h		;406c
	jr $+118		;406f
L_4071:
	call L_40D6		;4071
	call 08133h		;4074
	jr $+110		;4077
L_4079:
	call L_40D6		;4079
	call 08134h		;407c
	jr $+102		;407f
L_4081:
	call L_40D6		;4081
	call 082cah		;4084
	jr $+94		;4087
L_4089:
	call L_40D6		;4089
	call 0846dh		;408c
	push af			;408f
	call L_40E5		;4090
	pop af			;4093
	ret			;4094
L_4095:
	call L_40D6		;4095
	call 08191h		;4098
	jr $+74		;409b
L_409D:
	call L_40D6		;409d
	ld hl,0483fh		;40a0
	ld de,03180h		;40a3
	ld bc,00158h		;40a6
	call 0005ch		;40a9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	jr $+57		;40ac

; ----------------------------------------------------------------------
; DATOS sin identificar  0x40ae..0x40d6  (40 bytes)
DATA_40AE:
	defb 0cdh,0d6h,040h,021h,08fh,048h,001h,008h,000h,03ah,012h,0f1h,0b7h,020h,011h,03ah	; 40ae  ..@!.H...:... .:
	defb 0e6h,0f2h,0a7h,011h,0d0h,021h,028h,003h,011h,080h,020h,0cdh,00dh,073h,018h,017h	; 40be  .....!(... ..s..
	defb 011h,0d0h,031h,0cdh,05ch,000h,018h,00fh	; 40ce  ..1.\...

; ======================================================================
; CODIGO 0x40d6..0x4123  (77 bytes)
; ======================================================================


L_40D6:
	ld a,001h		;40d6
	ld (06000h),a		;40d8
	ld a,009h		;40db
	ld (08000h),a		;40dd
	inc a			;40e0
	ld (0a000h),a		;40e1
	ret			;40e4
L_40E5:
	ld a,002h		;40e5
	ld (08000h),a		;40e7
	inc a			;40ea
	ld (0a000h),a		;40eb
	ret			;40ee
L_40EF:
	jp L_56E5		;40ef
L_40F2:
	ld a,007h		;40f2
	ld (08000h),a		;40f4
	inc a			;40f7
	ld (0a000h),a		;40f8
	call 08000h		;40fb
	ld a,002h		;40fe
	ld (08000h),a		;4100
	inc a			;4103
	ld (0a000h),a		;4104
	ret			;4107
L_4108:
	ld a,005h		;4108
	ld (08000h),a		;410a
	inc a			;410d
	ld (0a000h),a		;410e
	call 08000h		;4111
	ld a,0c9h		;4114
	ld (0fd9fh),a		;4116
	ld a,002h		;4119
	ld (08000h),a		;411b
	inc a			;411e
	ld (0a000h),a		;411f
	ret			;4122

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4123..0x417d  (90 bytes)
DATA_4123:
	defb 024h,038h,02dh,02dh,053h,052h,041h,04dh,000h,044h,049h,053h,04bh,000h,055h,054h	; 4123  $8--SRAM.DISK.UT
	defb 049h,04ch,049h,054h,059h,02dh,02dh,0feh,0c2h,039h,053h,045h,04ch,045h,043h,054h	; 4133  ILITY--..9SELECT
	defb 000h,043h,04fh,04dh,04dh,041h,04eh,044h,0feh,0e4h,039h,044h,049h,052h,045h,043h	; 4143  .COMMAND..9DIREC
	defb 054h,04fh,052h,059h,0feh,004h,03ah,046h,049h,04ch,045h,000h,044h,045h,04ch,045h	; 4153  TORY..:FILE.DELE
	defb 054h,045h,0feh,024h,03ah,046h,04fh,052h,04dh,041h,054h,0feh,044h,03ah,045h,04eh	; 4163  TE.$:FORMAT.D:EN
	defb 044h,0ffh,0e3h,039h,003h,03ah,023h,03ah,043h,03ah	; 4173  D..9.:#:C:

; ======================================================================
; CODIGO 0x417d..0x41e2  (101 bytes)
; ======================================================================


L_417D:
	call L_449D		;417d
	call L_4495		;4180
	ld hl,0e010h		;4183
	ld de,0e011h		;4186
	ld bc,00400h		;4189
	xor a			;418c
	ld (hl),a			;418d
	ldir		;418e
	ld (0e001h),a		;4190
	ld hl,041ech		;4193
	call 0738fh		;4196
	ld hl,0e010h		;4199
	ld (0e21dh),hl		;419c
	ld iy,(0dfffh)		;419f
	ld de,0e210h		;41a3
	ld c,005h		;41a6
	ld ix,04020h		;41a8
	call 0001ch		;41ac   ; BIOS CALSLT - Executes inter-slot call
	and a			;41af
	jp nz,L_41D1		;41b0
	ld a,c			;41b3
	and a			;41b4
	jp z,L_41D1		;41b5
	call L_43F7		;41b8
	ld hl,041f8h		;41bb
L_41BE:
	call 0009fh		;41be   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;41c1
	jr z,L_41D8		;41c3
	cp 01fh		;41c5
	jr z,L_41DD		;41c7
	cp 020h		;41c9
	jr nz,L_41BE		;41cb
	call L_449D		;41cd
	ret			;41d0
L_41D1:
	ld hl,041e2h		;41d1
	call 0738fh		;41d4
	ret			;41d7
L_41D8:
	call L_43D6		;41d8
	jr L_41BE		;41db
L_41DD:
	call L_43E6		;41dd
	jr L_41BE		;41e0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x41e2..0x4209  (39 bytes)
DATA_41E2:
	defb 0eah,038h,04eh,04fh,000h,046h,049h,04ch,045h,0ffh,068h,038h,044h,049h,052h,045h	; 41e2  .8NO.FILE.h8DIRE
	defb 043h,054h,04fh,052h,059h,0ffh,084h,03ah,045h,04eh,044h,03ah,050h,055h,053h,048h	; 41f2  CTORY..:END:PUSH
	defb 000h,053h,050h,041h,043h,045h,0ffh	; 4202

; ======================================================================
; CODIGO 0x4209..0x42d3  (202 bytes)
; ======================================================================


L_4209:
	call L_44A5		;4209
	call L_449D		;420c
	ld hl,042d3h		;420f
	call 0738fh		;4212
	xor a			;4215
	ld (0e002h),a		;4216
	ld hl,0e250h		;4219
	ld b,005h		;421c
L_421E:
	ld (hl),a			;421e
	inc hl			;421f
	djnz L_421E		;4220
L_4222:
	call 0009fh		;4222   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;4225
	jp z,L_4282		;4227
	cp 01dh		;422a
	jr z,L_424F		;422c
	cp 01ch		;422e
	jr z,L_4222		;4230
	cp 008h		;4232
	jr z,L_424F		;4234
	ld c,a			;4236
	ld hl,0e250h		;4237
	ld a,(0e002h)		;423a
	cp 005h		;423d
	jr z,L_4222		;423f
	call 07251h		;4241
	ld (hl),c			;4244
	ld hl,0e002h		;4245
	inc (hl)			;4248
	call L_4267		;4249
	jp L_4222		;424c
L_424F:
	ld hl,0e250h		;424f
	ld de,0e002h		;4252
	ld a,(de)			;4255
	and a			;4256
	jr z,L_4222		;4257
	call 07251h		;4259
	dec hl			;425c
	ld (hl),000h		;425d
	ex de,hl			;425f
	dec (hl)			;4260
	call L_4267		;4261
	jp L_4222		;4264
L_4267:
	ld hl,03ab1h		;4267
	ld de,0e250h		;426a
	ld b,005h		;426d
L_426F:
	ld a,(de)			;426f
	cp 000h		;4270
	jr z,L_4278		;4272
	cp 020h		;4274
	jr nz,L_427A		;4276
L_4278:
	ld a,02dh		;4278
L_427A:
	call 07646h		;427a
	inc hl			;427d
	inc de			;427e
	djnz L_426F		;427f
	ret			;4281
L_4282:
	ld hl,0e250h		;4282
	ld a,(hl)			;4285
	cp 000h		;4286
	jp z,L_42B8		;4288
	cp 020h		;428b
	jp z,L_42B8		;428d
	ld de,0e210h		;4290
	ld bc,00005h		;4293
	ldir		;4296
	ld iy,(0dfffh)		;4298
	ld de,0e210h		;429c
	ld c,006h		;429f
	ld ix,04020h		;42a1
	call 0001ch		;42a5   ; BIOS CALSLT - Executes inter-slot call
	and a			;42a8
	jr z,L_42C9		;42a9
	cp 0feh		;42ab
	jr z,L_42BF		;42ad
	cp 0f7h		;42af
	jr z,L_42C4		;42b1
	ld hl,042f4h		;42b3
	jr L_42CC		;42b6
L_42B8:
	call L_449D		;42b8
	call L_44AD		;42bb
	ret			;42be
L_42BF:
	ld hl,042fdh		;42bf
	jr L_42CC		;42c2
L_42C4:
	ld hl,04313h		;42c4
	jr L_42CC		;42c7
L_42C9:
	ld hl,04324h		;42c9
L_42CC:
	call 0738fh		;42cc
	call L_449D		;42cf
	ret			;42d2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x42d3..0x4333  (96 bytes)
DATA_42D3:
	defb 084h,03ah,044h,045h,04ch,045h,054h,045h,000h,046h,049h,04ch,045h,0feh,0a6h,03ah	; 42d3  .:DELETE.FILE..:
	defb 046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,000h,000h,02dh,02dh,02dh,02dh,02dh	; 42e3  FILE.NAME..-----
	defb 0ffh,0c4h,03ah,046h,041h,049h,04ch,045h,044h,0ffh,0c4h,03ah,052h,041h,04dh,000h	; 42f3  ..:FAILED..:RAM.
	defb 044h,049h,053h,04bh,000h,055h,04eh,046h,04fh,052h,04dh,041h,054h,045h,044h,0ffh	; 4303  DISK.UNFORMATED.
	defb 0c4h,03ah,046h,049h,04ch,045h,000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h	; 4313  .:FILE.NOT.FOUND
	defb 0ffh,0c4h,03ah,046h,049h,04ch,045h,000h,044h,045h,04ch,045h,054h,045h,044h,0ffh	; 4323  ..:FILE.DELETED.

; ======================================================================
; CODIGO 0x4333..0x4387  (84 bytes)
; ======================================================================


L_4333:
	call L_448D		;4333
	ld hl,04387h		;4336
	call 0738fh		;4339
L_433C:
	call 0009fh		;433c   ; BIOS CHGET - One character input (waiting)
	cp 059h		;433f
	jr z,L_4351		;4341
	cp 079h		;4343
	jr z,L_4351		;4345
	cp 04eh		;4347
	jr z,L_4369		;4349
	cp 06eh		;434b
	jr z,L_4369		;434d
	jr L_433C		;434f
L_4351:
	call L_4373		;4351
	jr z,L_435B		;4354
	call L_4373		;4356
	jr nz,L_4363		;4359
L_435B:
	ld hl,043b3h		;435b
	call 0738fh		;435e
	jr L_4369		;4361
L_4363:
	ld hl,043c6h		;4363
	call 0738fh		;4366
L_4369:
	call L_4495		;4369
	call L_44A5		;436c
	call L_449D		;436f
	ret			;4372
L_4373:
	ld c,00ch		;4373
	ld ix,04020h		;4375
	ld iy,(0dfffh)		;4379
	call 0001ch		;437d   ; BIOS CALSLT - Executes inter-slot call
	ld c,00dh		;4380
	call 0001ch		;4382   ; BIOS CALSLT - Executes inter-slot call
	and a			;4385
	ret			;4386

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4387..0x43d6  (79 bytes)
DATA_4387:
	defb 0a8h,038h,046h,04fh,052h,04dh,041h,054h,000h,052h,041h,04dh,000h,044h,049h,053h	; 4387  .8FORMAT.RAM.DIS
	defb 04bh,0feh,028h,039h,04fh,04bh,000h,000h,050h,055h,053h,048h,000h,059h,0feh,068h	; 4397  K.(9OK..PUSH.Y.h
	defb 039h,04eh,04fh,000h,000h,050h,055h,053h,048h,000h,04eh,0ffh,0c8h,03ah,046h,04fh	; 43a7  9NO..PUSH.N..:FO
	defb 052h,04dh,041h,054h,000h,043h,04fh,04dh,050h,04ch,045h,054h,045h,044h,0ffh,0c8h	; 43b7  RMAT.COMPLETED..
	defb 03ah,046h,04fh,052h,041h,04dh,054h,000h,046h,041h,049h,04ch,045h,044h,0ffh	; 43c7  :FORAMT.FAILED.

; ======================================================================
; CODIGO 0x43d6..0x44be  (232 bytes)
; ======================================================================


L_43D6:
	ld hl,0e001h		;43d6
	ld a,(hl)			;43d9
	and a			;43da
	ret z			;43db
	dec (hl)			;43dc
	ld a,(hl)			;43dd
	call L_4473		;43de
	jp nc,L_43F7		;43e1
	inc (hl)			;43e4
	ret			;43e5
L_43E6:
	ld hl,0e001h		;43e6
	ld a,(hl)			;43e9
	cp 003h		;43ea
	ret z			;43ec
	inc (hl)			;43ed
	ld a,(hl)			;43ee
	call L_4473		;43ef
	jp nc,L_43F7		;43f2
	dec (hl)			;43f5
	ret			;43f6
L_43F7:
	call L_4495		;43f7
	ld a,(0e001h)		;43fa
	cp 004h		;43fd
	jr c,L_4405		;43ff
	xor a			;4401
	ld (0e001h),a		;4402
L_4405:
	ld l,000h		;4405
	ld h,a			;4407
	srl h		;4408
	rr l		;440a
	ld de,0e010h		;440c
	add hl,de			;440f
	ex de,hl			;4410
	ld hl,038a2h		;4411
	call L_441A		;4414
	ld hl,038b4h		;4417
L_441A:
	ld b,008h		;441a
L_441C:
	push bc			;441c
	push hl			;441d
	push de			;441e
	call L_4431		;441f
	pop de			;4422
	pop hl			;4423
	ld bc,00020h		;4424
	add hl,bc			;4427
	ld a,008h		;4428
	call 07256h		;442a
	pop bc			;442d
	djnz L_441C		;442e
	ret			;4430
L_4431:
	ld b,005h		;4431
	ld a,(de)			;4433
	and a			;4434
	ret z			;4435
L_4436:
	ld a,(de)			;4436
	call 07646h		;4437
	inc de			;443a
	inc hl			;443b
	djnz L_4436		;443c
	inc hl			;443e
	inc hl			;443f
	inc hl			;4440
	inc de			;4441
	push hl			;4442
	ex de,hl			;4443
	ld e,(hl)			;4444
	inc hl			;4445
	ld d,(hl)			;4446
	dec de			;4447
	ld a,d			;4448
	add a,a			;4449
	jr nc,L_444F		;444a
	ld de,00000h		;444c
L_444F:
	ex de,hl			;444f
	add hl,hl			;4450
	ld c,h			;4451
	pop hl			;4452
	inc c			;4453
	ld b,008h		;4454
	xor a			;4456
L_4457:
	rl c		;4457
	adc a,a			;4459
	daa			;445a
	djnz L_4457		;445b
	ld c,a			;445d
	rra			;445e
	rra			;445f
	rra			;4460
	rra			;4461
	and 00fh		;4462
	add a,030h		;4464
	call 07646h		;4466
	inc hl			;4469
	ld a,c			;446a
	and 00fh		;446b
	add a,030h		;446d
	call 07646h		;446f
	ret			;4472
L_4473:
	push hl			;4473
	cp 004h		;4474
	jr nc,L_448A		;4476
	ld h,a			;4478
	ld l,000h		;4479
	srl h		;447b
	rr l		;447d
	ld de,0e010h		;447f
	add hl,de			;4482
	ld a,(hl)			;4483
	and a			;4484
	jr z,L_448A		;4485
	xor a			;4487
	pop hl			;4488
	ret			;4489
L_448A:
	scf			;448a
	pop hl			;448b
	ret			;448c
L_448D:
	ld hl,03800h		;448d
	ld bc,00300h		;4490
	jr L_44B3		;4493
L_4495:
	ld hl,038a0h		;4495
	ld bc,00100h		;4498
	jr L_44B3		;449b
L_449D:
	ld hl,03a80h		;449d
	ld bc,00040h		;44a0
	jr L_44B3		;44a3
L_44A5:
	ld hl,039c0h		;44a5
	ld bc,000a0h		;44a8
	jr L_44B3		;44ab
L_44AD:
	ld hl,03ac0h		;44ad
	ld bc,00020h		;44b0
L_44B3:
	xor a			;44b3
	call 07646h		;44b4
	inc hl			;44b7
	dec bc			;44b8
	ld a,b			;44b9
	or c			;44ba
	jr nz,L_44B3		;44bb
	ret			;44bd

; ----------------------------------------------------------------------
; DATOS sin identificar  0x44be..0x4997  (1241 bytes)
DATA_44BE:
	defb 050h,058h,0e3h,045h,0a4h,055h,0e3h,045h,0a9h,06ah,0f6h,045h,049h,066h,0f6h,045h	; 44be  PX.E.U.E.j.EIf.E
	defb 0d5h,06ch,009h,046h,061h,066h,0f6h,045h,003h,068h,009h,046h,0c5h,065h,01ch,046h	; 44ce  .l.Faf.E.h.F.e.F
	defb 040h,066h,01ch,046h,017h,05fh,01ch,046h,07eh,05bh,02fh,046h,0e8h,05ch,02fh,046h	; 44de  @f.F._.F~[/F.\/F
	defb 0e9h,05bh,02fh,046h,04ch,06ah,042h,046h,017h,05eh,055h,046h,00fh,05eh,055h,046h	; 44ee  .[/FLjBF.^UF.^UF
	defb 0bch,077h,068h,046h,037h,07ah,068h,046h,094h,078h,068h,046h,05bh,06dh,07bh,046h	; 44fe  .whF7zhF.xhF[m{F
	defb 04bh,077h,08eh,046h,017h,079h,08eh,046h,089h,078h,08eh,046h,06bh,076h,0a1h,046h	; 450e  Kw.F.y.F.x.Fkv.F
	defb 09fh,077h,0a1h,046h,0d5h,077h,0a1h,046h,076h,067h,0b4h,046h,072h,05bh,0c7h,046h	; 451e  .w.F.w.Fvg.Fr[.F
	defb 021h,05eh,0c7h,046h,065h,04ch,0c7h,046h,061h,067h,0dah,046h,014h,066h,0dah,046h	; 452e  !^.FeL.Fag.F.f.F
	defb 0c6h,068h,0dah,046h,0d4h,047h,0edh,046h,0a4h,083h,000h,047h,02ch,06ch,013h,047h	; 453e  .h.F.G.F...G,l.G
	defb 0a2h,072h,026h,047h,01ch,071h,026h,047h,0a3h,071h,026h,047h,0dch,076h,039h,047h	; 454e  .r&G.q&G.q&G.v9G
	defb 095h,046h,04ch,047h,01eh,05eh,05fh,047h,035h,05eh,05fh,047h,0b0h,05eh,05fh,047h	; 455e  .FLG.^_G5^_G.^_G
	defb 076h,068h,072h,047h,0d8h,057h,072h,047h,0edh,057h,072h,047h,085h,06dh,085h,047h	; 456e  vhrG.WrG.WrG.m.G
	defb 0b8h,06ah,085h,047h,062h,05dh,098h,047h,03bh,064h,098h,047h,018h,065h,098h,047h	; 457e  .j.Gb].G.d.G.e.G
	defb 09ch,071h,0abh,047h,048h,06bh,0abh,047h,0adh,068h,0beh,047h,08dh,067h,0beh,047h	; 458e  .q.GHk.G.h.G.g.G
	defb 02eh,068h,0beh,047h,002h,074h,0d1h,047h,004h,065h,0e4h,047h,007h,069h,0e4h,047h	; 459e  .h.G.t.G.e.G.i.G
	defb 022h,06bh,0e4h,047h,0b8h,087h,0f7h,047h,091h,079h,00ah,048h,036h,079h,00ah,048h	; 45ae  "k.G...G.y.H6y.H
	defb 0c1h,079h,00ah,048h,024h,07bh,00ah,048h,0f5h,07ah,00ah,048h,0e4h,085h,019h,048h	; 45be  .y.H${.H.z.H...H
	defb 000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 45ce  ................
	defb 000h,000h,000h,000h,000h,007h,000h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h	; 45de  .............P.Q
	defb 0e0h,040h,0e0h,043h,0e0h,046h,0e0h,009h,007h,001h,000h,000h,000h,0e0h,000h,000h	; 45ee  .@.C.F..........
	defb 000h,000h,0e0h,0e0h,040h,0e0h,043h,0e0h,000h,000h,009h,007h,001h,000h,001h,000h	; 45fe  ....@.C.........
	defb 0e0h,000h,000h,000h,000h,0e0h,0e0h,040h,0e0h,043h,0e0h,000h,000h,009h,007h,002h	; 460e  .......@.C......
	defb 000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,040h,0e0h,043h,0e0h,046h,0e0h	; 461e  ......P.Q.@.C.F.
	defb 009h,007h,003h,000h,000h,002h,0e0h,000h,0e0h,002h,0e0h,000h,000h,011h,0e0h,00bh	; 462e  ................
	defb 0e0h,00eh,0e0h,003h,007h,004h,000h,000h,002h,0e0h,000h,0e0h,002h,0e0h,000h,000h	; 463e  ................
	defb 011h,0e0h,00bh,0e0h,00eh,0e0h,003h,007h,005h,000h,000h,000h,0e0h,002h,0e0h,050h	; 464e  ...............P
	defb 0e0h,000h,000h,040h,0e0h,046h,0e0h,043h,0e0h,009h,007h,006h,000h,000h,000h,0e0h	; 465e  ...@.F.C........
	defb 002h,0e0h,050h,0e0h,000h,000h,040h,0e0h,043h,0e0h,046h,0e0h,009h,007h,007h,000h	; 466e  ..P...@.C.F.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 467e  ................
	defb 007h,010h,000h,000h,062h,0e1h,01bh,0e0h,000h,000h,016h,0e0h,080h,0e0h,083h,0e0h	; 468e  ....b...........
	defb 086h,0e0h,096h,007h,011h,000h,000h,062h,0e1h,01bh,0e0h,000h,000h,016h,0e0h,080h	; 469e  .......b........
	defb 0e0h,083h,0e0h,086h,0e0h,09fh,007h,012h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h	; 46ae  ..............P.
	defb 051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h,013h,000h,000h,000h,0e0h,002h	; 46be  Q.C.I.F.........
	defb 0e0h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h,014h,000h,000h	; 46ce  .P.Q.C.I.F......
	defb 000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h	; 46de  ....P.Q.C.I.F...
	defb 015h,000h,000h,000h,0e0h,002h,0e0h,000h,000h,052h,0e0h,044h,0e0h,04ah,0e0h,047h	; 46ee  .........R.D.J.G
	defb 0e0h,009h,007h,016h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,046h,0e0h	; 46fe  ..........P.Q.F.
	defb 049h,0e0h,04ch,0e0h,009h,007h,017h,000h,000h,000h,0e0h,000h,000h,000h,000h,080h	; 470e  I.L.............
	defb 0e0h,060h,0e0h,063h,0e0h,000h,000h,004h,007h,018h,000h,000h,000h,0e0h,000h,000h	; 471e  .`.c............
	defb 000h,000h,060h,0e0h,055h,0e0h,058h,0e0h,000h,000h,004h,007h,020h,000h,000h,000h	; 472e  ..`.U.X..... ...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,007h,021h	; 473e  ...............!
	defb 000h,000h,000h,0e0h,000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h	; 474e  ......P.Q.C.I...
	defb 004h,007h,023h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 475e  ..#.............
	defb 000h,000h,000h,000h,007h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 476e  .....$..........
	defb 000h,000h,000h,000h,000h,000h,000h,007h,025h,000h,000h,000h,0e0h,000h,000h,050h	; 477e  ........%......P
	defb 0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h,004h,007h,027h,000h,000h,000h,0e0h	; 478e  .Q.C.I.....'....
	defb 000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h,004h,007h,028h,000h	; 479e  ..P.Q.C.I.....(.
	defb 000h,000h,0e0h,001h,0e0h,050h,0e0h,053h,0e0h,047h,0e0h,04dh,0e0h,000h,000h,004h	; 47ae  .....P.S.G.M....
	defb 007h,029h,000h,000h,000h,0e0h,000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,046h,0e0h	; 47be  .)......P.Q.C.F.
	defb 000h,000h,004h,007h,030h,000h,000h,000h,0e0h,002h,0e0h,000h,000h,043h,0e0h,03ch	; 47ce  ....0........C.<
	defb 0e0h,03fh,0e0h,000h,000h,003h,007h,031h,000h,000h,000h,000h,000h,000h,000h,000h	; 47de  .?.....1........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,007h,033h,000h,000h,000h,0e0h,002h	; 47ee  ..........3.....
	defb 0e0h,000h,000h,06ah,0e0h,060h,0e0h,066h,0e0h,063h,0e0h,004h,007h,044h,0a8h,000h	; 47fe  ...j.`.f.c...D..
	defb 0c0h,004h,011h,0c4h,012h,010h,0c4h,005h,0c4h,002h,0c0h,007h,047h,0b8h,000h,0c1h	; 480e  ............G...
	defb 004h,061h,0c1h,005h,060h,0c1h,002h,0c1h,007h,048h,088h,000h,0c0h,004h,080h,0c2h	; 481e  .a..`....H......
	defb 007h,060h,0c2h,057h,0c2h,05ah,0c2h,002h,0c0h,000h,000h,000h,000h,000h,000h,000h	; 482e  .`.W.Z..........
	defb 000h,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,018h,018h,018h,018h	; 483e  ..."ccc"...8....
	defb 07eh,000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h	; 484e  ~.>c..<p..>c...c
	defb 03eh,000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h	; 485e  >...6ff....`~c.c
	defb 03eh,000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h	; 486e  >.>c`~cc>..c....
	defb 018h,000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h	; 487e  ..>cc>cc>.>cc?.c
	defb 03eh,000h,010h,018h,0fch,0feh,0fch,018h,010h,000h,000h,00ch,00ch,000h,000h,00ch	; 488e  >...............
	defb 00ch,000h,000h,000h,000h,000h,000h,00ch,00ch,000h,036h,036h,036h,000h,000h,000h	; 489e  ..........666...
	defb 000h,000h,000h,07eh,000h,000h,07eh,000h,000h,000h,01ch,022h,022h,00ch,008h,000h	; 48ae  ...~..~....""...
	defb 008h,000h,000h,000h,000h,07eh,000h,000h,000h,000h,01ch,036h,063h,063h,07fh,063h	; 48be  .....~.....6cc.c
	defb 063h,000h,07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h	; 48ce  c.~cc~cc~.>c```c
	defb 03eh,000h,07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h	; 48de  >.|fcccf|..``~``
	defb 07fh,000h,07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h	; 48ee  ...``~```.>c`gcc
	defb 03fh,000h,063h,063h,063h,07fh,063h,063h,063h,000h,03ch,018h,018h,018h,018h,018h	; 48fe  ?.ccc.ccc.<.....
	defb 03ch,000h,01fh,006h,006h,006h,006h,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh	; 490e  <......f<.cflx|n
	defb 067h,000h,060h,060h,060h,060h,060h,060h,07fh,000h,063h,077h,07fh,07fh,06bh,063h	; 491e  g.``````..cw..kc
	defb 063h,000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,063h,063h,063h,063h,063h	; 492e  c.cs{.ogc.>ccccc
	defb 03eh,000h,07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h	; 493e  >.~ccc~``.>cccof
	defb 03dh,000h,07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h	; 494e  =.~ccb|fc.>c`>.c
	defb 03eh,000h,07eh,018h,018h,018h,018h,018h,018h,000h,063h,063h,063h,063h,063h,063h	; 495e  >.~.......cccccc
	defb 03eh,000h,063h,063h,063h,063h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h	; 496e  >.cccc6...cckk.w
	defb 022h,000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h	; 497e  ".cv<..7c.ff~<..
	defb 018h,000h,07fh,007h,00eh,01ch,038h,070h,07fh	; 498e  ......8p.

; ======================================================================
; CODIGO 0x4997..0x4b18  (385 bytes)
; ======================================================================


L_4997:
	ld a,(0d12fh)		;4997
	ld h,080h		;499a
	call 00024h		;499c   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld ix,(0d314h)		;499f
	ld iy,(0d12eh)		;49a3
	call 0001ch		;49a7   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0d12eh)		;49aa
	ld h,080h		;49ad
	call 00024h		;49af   ; BIOS ENASLT - Switches to specified slot and page definitively
	ret			;49b2
L_49B3:
	ld a,(0f2a0h)		;49b3
	ld h,080h		;49b6
	call 00024h		;49b8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld sp,0df80h		;49bb
	ld hl,0c000h		;49be
	ld de,0c001h		;49c1
	ld (hl),000h		;49c4
	ld bc,01fffh		;49c6
	ldir		;49c9
	call L_4A1C		;49cb
	ld hl,0f2e1h		;49ce
	ld de,0d4f0h		;49d1
	ld bc,00005h		;49d4
	ldir		;49d7
	ld hl,09b80h		;49d9
	ld de,0c000h		;49dc
	ld bc,01100h		;49df
	ldir		;49e2
	ld hl,09b80h		;49e4
	ld de,0e280h		;49e7
	ld bc,01100h		;49ea
	ldir		;49ed
	call L_5752		;49ef
	ld (0d12eh),a		;49f2
	ld h,080h		;49f5
	call 00024h		;49f7   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_4A7B		;49fa
	ld a,0ffh		;49fd
	ld (0d13bh),a		;49ff
	ld (0d13ch),a		;4a02
	jp 08303h		;4a05
L_4A08:
	ld sp,0df80h		;4a08
	call L_5752		;4a0b
	ld (0d12eh),a		;4a0e
	ld h,080h		;4a11
	call 00024h		;4a13   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_4A7B		;4a16
	jp 08306h		;4a19
L_4A1C:
	ld hl,0f280h		;4a1c
	ld de,0d300h		;4a1f
	ld bc,00017h		;4a22
	ldir		;4a25
	ld hl,0f297h		;4a27
	ld de,0d316h		;4a2a
	ld bc,00007h		;4a2d
	ldir		;4a30
	ld a,(0f298h)		;4a32
	ld (0d317h),a		;4a35
	ret			;4a38
L_4A39:
	di			;4a39
	ld hl,0c000h		;4a3a
	ld de,0c001h		;4a3d
	ld (hl),000h		;4a40
	ld bc,01fffh		;4a42
	ldir		;4a45
	ld a,0ffh		;4a47
	ld (0d13bh),a		;4a49
	call L_5752		;4a4c
	ld (0d12eh),a		;4a4f
	call L_4A8C		;4a52
	jr nc,L_4A5A		;4a55
	jp L_4B21		;4a57
L_4A5A:
	ld sp,0df80h		;4a5a
	ld a,0ffh		;4a5d
	ld (0d13bh),a		;4a5f
	ld hl,0fd9fh		;4a62
	ld de,0d4f0h		;4a65
	ld bc,00005h		;4a68
	ldir		;4a6b
	ld a,(0d12eh)		;4a6d
	ld h,080h		;4a70
	call 00024h		;4a72   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_4A7B		;4a75
	jp 08300h		;4a78
L_4A7B:
	xor a			;4a7b
	ld (04000h),a		;4a7c
	inc a			;4a7f
	ld (06000h),a		;4a80
	inc a			;4a83
	ld (08000h),a		;4a84
	inc a			;4a87
	ld (0a000h),a		;4a88
	ret			;4a8b
L_4A8C:
	ld hl,L_4A9A		;4a8c
	ld de,0c000h		;4a8f
	ld bc,00087h		;4a92
	ldir		;4a95
	jp 0c000h		;4a97
L_4A9A:
	ld bc,00400h		;4a9a
	ld hl,0fcc1h		;4a9d
L_4AA0:
	push bc			;4aa0
	push hl			;4aa1
	ld a,(hl)			;4aa2
	bit 7,a		;4aa3
	jr nz,L_4AC4		;4aa5
	ld b,c			;4aa7
	call 0c02fh		;4aa8
	jr z,L_4AB1		;4aab
	ld a,c			;4aad
	call 0c04bh		;4aae
L_4AB1:
	pop hl			;4ab1
	pop bc			;4ab2
	jr c,L_4AB9		;4ab3
	inc hl			;4ab5
	inc c			;4ab6
	djnz L_4AA0		;4ab7
L_4AB9:
	push af			;4ab9
	ld a,(0d12eh)		;4aba
	ld h,040h		;4abd
	call 00024h		;4abf   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;4ac2
	ret			;4ac3
L_4AC4:
	call 0c034h		;4ac4
	jr L_4AB1		;4ac7
L_4AC9:
	ld a,(0d12eh)		;4ac9
	cp b			;4acc
	ret			;4acd
L_4ACE:
	and 080h		;4ace
	or c			;4ad0
	ld b,004h		;4ad1
L_4AD3:
	push bc			;4ad3
	ld b,a			;4ad4
	call 0c02fh		;4ad5
	jr z,L_4ADE		;4ad8
	ld a,b			;4ada
	call 0c04bh		;4adb
L_4ADE:
	pop bc			;4ade
	ret c			;4adf
	add a,004h		;4ae0
	djnz L_4AD3		;4ae2
	ret			;4ae4
L_4AE5:
	push af			;4ae5
	ld h,040h		;4ae6
	call 00024h		;4ae8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,04000h		;4aeb
	ld de,0c07eh		;4aee
	ld bc,04000h		;4af1
L_4AF4:
	ld a,044h		;4af4
	cpir		;4af6
	jr nz,L_4B15		;4af8
	jp po,0c07bh		;4afa
	push bc			;4afd
	push de			;4afe
	push hl			;4aff
	ld b,009h		;4b00
L_4B02:
	ld a,(de)			;4b02
	cp (hl)			;4b03
	jr nz,L_4B0A		;4b04
	inc hl			;4b06
	inc de			;4b07
	djnz L_4B02		;4b08
L_4B0A:
	pop hl			;4b0a
	pop de			;4b0b
	pop bc			;4b0c
	jr nz,L_4AF4		;4b0d
	pop af			;4b0f
	ld (0d33bh),a		;4b10
	scf			;4b13
	ret			;4b14
L_4B15:
	pop af			;4b15
	and a			;4b16
	ret			;4b17

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4b18..0x4b21  (9 bytes)
DATA_4B18:
	defb 069h,073h,06bh,020h,042h,041h,053h,049h,043h	; 4b18  isk BASIC

; ======================================================================
; CODIGO 0x4b21..0x4bca  (169 bytes)
; ======================================================================


L_4B21:
	ld a,001h		;4b21
	ld (0f3ebh),a		;4b23
	call 00062h		;4b26   ; BIOS CHGCLR - Changes the screen colors
	ld a,(0d33bh)		;4b29
	ld c,a			;4b2c
	ld hl,04002h		;4b2d
	call L_576F		;4b30
	ld iy,(0d33ah)		;4b33
	push de			;4b37
	pop ix		;4b38
	ld hl,L_4B56		;4b3a
	ld de,0c800h		;4b3d
	ld bc,0000bh		;4b40
	ldir		;4b43
	ld hl,L_4B61		;4b45
	ld de,0fedah		;4b48
	ld bc,00003h		;4b4b
	ldir		;4b4e
	call 0001ch		;4b50   ; BIOS CALSLT - Executes inter-slot call
	jp 0fecbh		;4b53
L_4B56:
	ld a,(0d12eh)		;4b56
	ld h,040h		;4b59
	call 00024h		;4b5b   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp L_4A5A		;4b5e
L_4B61:
	jp 0c800h		;4b61
L_4B64:
	ld (0984ah),sp		;4b64
	call L_4FA0		;4b68
	call L_5122		;4b6b
	call L_50D6		;4b6e
	call L_4E0A		;4b71
	call L_5132		;4b74
	jp L_4FF3		;4b77
L_4B7A:
	ld (0984ah),sp		;4b7a
	call L_4FA0		;4b7e
	call L_5122		;4b81
	call L_50D6		;4b84
	call L_4C78		;4b87
	call L_4E0A		;4b8a
	ld hl,00000h		;4b8d
	add hl,sp			;4b90
	ld (08000h),hl		;4b91
	ld hl,00002h		;4b94
	call L_5152		;4b97
	call L_5132		;4b9a
	jp L_4FF3		;4b9d
L_4BA0:
	ld (0984ah),sp		;4ba0
	call L_4FA0		;4ba4
	ld hl,09823h		;4ba7
	ld (09848h),hl		;4baa
	call L_50AB		;4bad
	ld de,0982ch		;4bb0
	ld hl,04bcah		;4bb3
	ld bc,00003h		;4bb6
	ldir		;4bb9
	call L_5122		;4bbb
	call L_50D6		;4bbe
	call L_4ED8		;4bc1
	call L_5132		;4bc4
	jp L_4FF3		;4bc7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4bca..0x4bfc  (50 bytes)
DATA_4BCA:
	defb 056h,052h,04dh,0edh,073h,04ah,098h,0cdh,0a0h,04fh,0cdh,022h,051h,0cdh,0d6h,050h	; 4bca  VRM.sJ...O."Q..P
	defb 0cdh,0adh,069h,0cdh,0a1h,04ch,0cdh,032h,051h,0c3h,0f3h,04fh,0edh,073h,04ah,098h	; 4bda  ..i..L.2Q..O.sJ.
	defb 0cdh,0a0h,04fh,0cdh,022h,051h,0cdh,0d6h,050h,0cdh,0afh,04ch,0cdh,032h,051h,0c3h	; 4bea  ..O."Q..P..L.2Q.
	defb 0f3h,04fh	; 4bfa

; ======================================================================
; CODIGO 0x4bfc..0x4c4f  (83 bytes)
; ======================================================================


L_4BFC:
	ld (0984ah),sp		;4bfc
	call L_4FA0		;4c00
	call L_5112		;4c03
	call L_50D6		;4c06
	ld hl,03380h		;4c09
	call L_5105		;4c0c
	call L_4D1F		;4c0f
	ld hl,00002h		;4c12
	call L_5142		;4c15
	ld hl,(08000h)		;4c18
	ld (0984ch),hl		;4c1b
	ld sp,09b80h		;4c1e
	ld hl,00000h		;4c21
	call L_5105		;4c24
	call L_4CC4		;4c27
	ld sp,(0984ch)		;4c2a
	call 06534h		;4c2e
	call 0656ch		;4c31
	jp L_4FF3		;4c34
L_4C37:
	ld (0984ah),sp		;4c37
	call L_4FA0		;4c3b
	call L_5112		;4c3e
	call L_50D6		;4c41
	call L_4D1F		;4c44
	jp z,L_4FF3		;4c47
	call L_4FF3		;4c4a
	scf			;4c4d
	ret			;4c4e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4c4f..0x4c78  (41 bytes)
DATA_4C4F:
	defb 0edh,073h,04ah,098h,0cdh,0a0h,04fh,0cdh,012h,051h,0cdh,0d6h,050h,0cdh,0e0h,04ch	; 4c4f  .sJ...O..Q..P..L
	defb 0cdh,00bh,069h,0c3h,0f3h,04fh,0edh,073h,04ah,098h,0cdh,0a0h,04fh,0cdh,012h,051h	; 4c5f  ..i..O.sJ...O..Q
	defb 0cdh,0d6h,050h,0cdh,0eeh,04ch,0c3h,0f3h,04fh	; 4c6f  ..P..L..O

; ======================================================================
; CODIGO 0x4c78..0x4ca1  (41 bytes)
; ======================================================================


L_4C78:
	ld hl,0ac80h		;4c78
	ld b,067h		;4c7b
L_4C7D:
	push hl			;4c7d
	push bc			;4c7e
	ld bc,00080h		;4c7f
	call L_4C8E		;4c82
	pop bc			;4c85
	pop hl			;4c86
	ld de,00080h		;4c87
	add hl,de			;4c8a
	djnz L_4C7D		;4c8b
	ret			;4c8d
L_4C8E:
	push bc			;4c8e
	ld de,08000h		;4c8f
	ldir		;4c92
	ld de,08000h		;4c94
	ld c,01ah		;4c97
	call 0f37dh		;4c99
	pop hl			;4c9c
	call L_5152		;4c9d
	ret			;4ca0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4ca1..0x4cc4  (35 bytes)
DATA_4CA1:
	defb 011h,039h,092h,00eh,01ah,0cdh,07dh,0f3h,021h,095h,000h,0c3h,052h,051h,02ah,00ch	; 4ca1  .9....}.!...RQ*.
	defb 0dfh,001h,080h,013h,0a7h,0edh,042h,0ebh,00eh,01ah,0cdh,07dh,0f3h,021h,003h,000h	; 4cb1  ......B....}.!..
	defb 0c3h,052h,051h	; 4cc1

; ======================================================================
; CODIGO 0x4cc4..0x4ce0  (28 bytes)
; ======================================================================


L_4CC4:
	ld de,0ac80h		;4cc4
	ld b,067h		;4cc7
L_4CC9:
	push bc			;4cc9
	push de			;4cca
	ld c,01ah		;4ccb
	call 0f37dh		;4ccd
	ld hl,00080h		;4cd0
	call L_5142		;4cd3
	pop de			;4cd6
	ld hl,00080h		;4cd7
	add hl,de			;4cda
	ex de,hl			;4cdb
	pop bc			;4cdc
	djnz L_4CC9		;4cdd
	ret			;4cdf

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4ce0..0x4d1f  (63 bytes)
DATA_4CE0:
	defb 011h,039h,092h,00eh,01ah,0cdh,07dh,0f3h,021h,095h,000h,0c3h,042h,051h,02ah,00ch	; 4ce0  .9....}.!...BQ*.
	defb 0dfh,001h,080h,013h,0a7h,0edh,042h,0ebh,00eh,01ah,0cdh,07dh,0f3h,021h,003h,000h	; 4cf0  ......B....}.!..
	defb 0c3h,042h,051h,011h,000h,080h,00eh,01ah,0cdh,07dh,0f3h,021h,000h,010h,0c3h,052h	; 4d00  .BQ......}.!...R
	defb 051h,011h,000h,080h,00eh,01ah,0cdh,07dh,0f3h,021h,000h,010h,0c3h,042h,051h	; 4d10  Q......}.!...BQ

; ======================================================================
; CODIGO 0x4d1f..0x5095  (886 bytes)
; ======================================================================


L_4D1F:
	call L_4D83		;4d1f
	ret nz			;4d22
	ld a,(0dda3h)		;4d23
	and a			;4d26
	ld c,000h		;4d27
	jr nz,L_4D2D		;4d29
	ld c,040h		;4d2b
L_4D2D:
	ld hl,0faf6h		;4d2d
	ld a,(hl)			;4d30
	push af			;4d31
	ld (hl),000h		;4d32
	call L_4D58		;4d34
	ld a,(0dda3h)		;4d37
	cp 002h		;4d3a
	jr nz,L_4D52		;4d3c
	ld a,(0fcafh)		;4d3e
	sub 005h		;4d41
	and 002h		;4d43
	ld a,001h		;4d45
	jr nz,L_4D4A		;4d47
	inc a			;4d49
L_4D4A:
	ld (0faf6h),a		;4d4a
	ld c,000h		;4d4d
	call L_4D58		;4d4f
L_4D52:
	pop af			;4d52
	ld (0faf6h),a		;4d53
	xor a			;4d56
	ret			;4d57
L_4D58:
	ld de,00000h		;4d58
L_4D5B:
	push bc			;4d5b
	push de			;4d5c
	call L_518A		;4d5d
	push hl			;4d60
	ld de,08000h		;4d61
	ld c,01ah		;4d64
	call 0f37dh		;4d66
	pop hl			;4d69
	call L_5142		;4d6a
	pop de			;4d6d
	ld hl,08000h		;4d6e
	push de			;4d71
	call 0733ah		;4d72
	pop de			;4d75
	ld hl,00080h		;4d76
	add hl,de			;4d79
	ex de,hl			;4d7a
	pop bc			;4d7b
	ld h,c			;4d7c
	ld l,000h		;4d7d
	rst 20h			;4d7f
	jr nz,L_4D5B		;4d80
	ret			;4d82
L_4D83:
	ld de,08000h		;4d83
	ld c,01ah		;4d86
	call 0f37dh		;4d88
	ld hl,00001h		;4d8b
	call L_5142		;4d8e
	ld a,(08000h)		;4d91
	ld (0dda3h),a		;4d94
	and a			;4d97
	jr z,L_4DDC		;4d98
	ld a,(0002dh)		;4d9a
	and a			;4d9d
	jr z,L_4DD9		;4d9e
	ld de,08000h		;4da0
	ld c,01ah		;4da3
	call 0f37dh		;4da5
	ld hl,0003ah		;4da8
	call L_5142		;4dab
	ld hl,08000h		;4dae
	ld e,018h		;4db1
	ld c,000h		;4db3
	call L_4DFE		;4db5
	ld de,(08018h)		;4db8
	ld hl,0801ah		;4dbc
	ld bc,00020h		;4dbf
	call 0005ch		;4dc2   ; BIOS LDIRVM - Block transfers to VRAM from memory
	xor a			;4dc5
	ld b,010h		;4dc6
	ld hl,0801ah		;4dc8
L_4DCB:
	ld d,(hl)			;4dcb
	inc hl			;4dcc
	ld e,(hl)			;4dcd
	inc hl			;4dce
	push af			;4dcf
	call 0725bh		;4dd0
	pop af			;4dd3
	inc a			;4dd4
	djnz L_4DCB		;4dd5
	xor a			;4dd7
	ret			;4dd8
L_4DD9:
	or 0ffh		;4dd9
	ret			;4ddb
L_4DDC:
	ld de,08000h		;4ddc
	ld c,01ah		;4ddf
	call 0f37dh		;4de1
	ld hl,00008h		;4de4
	call L_5142		;4de7
	ld hl,08000h		;4dea
	ld e,008h		;4ded
	ld c,000h		;4def
	call L_4DFE		;4df1
	ld a,(0002dh)		;4df4
	and a			;4df7
	ret z			;4df8
	call 07275h		;4df9
	xor a			;4dfc
	ret			;4dfd
L_4DFE:
	push bc			;4dfe
	ld b,(hl)			;4dff
	inc hl			;4e00
	call 00047h		;4e01   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;4e04
	inc c			;4e05
	dec e			;4e06
	jr nz,L_4DFE		;4e07
	ret			;4e09
L_4E0A:
	call L_4E6F		;4e0a
	ld a,(0dd9dh)		;4e0d
	and a			;4e10
	ld c,000h		;4e11
	jr nz,L_4E17		;4e13
	ld c,040h		;4e15
L_4E17:
	ld hl,0faf6h		;4e17
	ld a,(hl)			;4e1a
	push af			;4e1b
	ld (hl),000h		;4e1c
	call L_4E41		;4e1e
	ld a,(0dd9dh)		;4e21
	cp 002h		;4e24
	jr nz,L_4E3C		;4e26
	ld a,(0fcafh)		;4e28
	sub 005h		;4e2b
	and 002h		;4e2d
	ld a,001h		;4e2f
	jr nz,L_4E34		;4e31
	inc a			;4e33
L_4E34:
	ld (0faf6h),a		;4e34
	ld c,000h		;4e37
	call L_4E41		;4e39
L_4E3C:
	pop af			;4e3c
	ld (0faf6h),a		;4e3d
	ret			;4e40
L_4E41:
	ld hl,00000h		;4e41
L_4E44:
	push bc			;4e44
	push hl			;4e45
	ld de,08802h		;4e46
	ld bc,00080h		;4e49
	call 00059h		;4e4c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call 07707h		;4e4f
	ld de,08000h		;4e52
	ld c,01ah		;4e55
	call 0f37dh		;4e57
	ld hl,(08000h)		;4e5a
	inc hl			;4e5d
	inc hl			;4e5e
	call L_5152		;4e5f
	pop hl			;4e62
	pop bc			;4e63
	ld de,00080h		;4e64
	add hl,de			;4e67
	ld d,c			;4e68
	ld e,000h		;4e69
	rst 20h			;4e6b
	jr nz,L_4E44		;4e6c
	ret			;4e6e
L_4E6F:
	ld a,(0002dh)		;4e6f
	and a			;4e72
	jr z,L_4EBC		;4e73
	ld a,(0dd9ch)		;4e75
	and a			;4e78
	jr z,L_4EBC		;4e79
	ld a,(0dd9dh)		;4e7b
	ld de,08000h		;4e7e
	ld (de),a			;4e81
	inc de			;4e82
	ld hl,0f3dfh		;4e83
	ld bc,00008h		;4e86
	ldir		;4e89
	ld hl,0ffe7h		;4e8b
	ld bc,00010h		;4e8e
	ldir		;4e91
	ld hl,(0dd98h)		;4e93
	ex de,hl			;4e96
	ld (hl),e			;4e97
	inc hl			;4e98
	ld (hl),d			;4e99
	inc hl			;4e9a
	ex de,hl			;4e9b
	ld bc,00020h		;4e9c
	push de			;4e9f
	ld de,0f680h		;4ea0
	rst 20h			;4ea3
	pop de			;4ea4
	jr z,L_4EAB		;4ea5
	ldir		;4ea7
	jr L_4EAE		;4ea9
L_4EAB:
	call 00059h		;4eab   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_4EAE:
	ld de,08000h		;4eae
	ld c,01ah		;4eb1
	call 0f37dh		;4eb3
	ld hl,0003bh		;4eb6
	jp L_5152		;4eb9
L_4EBC:
	ld de,08000h		;4ebc
	ld c,01ah		;4ebf
	call 0f37dh		;4ec1
	xor a			;4ec4
	ld de,08000h		;4ec5
	ld (de),a			;4ec8
	inc de			;4ec9
	ld hl,0f3dfh		;4eca
	ld bc,00009h		;4ecd
	ldir		;4ed0
	ld hl,00009h		;4ed2
	jp L_5152		;4ed5
L_4ED8:
	ld a,(0f3dfh)		;4ed8
	and 00eh		;4edb
	ld l,a			;4edd
	ld a,(0f3e0h)		;4ede
	and 018h		;4ee1
	ld h,a			;4ee3
	ld de,00002h		;4ee4
	rst 20h			;4ee7
	jr z,L_4F3C		;4ee8
	ld a,0feh		;4eea
	call L_5167		;4eec
	ld hl,00000h		;4eef
	call L_5181		;4ef2
	ld hl,08000h		;4ef5
	call L_5181		;4ef8
	ld hl,00000h		;4efb
	call L_5181		;4efe
	ld hl,00000h		;4f01
	ld b,074h		;4f04
L_4F06:
	push bc			;4f06
	call L_4F84		;4f07
	pop bc			;4f0a
	djnz L_4F06		;4f0b
	ld hl,0f400h		;4f0d
	ld bc,00005h		;4f10
L_4F13:
	push bc			;4f13
	ld bc,00080h		;4f14
	call L_4F87		;4f17
	pop bc			;4f1a
	djnz L_4F13		;4f1b
	ld hl,0f680h		;4f1d
	ld bc,00020h		;4f20
	call L_4F87		;4f23
	ld hl,036a0h		;4f26
	ld bc,00160h		;4f29
	call L_4F87		;4f2c
	ld hl,0f800h		;4f2f
	ld b,008h		;4f32
L_4F34:
	push bc			;4f34
	call L_4F84		;4f35
	pop bc			;4f38
	djnz L_4F34		;4f39
	ret			;4f3b
L_4F3C:
	ld a,0feh		;4f3c
	call L_5167		;4f3e
	ld hl,00000h		;4f41
	call L_5181		;4f44
	ld hl,03fffh		;4f47
	call L_5181		;4f4a
	ld hl,00000h		;4f4d
	call L_5181		;4f50
	ld hl,02000h		;4f53
	ld b,018h		;4f56
L_4F58:
	push bc			;4f58
	call L_4F84		;4f59
	pop bc			;4f5c
	djnz L_4F58		;4f5d
	ld hl,03800h		;4f5f
	ld b,008h		;4f62
L_4F64:
	push bc			;4f64
	call L_4F84		;4f65
	pop bc			;4f68
	djnz L_4F64		;4f69
	ld hl,00000h		;4f6b
	ld b,018h		;4f6e
L_4F70:
	push bc			;4f70
	call L_4F84		;4f71
	pop bc			;4f74
	djnz L_4F70		;4f75
	ld hl,01800h		;4f77
	ld b,008h		;4f7a
L_4F7C:
	push bc			;4f7c
	call L_4F84		;4f7d
	pop bc			;4f80
	djnz L_4F7C		;4f81
	ret			;4f83
L_4F84:
	ld bc,00100h		;4f84
L_4F87:
	push hl			;4f87
	push bc			;4f88
	ld de,08000h		;4f89
	call 00059h		;4f8c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,08000h		;4f8f
	ld c,01ah		;4f92
	call 0f37dh		;4f94
	pop hl			;4f97
	push hl			;4f98
	call L_5152		;4f99
	pop bc			;4f9c
	pop hl			;4f9d
	add hl,bc			;4f9e
	ret			;4f9f
L_4FA0:
	di			;4fa0
	ld a,(0f2a0h)		;4fa1
	ld h,080h		;4fa4
	call 00024h		;4fa6   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f11bh)		;4fa9
	and a			;4fac
	ld hl,0fd9fh		;4fad
	jr z,L_4FB5		;4fb0
	ld hl,0fd9ah		;4fb2
L_4FB5:
	ld a,(hl)			;4fb5
	ld (0984eh),a		;4fb6
	ld (hl),0c9h		;4fb9
	ld hl,0c000h		;4fbb
	ld de,0ac80h		;4fbe
	ld bc,03380h		;4fc1
	ldir		;4fc4
	ld hl,09b80h		;4fc6
	ld de,0e280h		;4fc9
	ld bc,01100h		;4fcc
	ldir		;4fcf
	ld a,(0dd9eh)		;4fd1
	and a			;4fd4
	jr z,L_4FE2		;4fd5
	ld hl,0ac80h		;4fd7
	ld de,0e280h		;4fda
	ld bc,01100h		;4fdd
	ldir		;4fe0
L_4FE2:
	ld hl,00000h		;4fe2
	ld (0f1c0h),hl		;4fe5
	ld hl,00000h		;4fe8
	add hl,sp			;4feb
	ld de,0ec80h		;4fec
	add hl,de			;4fef
	ld sp,hl			;4ff0
	ei			;4ff1
	ret			;4ff2
L_4FF3:
	di			;4ff3
	ld bc,00200h		;4ff4
L_4FF7:
	push bc			;4ff7
	call 0df61h		;4ff8
	pop bc			;4ffb
	dec bc			;4ffc
	ld a,b			;4ffd
	or c			;4ffe
	jr nz,L_4FF7		;4fff
	di			;5001
	ld hl,0e280h		;5002
	ld de,09b80h		;5005
	ld bc,01100h		;5008
	ldir		;500b
	ld hl,0dfffh		;500d
	ld de,0f37fh		;5010
	ld bc,03380h		;5013
	lddr		;5016
	ld a,(0f11eh)		;5018
	and a			;501b
	jr z,L_5029		;501c
	ld hl,09b80h		;501e
	ld de,0c000h		;5021
	ld bc,01100h		;5024
	ldir		;5027
L_5029:
	ld a,(0f11bh)		;5029
	and a			;502c
	ld hl,0fd9fh		;502d
	jr z,L_5035		;5030
	ld hl,0fd9ah		;5032
L_5035:
	ld a,(0984eh)		;5035
	ld (hl),a			;5038
	ld hl,00000h		;5039
	add hl,sp			;503c
	ld de,01380h		;503d
	add hl,de			;5040
	ld sp,hl			;5041
	ei			;5042
	ret			;5043
L_5044:
	xor a			;5044
	call 0750eh		;5045
	ld a,(0922ch)		;5048
	or a			;504b
	ret z			;504c
	ld hl,09823h		;504d
	ld (09848h),hl		;5050
	ld d,h			;5053
	ld e,l			;5054
	ld (hl),020h		;5055
	inc de			;5057
	ld bc,00008h		;5058
	ldir		;505b
	xor a			;505d
	ld (de),a			;505e
	inc hl			;505f
	inc de			;5060
	ld bc,0001bh		;5061
	ldir		;5064
	ld de,09823h		;5066
	ld (de),a			;5069
	inc de			;506a
	ld a,(0922ch)		;506b
	ld c,a			;506e
	ld b,000h		;506f
	ld hl,0920bh		;5071
	ldir		;5074
	call L_507D		;5076
	ld a,0ffh		;5079
	or a			;507b
	ret			;507c
L_507D:
	ld de,0982ch		;507d
	ld hl,05095h		;5080
	ld a,(0f10bh)		;5083
	and 00fh		;5086
	call 07251h		;5088
	ldi		;508b
	ld a,(0f281h)		;508d
	ex de,hl			;5090
	call L_5099		;5091
	ret			;5094

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5095..0x5099  (4 bytes)
DATA_5095:
	defb 048h,053h,047h,052h	; 5095

; ======================================================================
; CODIGO 0x5099..0x50bf  (38 bytes)
; ======================================================================


L_5099:
	ld d,a			;5099
	and 0f0h		;509a
	rrca			;509c
	rrca			;509d
	rrca			;509e
	rrca			;509f
	or 030h		;50a0
	ld (hl),a			;50a2
	inc hl			;50a3
	ld a,d			;50a4
	and 00fh		;50a5
	or 030h		;50a7
	ld (hl),a			;50a9
	ret			;50aa
L_50AB:
	ld hl,0982fh		;50ab
	ld de,09830h		;50ae
	ld (hl),000h		;50b1
	ld bc,00018h		;50b3
	ldir		;50b6
	ret			;50b8
L_50B9:
	ld a,(0ffa7h)		;50b9
	cp 0c9h		;50bc
	ret			;50be

; ----------------------------------------------------------------------
; DATOS sin identificar  0x50bf..0x50d6  (23 bytes)
DATA_50BF:
	defb 0edh,053h,048h,098h,0afh,012h,013h,001h,00bh,000h,0edh,0b0h,0afh,006h,019h,012h	; 50bf  .SH.............
	defb 013h,010h,0fch,0c9h,022h,048h,098h	; 50cf

; ======================================================================
; CODIGO 0x50d6..0x50f3  (29 bytes)
; ======================================================================


L_50D6:
	ld hl,(09848h)		;50d6
	ld bc,0000ch		;50d9
	add hl,bc			;50dc
	ld (hl),b			;50dd
	inc hl			;50de
	ld (hl),b			;50df
	inc hl			;50e0
	ld bc,00001h		;50e1
	ld (hl),c			;50e4
	inc hl			;50e5
	ld (hl),b			;50e6
	ld bc,00011h		;50e7
	add hl,bc			;50ea
	ld b,005h		;50eb
	xor a			;50ed
L_50EE:
	ld (hl),a			;50ee
	inc hl			;50ef
	djnz L_50EE		;50f0
	ret			;50f2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x50f3..0x5105  (18 bytes)
DATA_50F3:
	defb 02ah,048h,098h,001h,010h,000h,009h,07eh,023h,066h,06fh,0c9h,0edh,053h,048h,098h	; 50f3  *H.....~#fo..SH.
	defb 018h,004h	; 5103

; ======================================================================
; CODIGO 0x5105..0x51c3  (190 bytes)
; ======================================================================


L_5105:
	ld de,(09848h)		;5105
	ex de,hl			;5109
	ld bc,00021h		;510a
	add hl,bc			;510d
	ld (hl),e			;510e
	inc hl			;510f
	ld (hl),d			;5110
	ret			;5111
L_5112:
	ld de,(09848h)		;5112
	ld c,00fh		;5116
	call 0f37dh		;5118
	ld c,000h		;511b
	inc a			;511d
	jp z,L_5195		;511e
	ret			;5121
L_5122:
	ld de,(09848h)		;5122
	ld c,016h		;5126
	call 0f37dh		;5128
	ld c,001h		;512b
	inc a			;512d
	jp z,L_5195		;512e
	ret			;5131
L_5132:
	ld de,(09848h)		;5132
	ld c,010h		;5136
	call 0f37dh		;5138
	ld c,002h		;513b
	inc a			;513d
	jp z,L_5195		;513e
	ret			;5141
L_5142:
	ld de,(09848h)		;5142
	ld c,027h		;5146
	call 0f37dh		;5148
	ld c,003h		;514b
	or a			;514d
	jp nz,L_5195		;514e
	ret			;5151
L_5152:
	ld de,(09848h)		;5152
	ld c,026h		;5156
	call 0f37dh		;5158
	ld c,004h		;515b
	or a			;515d
	jp nz,L_5195		;515e
	ret			;5161
L_5162:
	ld bc,L_5142		;5162
	jr L_516A		;5165
L_5167:
	ld bc,L_5152		;5167
L_516A:
	push af			;516a
	ld hl,00001h		;516b
	add hl,sp			;516e
	push bc			;516f
	ex de,hl			;5170
	ld c,01ah		;5171
	call 0f37dh		;5173
	pop bc			;5176
	call L_517C		;5177
	pop af			;517a
	ret			;517b
L_517C:
	ld hl,00001h		;517c
	push bc			;517f
	ret			;5180
L_5181:
	push hl			;5181
	ld a,l			;5182
	call L_5167		;5183
	pop hl			;5186
	ld a,h			;5187
	jr L_5167		;5188
L_518A:
	call L_5162		;518a
	ld l,a			;518d
	push hl			;518e
	call L_5162		;518f
	pop hl			;5192
	ld h,a			;5193
	ret			;5194
L_5195:
	push bc			;5195
	call L_4FF3		;5196
	call 07499h		;5199
	call L_5CFE		;519c
	call L_5D56		;519f
	call L_5C2A		;51a2
	ld hl,051c3h		;51a5
	ld de,(09237h)		;51a8
	push de			;51ac
	call 0738bh		;51ad
	pop hl			;51b0
	ld bc,00040h		;51b1
	add hl,bc			;51b4
	ex de,hl			;51b5
	pop bc			;51b6
	call L_51D2		;51b7
	call 074bah		;51ba
	ld sp,(0984ah)		;51bd
	scf			;51c1
	ret			;51c2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x51c3..0x51d2  (15 bytes)
DATA_51C3:
	defb 040h,040h,044h,049h,053h,04bh,000h,045h,052h,052h,04fh,052h,040h,040h,0ffh	; 51c3  @@DISK.ERROR@@.

; ======================================================================
; CODIGO 0x51d2..0x51fa  (40 bytes)
; ======================================================================


L_51D2:
	ld a,c			;51d2
	add a,a			;51d3
	ld hl,05209h		;51d4
	call 07251h		;51d7
	ld a,(hl)			;51da
	inc hl			;51db
	ld h,(hl)			;51dc
	ld l,a			;51dd
	push de			;51de
	call 0738bh		;51df
	pop hl			;51e2
	ld bc,00040h		;51e3
	add hl,bc			;51e6
	ld de,051fah		;51e7
	ex de,hl			;51ea
	call 0738bh		;51eb
	call 00156h		;51ee   ; BIOS KILBUF - Clears keyboard buffer
L_51F1:
	ld a,007h		;51f1
	call 00141h		;51f3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rla			;51f6
	jr c,L_51F1		;51f7
	ret			;51f9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x51fa..0x5265  (107 bytes)
DATA_51FA:
	defb 048h,049h,054h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh,045h,059h,0ffh,015h	; 51fa  HIT.RETURN.KEY..
	defb 052h,026h,052h,037h,052h,043h,052h,037h,052h,055h,052h,03dh,046h,049h,04ch,045h	; 520a  R&R7RCR7RUR=FILE
	defb 000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h,03dh,0ffh,03dh,054h,04fh,04fh	; 521a  .NOT.FOUND=.=TOO
	defb 000h,04dh,041h,04eh,059h,000h,046h,049h,04ch,045h,053h,03dh,0ffh,03dh,044h,049h	; 522a  .MANY.FILES=.=DI
	defb 053h,04bh,000h,046h,055h,04ch,04ch,03dh,0ffh,03dh,044h,049h,053h,04bh,000h,052h	; 523a  SK.FULL=.=DISK.R
	defb 045h,041h,044h,000h,045h,052h,052h,04fh,052h,03dh,0ffh,03dh,044h,049h,053h,04bh	; 524a  EAD.ERROR=.=DISK
	defb 000h,049h,04fh,000h,045h,052h,052h,04fh,052h,03dh,0ffh	; 525a  .IO.ERROR=.

; ======================================================================
; CODIGO 0x5265..0x5294  (47 bytes)
; ======================================================================


L_5265:
	ex de,hl			;5265
	ld hl,09803h		;5266
	push hl			;5269
	ld (09801h),hl		;526a
	ld hl,09801h		;526d
	ld (0ac23h),hl		;5270
	ld a,(0f11eh)		;5273
	and a			;5276
	jr z,L_527C		;5277
	ld (0d0a3h),hl		;5279
L_527C:
	pop hl			;527c
	push de			;527d
	ld de,05294h		;527e
	ld bc,0000dh		;5281
	ex de,hl			;5284
	ldir		;5285
	ld hl,09808h		;5287
	ld a,(0f103h)		;528a
	ld (hl),a			;528d
	inc hl			;528e
	pop de			;528f
	ld (hl),e			;5290
	inc hl			;5291
	ld (hl),d			;5292
	ret			;5293

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5294..0x5393  (255 bytes)
DATA_5294:
	defb 0fdh,0e5h,0ddh,0e5h,0f7h,000h,000h,000h,0ddh,0e1h,0fdh,0e1h,0c9h,0c5h,0cdh,0f3h	; 5294  ................
	defb 04fh,0cdh,099h,074h,0c1h,0cdh,0d1h,052h,0f5h,0cdh,0bah,074h,0f1h,0dah,0bdh,051h	; 52a4  O..t...R...t...Q
	defb 0cdh,0a0h,04fh,00eh,001h,0c9h,0c5h,0cdh,0f3h,04fh,0c1h,0cdh,0d1h,052h,0dah,0bdh	; 52b4  ..O......O...R..
	defb 051h,0cdh,08fh,074h,0cdh,030h,05bh,0cdh,0a0h,04fh,00eh,001h,0c9h,0c5h,0cdh,0feh	; 52c4  Q..t.0[..O......
	defb 05ch,0cdh,056h,05dh,0cdh,02ah,05ch,021h,0c3h,051h,0edh,05bh,037h,092h,0cdh,08bh	; 52d4  \.V].*\!.Q.[7...
	defb 073h,0c1h,079h,0e6h,00eh,00fh,0feh,002h,038h,006h,0feh,006h,038h,049h,018h,006h	; 52e4  s.y.....8...8I..
	defb 021h,04dh,053h,00fh,030h,003h,021h,05eh,053h,0ebh,02ah,037h,092h,001h,040h,000h	; 52f4  !MS.0.!^S.*7..@.
	defb 009h,006h,011h,0e5h,01ah,0cdh,046h,076h,013h,023h,010h,0f8h,0e1h,001h,040h,000h	; 5304  ......Fv.#....@.
	defb 009h,0ebh,021h,06fh,053h,0d5h,0cdh,08bh,073h,0e1h,001h,020h,000h,009h,011h,081h	; 5314  ..!oS...s.. ....
	defb 053h,0ebh,0cdh,08bh,073h,0cdh,056h,001h,0cdh,09fh,000h,0feh,00dh,028h,006h,0feh	; 5324  S...s.V......(..
	defb 020h,028h,011h,018h,0f3h,0a7h,0c9h,02ah,037h,092h,001h,040h,000h,009h,0ebh,00eh	; 5334   (.....*7..@....
	defb 005h,0cdh,0d2h,051h,0cdh,08fh,074h,037h,0c9h,03dh,057h,052h,049h,054h,045h,000h	; 5344  ...Q..t7.=WRITE.
	defb 050h,052h,04fh,054h,045h,043h,054h,045h,044h,03dh,03dh,044h,049h,053h,04bh,000h	; 5354  PROTECTED==DISK.
	defb 04fh,046h,046h,04ch,049h,04eh,045h,03dh,000h,000h,000h,052h,045h,054h,055h,052h	; 5364  OFFLINE=...RETUR
	defb 04eh,000h,04bh,045h,059h,040h,040h,052h,045h,054h,052h,059h,0ffh,053h,050h,041h	; 5374  N.KEY@@RETRY.SPA
	defb 043h,045h,000h,04bh,045h,059h,000h,040h,040h,041h,042h,04fh,052h,054h,0ffh	; 5384  CE.KEY.@@ABORT.

; ======================================================================
; CODIGO 0x5393..0x546e  (219 bytes)
; ======================================================================


L_5393:
	xor a			;5393
	ld (0922ch),a		;5394
	ld (0922eh),a		;5397
	ld hl,03a6ch		;539a
	ld (09231h),hl		;539d
	ld (09233h),hl		;53a0
	ld a,080h		;53a3
	ld (0922dh),a		;53a5
L_53A8:
	call 07600h		;53a8
	ld (0984ah),sp		;53ab
	call L_54D3		;53af
	call L_54FD		;53b2
	jp z,L_544A		;53b5
	call L_5B30		;53b8
	call 07633h		;53bb
L_53BE:
	call L_5485		;53be
	call 00156h		;53c1   ; BIOS KILBUF - Clears keyboard buffer
L_53C4:
	ld hl,0922ch		;53c4
	ld de,0922eh		;53c7
	call 0009fh		;53ca   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;53cd
	jr z,L_543A		;53cf
	cp 01fh		;53d1
	jr z,L_5402		;53d3
	cp 020h		;53d5
	jr nz,L_53C4		;53d7
	ld a,(0922ch)		;53d9
	ld hl,09100h		;53dc
	cp (hl)			;53df
	ccf			;53e0
	ret c			;53e1
	call L_5565		;53e2
	push hl			;53e5
	call L_54E0		;53e6
	pop hl			;53e9
	ld de,09823h		;53ea
	ld (09848h),de		;53ed
	inc de			;53f1
	ld a,(092cfh)		;53f2
	cp 001h		;53f5
	ld bc,00008h		;53f7
	jr nz,L_53FE		;53fa
	ld c,00bh		;53fc
L_53FE:
	ldir		;53fe
	or a			;5400
	ret			;5401
L_5402:
	ld a,(09100h)		;5402
	cp (hl)			;5405
	jr z,L_53C4		;5406
	inc (hl)			;5408
	ld a,(de)			;5409
	ld b,a			;540a
	ld a,(hl)			;540b
	sub b			;540c
	cp 003h		;540d
	jr c,L_5419		;540f
	inc b			;5411
	ld a,b			;5412
	ld (de),a			;5413
	ld bc,00000h		;5414
	jr L_541C		;5417
L_5419:
	ld bc,00020h		;5419
L_541C:
	call 07642h		;541c
	add hl,bc			;541f
	push hl			;5420
	ld de,(09233h)		;5421
	and a			;5425
	sbc hl,de		;5426
	ld a,(0922dh)		;5428
	ld d,000h		;542b
	ld e,a			;542d
	rst 20h			;542e
	pop hl			;542f
	jr nc,L_5435		;5430
	ld (09231h),hl		;5432
L_5435:
	call 07633h		;5435
	jr L_53BE		;5438
L_543A:
	ld a,(hl)			;543a
	or a			;543b
	jr z,L_53C4		;543c
	dec (hl)			;543e
	ex de,hl			;543f
	ld a,(de)			;5440
	cp (hl)			;5441
	jr nc,L_5445		;5442
	dec (hl)			;5444
L_5445:
	ld bc,0ffe0h		;5445
	jr L_541C		;5448
L_544A:
	ld hl,0546eh		;544a
	ld de,(09233h)		;544d
	call 0738bh		;5451
	ld de,05476h		;5454
	ld hl,(09233h)		;5457
	ld bc,00040h		;545a
	add hl,bc			;545d
	ex de,hl			;545e
	call 0738bh		;545f
	call 00156h		;5462   ; BIOS KILBUF - Clears keyboard buffer
L_5465:
	call 0009fh		;5465   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;5468
	jr nz,L_5465		;546a
	scf			;546c
	ret			;546d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x546e..0x5485  (23 bytes)
DATA_546E:
	defb 04eh,04fh,000h,046h,049h,04ch,045h,0ffh,048h,049h,054h,000h,052h,045h,054h,055h	; 546e  NO.FILE.HIT.RETU
	defb 052h,04eh,000h,04bh,045h,059h,0ffh	; 547e

; ======================================================================
; CODIGO 0x5485..0x5545  (192 bytes)
; ======================================================================


L_5485:
	ld a,(0922eh)		;5485
	call L_5565		;5488
	ld de,(09233h)		;548b
	inc de			;548f
	inc de			;5490
	ex de,hl			;5491
	ld b,003h		;5492
L_5494:
	push bc			;5494
	push hl			;5495
	push hl			;5496
	xor a			;5497
	ld b,00ch		;5498
L_549A:
	call 07646h		;549a
	inc hl			;549d
	djnz L_549A		;549e
	pop hl			;54a0
	ld b,008h		;54a1
L_54A3:
	ld a,(de)			;54a3
	cp 020h		;54a4
	jr z,L_54AC		;54a6
	call 07646h		;54a8
	inc hl			;54ab
L_54AC:
	inc de			;54ac
	djnz L_54A3		;54ad
	ld a,(092cfh)		;54af
	cp 001h		;54b2
	jr nz,L_54CA		;54b4
	ld a,(de)			;54b6
	or a			;54b7
	jr z,L_54BC		;54b8
	ld a,03ch		;54ba
L_54BC:
	call 07646h		;54bc
	inc hl			;54bf
	ld b,003h		;54c0
L_54C2:
	ld a,(de)			;54c2
	call 07646h		;54c3
	inc de			;54c6
	inc hl			;54c7
	djnz L_54C2		;54c8
L_54CA:
	pop hl			;54ca
	ld bc,00020h		;54cb
	add hl,bc			;54ce
	pop bc			;54cf
	djnz L_5494		;54d0
	ret			;54d2
L_54D3:
	ld hl,09103h		;54d3
	ld de,09104h		;54d6
	ld (hl),000h		;54d9
	ld bc,00107h		;54db
	ldir		;54de
L_54E0:
	ld hl,09823h		;54e0
	ld de,09824h		;54e3
	ld (hl),000h		;54e6
	ld bc,00024h		;54e8
	ldir		;54eb
	ld hl,09824h		;54ed
	ld de,09825h		;54f0
	ld (hl),03fh		;54f3
	ld bc,0000ah		;54f5
	ldir		;54f8
	jp L_507D		;54fa
L_54FD:
	call L_4FA0		;54fd
	xor a			;5500
	ld (09100h),a		;5501
	ld de,09103h		;5504
	ld c,01ah		;5507
	call 0f37dh		;5509
	ld de,09823h		;550c
	ld c,011h		;550f
	call 0f37dh		;5511
	inc a			;5514
	jr z,L_5540		;5515
L_5517:
	ld hl,09100h		;5517
	inc (hl)			;551a
	push hl			;551b
	call L_5550		;551c
	pop hl			;551f
	ld a,(hl)			;5520
	cp 014h		;5521
	jr z,L_5530		;5523
	ld de,09823h		;5525
	ld c,012h		;5528
	call 0f37dh		;552a
	inc a			;552d
	jr nz,L_5517		;552e
L_5530:
	ld a,(09100h)		;5530
	push af			;5533
	ld de,05545h		;5534
	call L_5557		;5537
	call L_4FF3		;553a
	pop af			;553d
	or a			;553e
	ret			;553f
L_5540:
	call L_4FF3		;5540
	xor a			;5543
	ret			;5544

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5545..0x5550  (11 bytes)
DATA_5545:
	defb 040h,040h,045h,04eh,044h,040h,040h,000h,000h,000h,000h	; 5545  @@END@@....

; ======================================================================
; CODIGO 0x5550..0x56bd  (365 bytes)
; ======================================================================


L_5550:
	ld de,09104h		;5550
	ld a,(09100h)		;5553
	dec a			;5556
L_5557:
	call L_5565		;5557
	ex de,hl			;555a
	ld bc,00008h		;555b
	jr z,L_5562		;555e
	ld c,00bh		;5560
L_5562:
	ldir		;5562
	ret			;5564
L_5565:
	ld l,a			;5565
	ld h,000h		;5566
	ld a,(092cfh)		;5568
	cp 001h		;556b
	jr z,L_5574		;556d
	add hl,hl			;556f
	add hl,hl			;5570
	add hl,hl			;5571
	jr L_557D		;5572
L_5574:
	ld b,h			;5574
	ld c,l			;5575
	add hl,hl			;5576
	add hl,bc			;5577
	add hl,hl			;5578
	add hl,hl			;5579
	and a			;557a
	sbc hl,bc		;557b
L_557D:
	ld bc,09124h		;557d
	add hl,bc			;5580
	or a			;5581
	ret			;5582
L_5583:
	ld a,008h		;5583
	call 00141h		;5585   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;5588
	ret nc			;5589
	ld a,006h		;558a
	call 00141h		;558c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 2,a		;558f
	ret z			;5591
	di			;5592
	call L_5752		;5593
	ld (0f103h),a		;5596
	call L_577F		;5599
	ld a,(0f2a0h)		;559c
	ld h,080h		;559f
	push af			;55a1
	call 00024h		;55a2   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;55a5
	inc a			;55a6
	jp z,L_4A39		;55a7
	ld hl,08000h		;55aa
	ld de,08001h		;55ad
	ld bc,03fffh		;55b0
	ld (hl),000h		;55b3
	ldir		;55b5
	ld a,(0f103h)		;55b7
	ld (0d800h),a		;55ba
	ld a,(0f29fh)		;55bd
	ld (0d801h),a		;55c0
	ld a,(0f2a0h)		;55c3
	ld (0d802h),a		;55c6
	call L_5937		;55c9
	jr nc,L_55F5		;55cc
	jp L_59CC		;55ce
L_55D1:
	di			;55d1
	ld a,(0d802h)		;55d2
	ld h,080h		;55d5
	call 00024h		;55d7   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,0ffh		;55da
	ld (0f110h),a		;55dc
	ld hl,0e280h		;55df
	ld de,09b80h		;55e2
	ld bc,01100h		;55e5
	ldir		;55e8
	ld hl,0e280h		;55ea
	ld de,0c000h		;55ed
	ld bc,01100h		;55f0
	ldir		;55f3
L_55F5:
	di			;55f5
	ld sp,0f380h		;55f6
	ld hl,0f100h		;55f9
	ld de,0f101h		;55fc
	ld (hl),000h		;55ff
	ld bc,001f0h		;5601
	ldir		;5604
	ld hl,0fd9fh		;5606
	ld de,0f2e1h		;5609
	ld bc,00005h		;560c
	ldir		;560f
	ld a,0c9h		;5611
	ld (0fd9fh),a		;5613
L_5616:
	ld a,0ffh		;5616
	call 00132h		;5618   ; BIOS CHGCAP - Alternates the CAPS lamp status
	ld a,0ffh		;561b
	ld (0f110h),a		;561d
	call L_5752		;5620
	ld (0f103h),a		;5623
	call L_577F		;5626
	call L_5732		;5629
	call L_5824		;562c
	jp nc,L_565D		;562f
	ld hl,04002h		;5632
	call L_576B		;5635
	jp z,L_565D		;5638
	ex de,hl			;563b
	ld (0f107h),hl		;563c
L_563F:
	call 0632ah		;563f
	jp nz,L_565D		;5642
	call 06389h		;5645
	call 0709dh		;5648
	ld a,007h		;564b
	call 00141h		;564d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 004h		;5650
	jr z,L_5667		;5652
	ld hl,0f111h		;5654
	ld a,(hl)			;5657
	or a			;5658
	jr nz,L_5667		;5659
	dec a			;565b
	ld (hl),a			;565c
L_565D:
	xor a			;565d
	ld (092cfh),a		;565e
	ld (0f112h),a		;5661
	jp 06669h		;5664
L_5667:
	di			;5667
	ld de,(0f280h)		;5668
	ld a,d			;566c
	cp 0ffh		;566d
	jr z,L_565D		;566f
	ld d,e			;5671
	ld e,a			;5672
	ld hl,00743h		;5673
	rst 20h			;5676
	jp nc,L_49B3		;5677
	ld hl,00753h		;567a
	rst 20h			;567d
	jr nc,L_56A3		;567e
	ld hl,04028h		;5680
	call L_576B		;5683
	ld a,e			;5686
	cp 002h		;5687
	jr z,L_5690		;5689
	and a			;568b
	jr z,L_5696		;568c
	jr $+71		;568e
L_5690:
	ld a,(0002dh)		;5690
	and a			;5693
	jr nz,$+65		;5694
L_5696:
	ld hl,0402ah		;5696
	call L_576B		;5699
	ld a,d			;569c
	and a			;569d
	jp z,L_49B3		;569e
	jr $+52		;56a1
L_56A3:
	ld hl,056bdh		;56a3
L_56A6:
	ld c,(hl)			;56a6
	inc hl			;56a7
	ld b,(hl)			;56a8
	inc hl			;56a9
	ld a,b			;56aa
	cp 0ffh		;56ab
	jp z,L_49B3		;56ad
	call L_56B7		;56b0
	jr z,$+34		;56b3
	jr L_56A6		;56b5
L_56B7:
	ld a,d			;56b7
	sub b			;56b8
	ret nz			;56b9
	ld a,e			;56ba
	sub c			;56bb
	ret			;56bc

; ----------------------------------------------------------------------
; DATOS sin identificar  0x56bd..0x56d5  (24 bytes)
DATA_56BD:
	defb 044h,007h,045h,007h,047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh,0c3h,0b3h	; 56bd  D.E.G.H.P.S.....
	defb 049h,03ah,02dh,000h,0a7h,0cah,0b3h,049h	; 56cd  I:-....I

; ======================================================================
; CODIGO 0x56d5..0x5813  (318 bytes)
; ======================================================================


L_56D5:
	di			;56d5
	ld a,0ffh		;56d6
	ld (0f112h),a		;56d8
	xor a			;56db
	ld (0f29dh),a		;56dc
	ld (0f110h),a		;56df
	jp 0f15ah		;56e2
L_56E5:
	ld a,0c9h		;56e5
	ld (0fd9ah),a		;56e7
	ld (0fd9fh),a		;56ea
	call L_5752		;56ed
	ld (0f103h),a		;56f0
	call L_577F		;56f3
	call L_5732		;56f6
	ld a,(0f2a0h)		;56f9
	inc a			;56fc
	jp z,L_4A08		;56fd
	ld hl,0f100h		;5700
	ld de,0f101h		;5703
	ld (hl),000h		;5706
	ld bc,001f0h		;5708
	ldir		;570b
	ld hl,0d4f0h		;570d
	ld de,0f2e1h		;5710
	ld bc,00005h		;5713
	ldir		;5716
	di			;5718
	ld sp,0f380h		;5719
	ld a,(0f2a0h)		;571c
	ld h,080h		;571f
	call 00024h		;5721   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;5724
	ld de,09b80h		;5727
	ld bc,01100h		;572a
	ldir		;572d
	jp L_5616		;572f
L_5732:
	ld a,(0f103h)		;5732
	ld h,080h		;5735
	call 00024h		;5737   ; BIOS ENASLT - Switches to specified slot and page definitively
	xor a			;573a
	ld (04000h),a		;573b
	inc a			;573e
	ld (06000h),a		;573f
	inc a			;5742
	ld (08000h),a		;5743
	inc a			;5746
	ld (0a000h),a		;5747
	ld a,(0f2a0h)		;574a
	ld h,080h		;574d
	jp 00024h		;574f   ; BIOS ENASLT - Switches to specified slot and page definitively
L_5752:
	call 00138h		;5752   ; BIOS RSLREG - Reads the primary slot register
	rrca			;5755
	rrca			;5756
	and 003h		;5757
	ld c,a			;5759
	ld b,000h		;575a
	ld hl,0fcc1h		;575c
	add hl,bc			;575f
	or (hl)			;5760
	ld c,a			;5761
	inc hl			;5762
	inc hl			;5763
	inc hl			;5764
	inc hl			;5765
	ld a,(hl)			;5766
	and 00ch		;5767
	or c			;5769
	ret			;576a
L_576B:
	ld a,(0f104h)		;576b
	ld c,a			;576e
L_576F:
	call L_5773		;576f
	ld e,d			;5772
L_5773:
	ld a,c			;5773
	push bc			;5774
	push de			;5775
	call 0000ch		;5776   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;5779
	pop bc			;577a
	ld d,a			;577b
	or e			;577c
	inc hl			;577d
	ret			;577e
L_577F:
	ld hl,L_578D		;577f
	ld de,0e010h		;5782
	ld bc,00086h		;5785
	ldir		;5788
	jp 0e010h		;578a
L_578D:
	ld hl,04000h		;578d
	call 0e024h		;5790
	ld hl,08000h		;5793
	call 0e024h		;5796
	ld a,(0f103h)		;5799
	ld h,040h		;579c
	jp 00024h		;579e   ; BIOS ENASLT - Switches to specified slot and page definitively
L_57A1:
	ld (0e000h),hl		;57a1
	ld bc,00400h		;57a4
	ld hl,0fcc1h		;57a7
L_57AA:
	push bc			;57aa
	push hl			;57ab
	ld a,(hl)			;57ac
	bit 7,a		;57ad
	jr nz,L_57D5		;57af
	ld a,(0f103h)		;57b1
	cp c			;57b4
	jr z,L_57BB		;57b5
	ld a,c			;57b7
	call 0e075h		;57b8
L_57BB:
	pop hl			;57bb
	pop bc			;57bc
	jr c,L_57C5		;57bd
	inc hl			;57bf
	inc c			;57c0
	djnz L_57AA		;57c1
	ld a,0ffh		;57c3
L_57C5:
	ld c,a			;57c5
	ld hl,0f29fh		;57c6
	ld a,(0e001h)		;57c9
	cp 040h		;57cc
	jr z,L_57D3		;57ce
	ld hl,0f2a0h		;57d0
L_57D3:
	ld (hl),c			;57d3
	ret			;57d4
L_57D5:
	call 0e05dh		;57d5
	jr L_57BB		;57d8
L_57DA:
	and 080h		;57da
	or c			;57dc
	ld b,004h		;57dd
L_57DF:
	push bc			;57df
	ld b,a			;57e0
	ld a,(0f103h)		;57e1
	cp b			;57e4
	jr z,L_57EB		;57e5
	ld a,b			;57e7
	call 0e075h		;57e8
L_57EB:
	pop bc			;57eb
	ret c			;57ec
	add a,004h		;57ed
	djnz L_57DF		;57ef
	ret			;57f1
L_57F2:
	push af			;57f2
	ld hl,(0e000h)		;57f3
	call 00024h		;57f6   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld bc,04000h		;57f9
	ld hl,(0e000h)		;57fc
L_57FF:
	ld a,(hl)			;57ff
	cpl			;5800
	ld (hl),a			;5801
	cp (hl)			;5802
	cpl			;5803
	ld (hl),a			;5804
	jr nz,L_5810		;5805
	inc hl			;5807
	dec bc			;5808
	ld a,b			;5809
	or c			;580a
	jr nz,L_57FF		;580b
	pop af			;580d
	scf			;580e
	ret			;580f
L_5810:
	pop af			;5810
	and a			;5811
	ret			;5812

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5813..0x5824  (17 bytes)
DATA_5813:
	defb 0cdh,024h,058h,030h,008h,0edh,05bh,080h,0f2h,07bh,05ah,057h,0c9h,011h,0ffh,0ffh	; 5813  .$X0..[..{ZW....
	defb 0c9h	; 5823

; ======================================================================
; CODIGO 0x5824..0x59c3  (415 bytes)
; ======================================================================


L_5824:
	ld hl,L_5832		;5824
	ld de,0e000h		;5827
	ld bc,00105h		;582a
	ldir		;582d
	jp 0e000h		;582f
L_5832:
	ld bc,00400h		;5832
	ld hl,0fcc1h		;5835
L_5838:
	push bc			;5838
	push hl			;5839
	ld a,(hl)			;583a
	bit 7,a		;583b
	jr nz,L_585C		;583d
	ld b,c			;583f
	call 0e0f5h		;5840
	jr z,L_5849		;5843
	ld a,c			;5845
	call 0e046h		;5846
L_5849:
	pop hl			;5849
	pop bc			;584a
	jr c,L_5851		;584b
	inc hl			;584d
	inc c			;584e
	djnz L_5838		;584f
L_5851:
	push af			;5851
	ld a,(0f103h)		;5852
	ld h,040h		;5855
	call 00024h		;5857   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;585a
	ret			;585b
L_585C:
	call 0e02fh		;585c
	jr L_5849		;585f
L_5861:
	and 080h		;5861
	or c			;5863
	ld b,004h		;5864
L_5866:
	push bc			;5866
	ld b,a			;5867
	call 0e0f5h		;5868
	jr z,L_5871		;586b
	ld a,b			;586d
	call 0e046h		;586e
L_5871:
	pop bc			;5871
	ret c			;5872
	add a,004h		;5873
	djnz L_5866		;5875
	ret			;5877
L_5878:
	ld (0f104h),a		;5878
	ld h,040h		;587b
	call 00024h		;587d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(04000h)		;5880
	ld de,04241h		;5883
	rst 20h			;5886
	jr nz,L_58FC		;5887
	ld hl,(04002h)		;5889
	ld e,09fh		;588c
	call 0e065h		;588e
	ret c			;5891
	ld hl,(04002h)		;5892
	ld e,09ah		;5895
L_5897:
	ld bc,00100h		;5897
L_589A:
	ld a,e			;589a
	cpir		;589b
	jr nz,L_58FC		;589d
	jp po,0e0cah		;589f
	ld a,0fdh		;58a2
	cp (hl)			;58a4
	jr nz,L_589A		;58a5
	ld hl,(04010h)		;58a7
	ld de,04241h		;58aa
	rst 20h			;58ad
	jr z,L_591C		;58ae
	ld de,04443h		;58b0
	rst 20h			;58b3
	jr z,L_591C		;58b4
	ld de,04645h		;58b6
	rst 20h			;58b9
	jr z,L_591C		;58ba
	ld hl,(04011h)		;58bc
	ld a,(04013h)		;58bf
	ld h,a			;58c2
	rst 20h			;58c3
	jr z,L_5907		;58c4
	ld de,00000h		;58c6
	ld hl,05000h		;58c9
	ld b,000h		;58cc
L_58CE:
	ld a,(hl)			;58ce
	add a,e			;58cf
	ld e,a			;58d0
	jr nc,L_58D4		;58d1
	inc d			;58d3
L_58D4:
	inc hl			;58d4
	djnz L_58CE		;58d5
	push de			;58d7
	ld a,(0f103h)		;58d8
	ld h,040h		;58db
	call 00024h		;58dd   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop de			;58e0
	ld ix,044beh		;58e1
L_58E5:
	ld l,(ix+000h)		;58e5
	ld h,(ix+001h)		;58e8
	ld a,l			;58eb
	or h			;58ec
	jr z,L_58FC		;58ed
	rst 20h			;58ef
	jr z,L_5910		;58f0
	inc ix		;58f2
	inc ix		;58f4
	inc ix		;58f6
	inc ix		;58f8
	jr L_58E5		;58fa
L_58FC:
	ld hl,0ffffh		;58fc
	ld (0f280h),hl		;58ff
	ld a,(0f104h)		;5902
	and a			;5905
	ret			;5906
L_5907:
	ld hl,(04015h)		;5907
	ld a,(04017h)		;590a
	ld h,a			;590d
	jr L_591F		;590e
L_5910:
	ld l,(ix+002h)		;5910
	ld h,(ix+003h)		;5913
	ld e,(hl)			;5916
	inc hl			;5917
	ld d,(hl)			;5918
	ex de,hl			;5919
	jr L_591F		;591a
L_591C:
	ld hl,(04012h)		;591c
L_591F:
	ld (0f280h),hl		;591f
	ld a,(0f104h)		;5922
	scf			;5925
	ret			;5926
L_5927:
	ld a,(0f103h)		;5927
	bit 7,a		;592a
	jr nz,L_5935		;592c
	bit 7,b		;592e
	ret nz			;5930
	sub b			;5931
	and 003h		;5932
	ret			;5934
L_5935:
	cp b			;5935
	ret			;5936
L_5937:
	ld hl,L_5945		;5937
	ld de,0e000h		;593a
	ld bc,00087h		;593d
	ldir		;5940
	jp 0e000h		;5942
L_5945:
	ld bc,00400h		;5945
	ld hl,0fcc1h		;5948
L_594B:
	push bc			;594b
	push hl			;594c
	ld a,(hl)			;594d
	bit 7,a		;594e
	jr nz,L_596F		;5950
	ld b,c			;5952
	call 0e02fh		;5953
	jr z,L_595C		;5956
	ld a,c			;5958
	call 0e04bh		;5959
L_595C:
	pop hl			;595c
	pop bc			;595d
	jr c,L_5964		;595e
	inc hl			;5960
	inc c			;5961
	djnz L_594B		;5962
L_5964:
	push af			;5964
	ld a,(0f103h)		;5965
	ld h,040h		;5968
	call 00024h		;596a   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;596d
	ret			;596e
L_596F:
	call 0e034h		;596f
	jr L_595C		;5972
L_5974:
	ld a,(0f103h)		;5974
	cp b			;5977
	ret			;5978
L_5979:
	and 080h		;5979
	or c			;597b
	ld b,004h		;597c
L_597E:
	push bc			;597e
	ld b,a			;597f
	call 0e02fh		;5980
	jr z,L_5989		;5983
	ld a,b			;5985
	call 0e04bh		;5986
L_5989:
	pop bc			;5989
	ret c			;598a
	add a,004h		;598b
	djnz L_597E		;598d
	ret			;598f
L_5990:
	push af			;5990
	ld h,040h		;5991
	call 00024h		;5993   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,04000h		;5996
	ld de,0e07eh		;5999
	ld bc,04000h		;599c
L_599F:
	ld a,044h		;599f
	cpir		;59a1
	jr nz,L_59C0		;59a3
	jp po,0e07bh		;59a5
	push bc			;59a8
	push de			;59a9
	push hl			;59aa
	ld b,009h		;59ab
L_59AD:
	ld a,(de)			;59ad
	cp (hl)			;59ae
	jr nz,L_59B5		;59af
	inc hl			;59b1
	inc de			;59b2
	djnz L_59AD		;59b3
L_59B5:
	pop hl			;59b5
	pop de			;59b6
	pop bc			;59b7
	jr nz,L_599F		;59b8
	pop af			;59ba
	ld (09800h),a		;59bb
	scf			;59be
	ret			;59bf
L_59C0:
	pop af			;59c0
	and a			;59c1
	ret			;59c2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x59c3..0x59cc  (9 bytes)
DATA_59C3:
	defb 069h,073h,06bh,020h,042h,041h,053h,049h,043h	; 59c3  isk BASIC

; ======================================================================
; CODIGO 0x59cc..0x5a32  (102 bytes)
; ======================================================================


L_59CC:
	ld a,001h		;59cc
	ld (0f3ebh),a		;59ce
	call 00062h		;59d1   ; BIOS CHGCLR - Changes the screen colors
	ld a,(09800h)		;59d4
	ld c,a			;59d7
	ld hl,04002h		;59d8
	call L_576F		;59db
	ld iy,(097ffh)		;59de
	push de			;59e2
	pop ix		;59e3
	ld hl,L_5A01		;59e5
	ld de,0e800h		;59e8
	ld bc,0000bh		;59eb
	ldir		;59ee
	ld hl,L_5A0C		;59f0
	ld de,0fedah		;59f3
	ld bc,00003h		;59f6
	ldir		;59f9
	call 0001ch		;59fb   ; BIOS CALSLT - Executes inter-slot call
	jp 0fecbh		;59fe
L_5A01:
	ld a,(0f103h)		;5a01
	ld h,040h		;5a04
	call 00024h		;5a06   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp L_55D1		;5a09
L_5A0C:
	jp 0e800h		;5a0c
L_5A0F:
	call L_5A3B		;5a0f
L_5A12:
	call 0749eh		;5a12
L_5A15:
	call L_5A48		;5a15
	call L_5C21		;5a18
	ld hl,05c9bh		;5a1b
	ld b,003h		;5a1e
	call 07690h		;5a20
	ld b,a			;5a23
	ld hl,05a38h		;5a24
	call 07251h		;5a27
	ld a,(hl)			;5a2a
	ld (0f10bh),a		;5a2b
	ld a,b			;5a2e
	call 0737bh		;5a2f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5a32..0x5a3b  (9 bytes)
DATA_5A32:
	defb 0a2h,05ah,05bh,05bh,009h,05ch,010h,020h,000h	; 5a32  .Z[[.\. .

; ======================================================================
; CODIGO 0x5a3b..0x5acb  (144 bytes)
; ======================================================================


L_5A3B:
	ld hl,03a21h		;5a3b
	ld (09235h),hl		;5a3e
	ld hl,03a2ch		;5a41
	ld (09237h),hl		;5a44
	ret			;5a47
L_5A48:
	ld a,(092ceh)		;5a48
	rra			;5a4b
	jr c,L_5A57		;5a4c
	ld hl,(0f28eh)		;5a4e
	ld de,(0f290h)		;5a51
	jr L_5A6F		;5a55
L_5A57:
	ld hl,(0f28eh)		;5a57
	ld de,092cah		;5a5a
	call L_5A80		;5a5d
	ld hl,(0f290h)		;5a60
	ld de,092cdh		;5a63
	call L_5A80		;5a66
	ld hl,092c8h		;5a69
	ld de,092cbh		;5a6c
L_5A6F:
	push de			;5a6f
	ld de,092b3h		;5a70
	call L_5A89		;5a73
	ld de,092b6h		;5a76
	pop hl			;5a79
	ld a,h			;5a7a
	or l			;5a7b
	call nz,L_5A89		;5a7c
	ret			;5a7f
L_5A80:
	ld b,003h		;5a80
L_5A82:
	ld a,(hl)			;5a82
	ld (de),a			;5a83
	inc hl			;5a84
	dec de			;5a85
	djnz L_5A82		;5a86
	ret			;5a88
L_5A89:
	inc hl			;5a89
	inc hl			;5a8a
	push hl			;5a8b
	push de			;5a8c
	ld b,003h		;5a8d
L_5A8F:
	ld a,(de)			;5a8f
	cp (hl)			;5a90
	jr c,L_5A9A		;5a91
	dec hl			;5a93
	dec de			;5a94
	djnz L_5A8F		;5a95
	pop de			;5a97
	pop hl			;5a98
	ret			;5a99
L_5A9A:
	pop de			;5a9a
	pop hl			;5a9b
	ld bc,00003h		;5a9c
	lddr		;5a9f
	ret			;5aa1
L_5AA2:
	call L_50B9		;5aa2
	jp z,L_5A15		;5aa5
	ld hl,052a1h		;5aa8
	call L_5265		;5aab
	call L_5CA6		;5aae
	call L_5CFE		;5ab1
	ld hl,05cdeh		;5ab4
	ld b,003h		;5ab7
	call 07690h		;5ab9
	ld b,a			;5abc
	ld hl,05ad1h		;5abd
	call 07251h		;5ac0
	ld a,(hl)			;5ac3
	ld (0f10bh),a		;5ac4
	ld a,b			;5ac7
	call 0737bh		;5ac8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5acb..0x5ad4  (9 bytes)
DATA_5ACB:
	defb 0e3h,05ah,0d4h,05ah,015h,05ah,011h,012h,000h	; 5acb  .Z.Z.Z...

; ======================================================================
; CODIGO 0x5ad4..0x5af2  (30 bytes)
; ======================================================================


L_5AD4:
	call L_5B1F		;5ad4
	jp z,L_5AA2		;5ad7
	call 074bfh		;5ada
	call L_4B7A		;5add
	jp L_5A12		;5ae0
L_5AE3:
	call L_5B1F		;5ae3
	jp z,L_5AA2		;5ae6
	call 074bfh		;5ae9
	call L_4B64		;5aec
	jp L_5A12		;5aef

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5af2..0x5b1f  (45 bytes)
DATA_5AF2:
	defb 02ah,08ch,0f2h,07ch,0b5h,0cah,0a2h,05ah,0cdh,01fh,05bh,0cah,0a2h,05ah,0cdh,0bfh	; 5af2  *..|...Z..[..Z..
	defb 074h,0cdh,0e6h,04bh,0c3h,012h,05ah,03ah,0c7h,092h,0b7h,0cah,0a2h,05ah,0cdh,01fh	; 5b02  t..K..Z:.....Z..
	defb 05bh,0cah,0a2h,05ah,0cdh,0bfh,074h,0cdh,0cdh,04bh,0c3h,012h,05ah	; 5b12  [..Z..t..K..Z

; ======================================================================
; CODIGO 0x5b1f..0x5b3a  (27 bytes)
; ======================================================================


L_5B1F:
	call L_5D56		;5b1f
	call L_5B2B		;5b22
	ld hl,03a6ch		;5b25
	jp L_5044		;5b28
L_5B2B:
	ld hl,05b3ah		;5b2b
	jr L_5B33		;5b2e
L_5B30:
	ld hl,05b4ah		;5b30
L_5B33:
	ld de,(09237h)		;5b33
	jp 0738bh		;5b37

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5b3a..0x5b5b  (33 bytes)
DATA_5B3A:
	defb 049h,04eh,050h,055h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,0ffh	; 5b3a  INPUT.FILE.NAME.
	defb 053h,045h,04ch,045h,043h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h	; 5b4a  SELECT.FILE.NAME
	defb 0ffh	; 5b5a

; ======================================================================
; CODIGO 0x5b5b..0x5b7e  (35 bytes)
; ======================================================================


L_5B5B:
	call L_50B9		;5b5b
	jp z,L_5A15		;5b5e
	call L_5CB2		;5b61
	call L_5CFE		;5b64
	ld hl,05cf6h		;5b67
	ld b,002h		;5b6a
	call 07690h		;5b6c
	ld b,a			;5b6f
	ld hl,05b82h		;5b70
	call 07251h		;5b73
	ld a,(hl)			;5b76
	ld (0f10bh),a		;5b77
	ld a,b			;5b7a
	call 0737bh		;5b7b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5b7e..0x5b84  (6 bytes)
DATA_5B7E:
	defb 084h,05bh,015h,05ah,022h,000h	; 5b7e

; ======================================================================
; CODIGO 0x5b84..0x5b92  (14 bytes)
; ======================================================================


L_5B84:
	call L_5BBD		;5b84
	jr c,$-44		;5b87
	call 074bfh		;5b89
	call L_4BFC		;5b8c
	jp L_5A12		;5b8f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5b92..0x5bbd  (43 bytes)
DATA_5B92:
	defb 02ah,08ch,0f2h,07ch,0b5h,0cah,05bh,05bh,0cdh,0bdh,05bh,038h,0bch,0cdh,0bfh,074h	; 5b92  *..|..[[..[8...t
	defb 0cdh,065h,04ch,0c3h,012h,05ah,03ah,0c7h,092h,0b7h,0cah,05bh,05bh,0cdh,0bdh,05bh	; 5ba2  .eL..Z:....[[..[
	defb 038h,0a7h,0cdh,0bfh,074h,0cdh,04fh,04ch,0c3h,012h,05ah	; 5bb2  8...t.OL..Z

; ======================================================================
; CODIGO 0x5bbd..0x5bd3  (22 bytes)
; ======================================================================


L_5BBD:
	ld hl,052bah		;5bbd
	call L_5265		;5bc0
	call L_5D56		;5bc3
	call L_5D9A		;5bc6
	call L_5393		;5bc9
	ret c			;5bcc
	ld hl,052a1h		;5bcd
	jp L_5265		;5bd0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5bd3..0x5c09  (54 bytes)
DATA_5BD3:
	defb 03ah,0c7h,092h,0b7h,0cah,015h,05ah,0cdh,0b0h,05dh,0cdh,0feh,05ch,021h,0dfh,05dh	; 5bd3  :.....Z..]..\!.]
	defb 006h,003h,0cdh,090h,076h,0cdh,07bh,073h,000h,05ch,0f1h,05bh,015h,05ah,0cdh,0d6h	; 5be3  ....v.{s.\.[.Z..
	defb 074h,0cdh,02ah,05ch,0cdh,0feh,05ch,0cdh,04ah,068h,0c3h,015h,05ah,0cdh,0adh,069h	; 5bf3  t.*\..\.Jh..Z..i
	defb 0cdh,0a0h,06ah,0c3h,015h,05ah	; 5c03

; ======================================================================
; CODIGO 0x5c09..0x5c72  (105 bytes)
; ======================================================================


L_5C09:
	call 074bfh		;5c09
	xor a			;5c0c
	ld (0f10ah),a		;5c0d
	ld (0f10bh),a		;5c10
	ld a,006h		;5c13
	call 00141h		;5c15   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;5c18
	ret nz			;5c1a
	ld (0f111h),a		;5c1b
	jp 066d5h		;5c1e
L_5C21:
	call 074d6h		;5c21
	ld hl,05c72h		;5c24
	call 0738fh		;5c27
L_5C2A:
	ld hl,(09235h)		;5c2a
	ld bc,000a0h		;5c2d
	add hl,bc			;5c30
	ex de,hl			;5c31
L_5C32:
	ld a,(0f281h)		;5c32
	inc a			;5c35
	ret z			;5c36
	ld hl,05ca1h		;5c37
	push de			;5c3a
	call 0738bh		;5c3b
	ld a,(0f281h)		;5c3e
	ld hl,0f2d1h		;5c41
	call L_5099		;5c44
	pop hl			;5c47
	call 073b5h		;5c48
	jr z,L_5C5B		;5c4b
	ld bc,00004h		;5c4d
	add hl,bc			;5c50
	ld de,0f2d1h		;5c51
	ex de,hl			;5c54
	ld bc,00002h		;5c55
	jp 0005ch		;5c58   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_5C5B:
	ld a,0ffh		;5c5b
	ld (0f2d3h),a		;5c5d
	ld de,00004h		;5c60
	add hl,de			;5c63
	ex de,hl			;5c64
	ld hl,0f2d1h		;5c65
	call 073abh		;5c68
	ld a,(0f122h)		;5c6b
	ld (0faf6h),a		;5c6e
	ret			;5c71

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5c72..0x5ca6  (52 bytes)
DATA_5C72:
	defb 021h,03ah,040h,040h,04dh,045h,04eh,055h,040h,040h,0feh,02ch,03ah,044h,049h,053h	; 5c72  !:@@MENU@@.,:DIS
	defb 04bh,000h,053h,041h,056h,045h,0feh,04ch,03ah,044h,049h,053h,04bh,000h,04ch,04fh	; 5c82  K.SAVE.L:DISK.LO
	defb 041h,044h,0feh,06ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,052h	; 5c92  AD.l:END.+:K:k:R
	defb 043h,040h,037h,0ffh	; 5ca2

; ======================================================================
; CODIGO 0x5ca6..0x5cbe  (24 bytes)
; ======================================================================


L_5CA6:
	call 074d6h		;5ca6
	ld hl,05cbeh		;5ca9
	call 0738fh		;5cac
	jp L_5C2A		;5caf
L_5CB2:
	call 074d6h		;5cb2
	ld hl,05ce4h		;5cb5
	call 0738fh		;5cb8
	jp L_5C2A		;5cbb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5cbe..0x5cfe  (64 bytes)
DATA_5CBE:
	defb 02ch,03ah,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h,0feh,04ch,03ah	; 5cbe  ,:SCREEN.DATA.L:
	defb 047h,041h,04dh,045h,000h,044h,041h,054h,041h,0feh,06ch,03ah,045h,04eh,044h,0ffh	; 5cce  GAME.DATA.l:END.
	defb 02bh,03ah,04bh,03ah,06bh,03ah,02ch,03ah,047h,041h,04dh,045h,000h,044h,041h,054h	; 5cde  +:K:k:,:GAME.DAT
	defb 041h,0feh,04ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,0abh,03ah	; 5cee  A.L:END.+:K:k:.:

; ======================================================================
; CODIGO 0x5cfe..0x5d10  (18 bytes)
; ======================================================================


L_5CFE:
	ld hl,05d10h		;5cfe
	ld a,(0f10bh)		;5d01
	and 0f0h		;5d04
	rrca			;5d06
	rrca			;5d07
	rrca			;5d08
	rrca			;5d09
	dec a			;5d0a
	ld bc,00000h		;5d0b
	jr $+86		;5d0e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5d10..0x5d56  (70 bytes)
DATA_5D10:
	defb 01eh,05dh,028h,05dh,000h,000h,000h,000h,000h,000h,046h,05dh,04eh,05dh,044h,049h	; 5d10  .](]......F]N]DI
	defb 053h,04bh,040h,053h,041h,056h,045h,0ffh,044h,049h,053h,04bh,040h,04ch,04fh,041h	; 5d20  SK@SAVE.DISK@LOA
	defb 044h,0ffh,054h,041h,050h,045h,040h,053h,041h,056h,045h,0ffh,054h,041h,050h,045h	; 5d30  D.TAPE@SAVE.TAPE
	defb 040h,04ch,04fh,041h,044h,0ffh,052h,041h,04eh,04bh,049h,04eh,047h,0ffh,050h,052h	; 5d40  @LOAD.RANKING.PR
	defb 049h,04eh,054h,045h,052h,0ffh	; 5d50

; ======================================================================
; CODIGO 0x5d56..0x5d75  (31 bytes)
; ======================================================================


L_5D56:
	call 0748fh		;5d56
	ld a,(0f10bh)		;5d59
	and 00fh		;5d5c
	ld hl,05d75h		;5d5e
	ld bc,00040h		;5d61
L_5D64:
	ex de,hl			;5d64
	ld hl,(09235h)		;5d65
	add hl,bc			;5d68
	ex de,hl			;5d69
	add a,a			;5d6a
	call 07251h		;5d6b
	ld a,(hl)			;5d6e
	inc hl			;5d6f
	ld h,(hl)			;5d70
	ld l,a			;5d71
	jp 0738bh		;5d72

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5d75..0x5d9a  (37 bytes)
DATA_5D75:
	defb 089h,05dh,082h,05dh,07dh,05dh,092h,05dh,047h,041h,04dh,045h,0ffh,053h,043h,052h	; 5d75  .].]}].]GAME.SCR
	defb 045h,045h,04eh,0ffh,048h,049h,000h,053h,043h,04fh,052h,045h,0ffh,052h,041h,04eh	; 5d85  EEN.HI.SCORE.RAN
	defb 04bh,049h,04eh,047h,0ffh	; 5d95

; ======================================================================
; CODIGO 0x5d9a..0x5da4  (10 bytes)
; ======================================================================


L_5D9A:
	ld de,(09237h)		;5d9a
	ld hl,05da4h		;5d9e
	jp 0738bh		;5da1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5da4..0x5de5  (65 bytes)
DATA_5DA4:
	defb 053h,045h,041h,052h,043h,048h,000h,046h,049h,04ch,045h,0ffh,0cdh,0d6h,074h,021h	; 5da4  SEARCH.FILE...t!
	defb 0bch,05dh,0cdh,08fh,073h,0c3h,02ah,05ch,02ch,03ah,044h,049h,053h,050h,04ch,041h	; 5db4  .]..s.*\,:DISPLA
	defb 059h,000h,044h,041h,054h,041h,0feh,04ch,03ah,043h,048h,041h,04eh,047h,045h,000h	; 5dc4  Y.DATA.L:CHANGE.
	defb 04eh,041h,04dh,045h,0feh,0cch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,0cbh	; 5dd4  NAME..:END.+:K:.
	defb 03ah	; 5de4

; ======================================================================
; CODIGO 0x5de5..0x5e0d  (40 bytes)
; ======================================================================


L_5DE5:
	ld hl,0f281h		;5de5
	ld a,(hl)			;5de8
	ld (hl),0ffh		;5de9
	ld (0f116h),a		;5deb
L_5DEE:
	call L_5F0D		;5dee
	call 06762h		;5df1
	call 062d3h		;5df4
	ld hl,05fcfh		;5df7
	call 0738fh		;5dfa
	ld hl,06030h		;5dfd
	ld b,005h		;5e00
	call 07676h		;5e02
	cp 0ffh		;5e05
	jp z,0665eh		;5e07
	call 0737bh		;5e0a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5e0d..0x5e17  (10 bytes)
DATA_5E0D:
	defb 01ah,05fh,089h,05eh,04ah,05eh,017h,05eh,098h,05eh	; 5e0d  ._.^J^.^.^

; ======================================================================
; CODIGO 0x5e17..0x5eac  (149 bytes)
; ======================================================================


L_5E17:
	ld a,(0f103h)		;5e17
	ld h,080h		;5e1a
	call 00024h		;5e1c   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,005h		;5e1f
	ld (08000h),a		;5e21
	inc a			;5e24
	ld (0a000h),a		;5e25
	call 08000h		;5e28
	ld a,0c9h		;5e2b
	ld (0fd9fh),a		;5e2d
	ld a,002h		;5e30
	ld (08000h),a		;5e32
	inc a			;5e35
	ld (0a000h),a		;5e36
	ld a,(0f2a0h)		;5e39
	ld h,080h		;5e3c
	call 00024h		;5e3e   ; BIOS ENASLT - Switches to specified slot and page definitively
	call L_5EC2		;5e41
	call L_5EB8		;5e44
	jp L_5EAF		;5e47
L_5E4A:
	ld a,(0f103h)		;5e4a
	ld h,080h		;5e4d
	call 00024h		;5e4f   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,007h		;5e52
	ld (08000h),a		;5e54
	inc a			;5e57
	ld (0a000h),a		;5e58
	call 08000h		;5e5b
	ld a,0e0h		;5e5e
	ld hl,03b00h		;5e60
	ld bc,00080h		;5e63
	call 00056h		;5e66   ; BIOS FILVRM - Fills VRAM with value
	ld a,002h		;5e69
	ld (08000h),a		;5e6b
	inc a			;5e6e
	ld (0a000h),a		;5e6f
	call 072eah		;5e72
	ld a,(0f2a0h)		;5e75
	ld h,080h		;5e78
	call 00024h		;5e7a   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0672dh		;5e7d
	call 08191h		;5e80
	call 0673fh		;5e83
	jp L_5DEE		;5e86
L_5E89:
	call 07973h		;5e89
	call 0672dh		;5e8c
	call 08191h		;5e8f
	call 0673fh		;5e92
	jp L_5DEE		;5e95
L_5E98:
	ld hl,0f298h		;5e98
	ld a,(hl)			;5e9b
	or a			;5e9c
	jr nz,L_5EA2		;5e9d
	ld (092cfh),a		;5e9f
L_5EA2:
	ld hl,0f281h		;5ea2
	ld a,(0f116h)		;5ea5
	ld (hl),a			;5ea8
	jp 06669h		;5ea9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5eac..0x5eaf  (3 bytes)
DATA_5EAC:
	defb 0cdh,070h,05fh	; 5eac

; ======================================================================
; CODIGO 0x5eaf..0x5f84  (213 bytes)
; ======================================================================


L_5EAF:
	call 072eah		;5eaf
	call L_5EB8		;5eb2
	jp L_5DEE		;5eb5
L_5EB8:
	call 0672dh		;5eb8
	call 08191h		;5ebb
	call 0673fh		;5ebe
	ret			;5ec1
L_5EC2:
	call L_5EEA		;5ec2
	ld a,(0002dh)		;5ec5
	and a			;5ec8
	jp z,072bch		;5ec9
	ld a,(0f103h)		;5ecc
	ld h,080h		;5ecf
	call 00024h		;5ed1   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 08183h		;5ed4
	ld a,(0f2a0h)		;5ed7
	ld h,080h		;5eda
	call 00024h		;5edc   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;5edf
	call 0005fh		;5ee1   ; BIOS CHGMOD - Switches to given screen mode
	call 072bch		;5ee4
	jp 07275h		;5ee7
L_5EEA:
	ld hl,00000h		;5eea
	call L_5F06		;5eed
	ld a,(0002dh)		;5ef0
	and a			;5ef3
	jp z,00056h		;5ef4   ; BIOS FILVRM - Fills VRAM with value
	ld hl,04000h		;5ef7
	call L_5F06		;5efa
	ld hl,08000h		;5efd
	call L_5F06		;5f00
	ld hl,0c000h		;5f03
L_5F06:
	ld bc,04000h		;5f06
	xor a			;5f09
	jp 0016bh		;5f0a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
L_5F0D:
	ld hl,03921h		;5f0d
	ld (09235h),hl		;5f10
	ld hl,0392ch		;5f13
	ld (09237h),hl		;5f16
	ret			;5f19
L_5F1A:
	call L_50B9		;5f1a
	jp z,L_5DEE		;5f1d
	call 062d3h		;5f20
	ld a,021h		;5f23
	ld (0f10bh),a		;5f25
	call 0623bh		;5f28
	call L_53A8		;5f2b
	jp c,L_5DEE		;5f2e
	ld hl,052a1h		;5f31
	call L_5265		;5f34
	call 062d3h		;5f37
	call L_5EEA		;5f3a
	call L_4C37		;5f3d
	jr c,L_5F67		;5f40
	ld a,0ffh		;5f42
	ld (0f112h),a		;5f44
	call L_5F70		;5f47
	ld a,006h		;5f4a
	call 00141h		;5f4c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;5f4f
	jp nz,L_5F5A		;5f51
	call L_5A3B		;5f54
	call L_4BA0		;5f57
L_5F5A:
	xor a			;5f5a
	ld (0f112h),a		;5f5b
	call L_5EC2		;5f5e
	call L_5EB8		;5f61
	jp L_5EAF		;5f64
L_5F67:
	call L_5EC2		;5f67
	call L_5EB8		;5f6a
	jp L_5DEE		;5f6d
L_5F70:
	call 0749eh		;5f70
	ld hl,05f96h		;5f73
	call 0738fh		;5f76
	ld hl,05fcbh		;5f79
	ld b,002h		;5f7c
	call 07690h		;5f7e
	call 0737bh		;5f81

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5f84..0x5f88  (4 bytes)
DATA_5F84:
	defb 088h,05fh,093h,05fh	; 5f84

; ======================================================================
; CODIGO 0x5f88..0x5f96  (14 bytes)
; ======================================================================


L_5F88:
	call 074bfh		;5f88
	call 00156h		;5f8b   ; BIOS KILBUF - Clears keyboard buffer
	call 0009fh		;5f8e   ; BIOS CHGET - One character input (waiting)
	jr $-33		;5f91
L_5F93:
	jp 074bfh		;5f93

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5f96..0x6000  (106 bytes)
DATA_5F96:
	defb 026h,03ah,040h,040h,053h,043h,052h,045h,045h,04eh,000h,044h,049h,053h,050h,04ch	; 5f96  &:@@SCREEN.DISPL
	defb 041h,059h,000h,04dh,04fh,044h,045h,040h,040h,0feh,067h,03ah,044h,049h,053h,050h	; 5fa6  AY.MODE@@.g:DISP
	defb 04ch,041h,059h,000h,041h,04ch,04ch,000h,053h,043h,052h,045h,045h,04eh,0feh,087h	; 5fb6  LAY.ALL.SCREEN..
	defb 03ah,045h,04eh,044h,0ffh,066h,03ah,086h,03ah,0c6h,038h,040h,040h,053h,045h,04ch	; 5fc6  :END.f:.:.8@@SEL
	defb 046h,000h,04dh,04fh,044h,045h,000h,04dh,045h,04eh,055h,040h,040h,0feh,027h,039h	; 5fd6  F.MODE.MENU@@.'9
	defb 04ch,04fh,041h,044h,000h,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h	; 5fe6  LOAD.SCREEN.DATA
	defb 0feh,067h,039h,053h,052h,041h,04dh,000h,044h,049h	; 5ff6  .g9SRAM.DI
