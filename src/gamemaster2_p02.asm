; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l9000h:	equ 0x09000

; ======================================================================
; CODIGO 0x8000..0x8170  (368 bytes)
; ======================================================================


L_8000:
	ld hl,0f11ah		;8000
	ld a,(hl)			;8003
	or a			;8004
	ret nz			;8005
	dec a			;8006
	ld (hl),a			;8007
	ld a,(0f29fh)		;8008
	ld h,040h		;800b
	call 00024h		;800d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f3dfh)		;8010
	and 00eh		;8013
	ld l,a			;8015
	ld a,(0f3e0h)		;8016
	and 018h		;8019
	ld h,a			;801b
	ld (0f2a1h),hl		;801c
	ld de,00006h		;801f
	rst 20h			;8022
	jp z,L_806F		;8023
	ld de,00002h		;8026
	rst 20h			;8029
	jp z,L_8064		;802a
	ld de,00004h		;802d
	rst 20h			;8030
	jp z,L_8064		;8031
	ld hl,0f3dfh		;8034
	ld de,06020h		;8037
	ld bc,00008h		;803a
	ldir		;803d
	call L_815F		;803f
	ld de,06000h		;8042
	ld hl,00000h		;8045
	ld bc,00008h		;8048
	call 00059h		;804b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,06008h		;804e
	ld hl,00800h		;8051
	ld bc,00008h		;8054
	call 00059h		;8057   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,00000h		;805a
	ld bc,00008h		;805d
	xor a			;8060
	call 00056h		;8061   ; BIOS FILVRM - Fills VRAM with value
L_8064:
	ld a,(0f103h)		;8064
	ld h,040h		;8067
	call 00024h		;8069   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp 077c3h		;806c
L_806F:
	call L_8178		;806f
	call L_80A0		;8072
	call L_80C6		;8075
	ld a,(0f103h)		;8078
	ld h,040h		;807b
	call 00024h		;807d   ; BIOS ENASLT - Switches to specified slot and page definitively
L_8080:
	call L_80A0		;8080
	call 00171h		;8083   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_8086:
	xor a			;8086
	exx			;8087
	out (c),a		;8088
	exx			;808a
	inc hl			;808b
	ld a,h			;808c
	and 07fh		;808d
	or l			;808f
	call z,L_8099		;8090
	dec bc			;8093
	ld a,c			;8094
	or b			;8095
	jr nz,L_8086		;8096
	ret			;8098
L_8099:
	ld a,h			;8099
	xor 080h		;809a
	ld h,a			;809c
	jp 00171h		;809d   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_80A0:
	exx			;80a0
	ld a,(00006h)		;80a1
	ld c,a			;80a4
	exx			;80a5
	ld a,(0f3e1h)		;80a6
	ld hl,00000h		;80a9
	and 040h		;80ac
	jr z,L_80B2		;80ae
	ld h,080h		;80b0
L_80B2:
	ld a,(0fff6h)		;80b2
	add a,080h		;80b5
	ld e,000h		;80b7
	ld d,a			;80b9
	srl d		;80ba
	rr e		;80bc
	add hl,de			;80be
	ld de,06000h		;80bf
	ld bc,02000h		;80c2
	ret			;80c5
L_80C6:
	call 0016eh		;80c6   ; BIOS NSETRD - Same function as SETRD (with 16-bit VRAM-address)
L_80C9:
	exx			;80c9
	in a,(c)		;80ca
	exx			;80cc
	ld (de),a			;80cd
	inc de			;80ce
	inc hl			;80cf
	ld a,h			;80d0
	and 07fh		;80d1
	or l			;80d3
	call z,L_80DD		;80d4
	dec bc			;80d7
	ld a,c			;80d8
	or b			;80d9
	jr nz,L_80C9		;80da
	ret			;80dc
L_80DD:
	ld a,h			;80dd
	xor 080h		;80de
	ld h,a			;80e0
	jp 0016eh		;80e1   ; BIOS NSETRD - Same function as SETRD (with 16-bit VRAM-address)
L_80E4:
	ld hl,0f11ah		;80e4
	ld a,(hl)			;80e7
	or a			;80e8
	ret z			;80e9
	xor a			;80ea
	ld (hl),a			;80eb
	ld a,(0f29fh)		;80ec
	ld h,040h		;80ef
	call 00024h		;80f1   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(0f2a1h)		;80f4
	ld de,00006h		;80f7
	rst 20h			;80fa
	jp z,L_8132		;80fb
	ld de,00002h		;80fe
	rst 20h			;8101
	jp z,L_8127		;8102
	ld de,00004h		;8105
	rst 20h			;8108
	jp z,L_8127		;8109
	call L_815A		;810c
	ld hl,06000h		;810f
	ld de,00000h		;8112
	ld bc,00008h		;8115
	call 0005ch		;8118   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,06008h		;811b
	ld de,00800h		;811e
	ld bc,00008h		;8121
	call 0005ch		;8124   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_8127:
	ld a,(0f103h)		;8127
	ld h,040h		;812a
	call 00024h		;812c   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp 07847h		;812f
L_8132:
	call L_80A0		;8132
	call L_8143		;8135
	ld a,(0f103h)		;8138
	ld h,040h		;813b
	call 00024h		;813d   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp L_8183		;8140
L_8143:
	call 00171h		;8143   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_8146:
	ld a,(de)			;8146
	exx			;8147
	out (c),a		;8148
	exx			;814a
	inc de			;814b
	inc hl			;814c
	ld a,h			;814d
	and 07fh		;814e
	or l			;8150
	call z,L_8099		;8151
	dec bc			;8154
	ld a,c			;8155
	or b			;8156
	jr nz,L_8146		;8157
	ret			;8159
L_815A:
	ld hl,06020h		;815a
	jr L_8162		;815d
L_815F:
	ld hl,08170h		;815f
L_8162:
	ld bc,00800h		;8162
L_8165:
	push bc			;8165
	ld b,(hl)			;8166
	call 00047h		;8167   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;816a
	inc hl			;816b
	inc c			;816c
	djnz L_8165		;816d
	ret			;816f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8170..0x8178  (8 bytes)
DATA_8170:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 8170  .....v..

; ======================================================================
; CODIGO 0x8178..0x818e  (22 bytes)
; ======================================================================


L_8178:
	ld a,(0ffe7h)		;8178
	or 002h		;817b
	ld b,a			;817d
	ld c,008h		;817e
	jp 00047h		;8180   ; BIOS WRTVDP - Writes data in the VDP-register
L_8183:
	ld a,(0ffe7h)		;8183
	and 0fdh		;8186
	ld b,a			;8188
	ld c,008h		;8189
	jp 00047h		;818b   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; DATOS sin identificar  0x818e..0x8300  (370 bytes)
DATA_818E:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 818e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 819e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ae  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81be  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ce  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81de  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ee  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81fe  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 820e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 821e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 822e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 823e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 824e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 825e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 826e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 827e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 828e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 829e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ae  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82be  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ce  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82de  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ee  ................
	defb 0ffh,0ffh	; 82fe

; ======================================================================
; CODIGO 0x8300..0x837f  (127 bytes)
; ======================================================================


L_8300:
	jp L_8309		;8300
L_8303:
	jp L_8315		;8303
L_8306:
	jp L_832C		;8306
L_8309:
	di			;8309
	ld hl,0e280h		;830a
	ld de,0c000h		;830d
	ld bc,01100h		;8310
	ldir		;8313
L_8315:
	di			;8315
	ld sp,0df80h		;8316
	call L_83AC		;8319
	jp nc,L_835A		;831c
	ld hl,04002h		;831f
	call L_8398		;8322
	jp z,L_835A		;8325
	ex de,hl			;8328
	ld (0d132h),hl		;8329
L_832C:
	ld a,003h		;832c
	ld (0fcafh),a		;832e
	ld hl,0f100h		;8331
	ld de,0d500h		;8334
	ld bc,00314h		;8337
	ldir		;833a
	call L_8D44		;833c
	jp nz,L_835A		;833f
	call L_8D8C		;8342
	call 0a24fh		;8345
	ld a,007h		;8348
	call 00141h		;834a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 004h		;834d
	jr z,L_8364		;834f
	ld hl,0d13ch		;8351
	ld a,(hl)			;8354
	or a			;8355
	jr nz,L_8364		;8356
	dec a			;8358
	ld (hl),a			;8359
L_835A:
	xor a			;835a
	ld (0d129h),a		;835b
	ld (0d13dh),a		;835e
	jp L_9929		;8361
L_8364:
	di			;8364
	ld a,0ffh		;8365
	ld (0d13dh),a		;8367
	xor a			;836a
	ld (0d33ah),a		;836b
	ld (0d13bh),a		;836e
	ld hl,0d4f0h		;8371
	ld de,0fd9fh		;8374
	ld bc,00005h		;8377
	ldir		;837a
	jp 0d83bh		;837c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x837f..0x8398  (25 bytes)
DATA_837F:
	defb 0cdh,038h,001h,00fh,00fh,0e6h,003h,04fh,006h,000h,021h,0c1h,0fch,009h,0b6h,04fh	; 837f  .8.....O..!....O
	defb 023h,023h,023h,023h,07eh,0e6h,00ch,0b1h,0c9h	; 838f  ####~....

; ======================================================================
; CODIGO 0x8398..0x84a7  (271 bytes)
; ======================================================================


L_8398:
	ld a,(0d12fh)		;8398
	ld c,a			;839b
	call L_83A0		;839c
	ld e,d			;839f
L_83A0:
	ld a,c			;83a0
	push bc			;83a1
	push de			;83a2
	call 0000ch		;83a3   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;83a6
	pop bc			;83a7
	ld d,a			;83a8
	or e			;83a9
	inc hl			;83aa
	ret			;83ab
L_83AC:
	ld hl,L_83BA		;83ac
	ld de,0da00h		;83af
	ld bc,000cdh		;83b2
	ldir		;83b5
	jp 0da00h		;83b7
L_83BA:
	ld bc,00400h		;83ba
	ld hl,0fcc1h		;83bd
L_83C0:
	push bc			;83c0
	push hl			;83c1
	ld a,(hl)			;83c2
	bit 7,a		;83c3
	jr nz,L_83E4		;83c5
	ld b,c			;83c7
	call 0dabdh		;83c8
	jr z,L_83D1		;83cb
	ld a,c			;83cd
	call 0da46h		;83ce
L_83D1:
	pop hl			;83d1
	pop bc			;83d2
	jr c,L_83D9		;83d3
	inc hl			;83d5
	inc c			;83d6
	djnz L_83C0		;83d7
L_83D9:
	push af			;83d9
	ld a,(0d12eh)		;83da
	ld h,040h		;83dd
	call 00024h		;83df   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;83e2
	ret			;83e3
L_83E4:
	call 0da2fh		;83e4
	jr L_83D1		;83e7
L_83E9:
	and 080h		;83e9
	or c			;83eb
	ld b,004h		;83ec
L_83EE:
	push bc			;83ee
	ld b,a			;83ef
	call 0dabdh		;83f0
	jr z,L_83F9		;83f3
	ld a,b			;83f5
	call 0da46h		;83f6
L_83F9:
	pop bc			;83f9
	ret c			;83fa
	add a,004h		;83fb
	djnz L_83EE		;83fd
	ret			;83ff
L_8400:
	push af			;8400
	ld h,040h		;8401
	call 00024h		;8403   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(04000h)		;8406
	ld de,04241h		;8409
	rst 20h			;840c
	jr nz,L_846E		;840d
	ld hl,(04002h)		;840f
	ld bc,00100h		;8412
L_8415:
	ld a,09bh		;8415
	cpir		;8417
	jr nz,L_846E		;8419
	jp po,0dab4h		;841b
	ld a,0fdh		;841e
	cp (hl)			;8420
	jr nz,L_8415		;8421
	ld hl,(04010h)		;8423
	ld de,04241h		;8426
	rst 20h			;8429
	jr z,L_8471		;842a
	ld de,04443h		;842c
	rst 20h			;842f
	jr z,L_8471		;8430
	ld de,04645h		;8432
	rst 20h			;8435
	jr z,L_8471		;8436
	ld de,00000h		;8438
	ld hl,05000h		;843b
	ld b,000h		;843e
L_8440:
	ld a,(hl)			;8440
	add a,e			;8441
	ld e,a			;8442
	jr nc,L_8446		;8443
	inc d			;8445
L_8446:
	inc hl			;8446
	djnz L_8440		;8447
	push de			;8449
	ld a,(0d12eh)		;844a
	ld h,040h		;844d
	call 00024h		;844f   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop de			;8452
	ld ix,044beh		;8453
L_8457:
	ld l,(ix+000h)		;8457
	ld h,(ix+001h)		;845a
	ld a,l			;845d
	or h			;845e
	jr z,L_846E		;845f
	rst 20h			;8461
	jr z,L_8471		;8462
	inc ix		;8464
	inc ix		;8466
	inc ix		;8468
	inc ix		;846a
	jr L_8457		;846c
L_846E:
	pop af			;846e
	and a			;846f
	ret			;8470
L_8471:
	pop af			;8471
	ld (0d12fh),a		;8472
	scf			;8475
	ret			;8476
L_8477:
	ld a,(0d12eh)		;8477
	bit 7,a		;847a
	jr nz,L_8485		;847c
	bit 7,b		;847e
	ret nz			;8480
	sub b			;8481
	and 003h		;8482
	ret			;8484
L_8485:
	cp b			;8485
	ret			;8486
L_8487:
	call L_84B0		;8487
L_848A:
	call 0a578h		;848a
L_848D:
	call L_8633		;848d
	ld hl,08691h		;8490
	ld b,003h		;8493
	call 0a7b2h		;8495
	ld b,a			;8498
	ld hl,084adh		;8499
	call 0a3e6h		;849c
	ld a,(hl)			;849f
	ld (0d136h),a		;84a0
	ld a,b			;84a3
	call 0a510h		;84a4

; ----------------------------------------------------------------------
; DATOS saltos_84A7: tabla de 3 palabras del despachador (call 0x408D en
;   0x84A4); lo leen el despachador (6 bytes)
;   0x84a7..0x84ad  (6 bytes)
DATA_saltos_84A7:
	defb 0bdh,084h	; 84a7
	defb 06dh,085h	; 84a9
	defb 01bh,086h	; 84ab

; ----------------------------------------------------------------------
; DATOS sin identificar  0x84ad..0x84b0  (3 bytes)
DATA_84AD:
	defb 010h,020h,000h	; 84ad

; ======================================================================
; CODIGO 0x84b0..0x84e0  (48 bytes)
; ======================================================================


L_84B0:
	ld hl,03a21h		;84b0
	ld (0d16ch),hl		;84b3
	ld hl,03a2ch		;84b6
	ld (0d16eh),hl		;84b9
	ret			;84bc
L_84BD:
	call L_945D		;84bd
	jr z,$-51		;84c0
	ld hl,09644h		;84c2
	call L_9611		;84c5
	call L_869C		;84c8
	call L_86F8		;84cb
	ld hl,086d4h		;84ce
	ld b,003h		;84d1
	call 0a7b2h		;84d3
	ld b,a			;84d6
	add a,011h		;84d7
	ld (0d136h),a		;84d9
	ld a,b			;84dc
	call 0a510h		;84dd

; ----------------------------------------------------------------------
; DATOS saltos_84E0: tabla de 3 palabras del despachador (call 0x408D en
;   0x84DD); lo leen el despachador (6 bytes)
;   0x84e0..0x84e6  (6 bytes)
DATA_saltos_84E0:
	defb 0f5h,084h	; 84e0
	defb 0e6h,084h	; 84e2
	defb 08dh,084h	; 84e4

; ======================================================================
; CODIGO 0x84e6..0x854c  (102 bytes)
; ======================================================================


L_84E6:
	call L_8531		;84e6
	jp z,L_84BD		;84e9
	call 0a5efh		;84ec
	call L_90CE		;84ef
	jp L_848A		;84f2
L_84F5:
	call L_8531		;84f5
	jp z,L_84BD		;84f8
	call 0a5efh		;84fb
	call L_90A2		;84fe
	jp L_848A		;8501
L_8504:
	ld hl,(0d30ch)		;8504
	ld a,h			;8507
	or l			;8508
	jp z,L_84BD		;8509
	call L_8531		;850c
	jp z,L_84BD		;850f
	call 0a5efh		;8512
	call L_915C		;8515
	jp L_848A		;8518
L_851B:
	ld a,(0d332h)		;851b
	or a			;851e
	jp z,L_84BD		;851f
	call L_8531		;8522
	jp z,L_84BD		;8525
	call 0a5efh		;8528
	call L_9143		;852b
	jp L_848A		;852e
L_8531:
	call L_873C		;8531
	call L_853D		;8534
	ld hl,03a6ch		;8537
	jp L_93E8		;853a
L_853D:
	ld hl,0854ch		;853d
	jr L_8545		;8540
L_8542:
	ld hl,0855ch		;8542
L_8545:
	ld de,(0d16eh)		;8545
	jp 0a520h		;8549

; ----------------------------------------------------------------------
; DATOS sin identificar  0x854c..0x856d  (33 bytes)
DATA_854C:
	defb 049h,04eh,050h,055h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,0ffh	; 854c  INPUT.FILE.NAME.
	defb 053h,045h,04ch,045h,043h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h	; 855c  SELECT.FILE.NAME
	defb 0ffh	; 856c

; ======================================================================
; CODIGO 0x856d..0x8590  (35 bytes)
; ======================================================================


L_856D:
	call L_945D		;856d
	jp z,L_848D		;8570
	call L_86A8		;8573
	call L_86F8		;8576
	ld hl,086f0h		;8579
	ld b,002h		;857c
	call 0a7b2h		;857e
	ld b,a			;8581
	ld hl,08594h		;8582
	call 0a3e6h		;8585
	ld a,(hl)			;8588
	ld (0d136h),a		;8589
	ld a,b			;858c
	call 0a510h		;858d

; ----------------------------------------------------------------------
; DATOS saltos_8590: tabla de 2 palabras del despachador (call 0x408D en
;   0x858D); lo leen el despachador (4 bytes)
;   0x8590..0x8594  (4 bytes)
DATA_saltos_8590:
	defb 096h,085h	; 8590
	defb 08dh,084h	; 8592

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8594..0x8596  (2 bytes)
DATA_8594:
	defb 022h,000h	; 8594

; ======================================================================
; CODIGO 0x8596..0x85fd  (103 bytes)
; ======================================================================


L_8596:
	call L_85CF		;8596
	jr c,$-44		;8599
	call 0a5efh		;859b
	call L_9172		;859e
	jp L_848A		;85a1
L_85A4:
	ld hl,(0d30ch)		;85a4
	ld a,h			;85a7
	or l			;85a8
	jp z,L_856D		;85a9
	call L_85CF		;85ac
	jr c,$-66		;85af
	call 0a5efh		;85b1
	call L_91E3		;85b4
	jp L_848A		;85b7
L_85BA:
	ld a,(0d332h)		;85ba
	or a			;85bd
	jp z,L_856D		;85be
	call L_85CF		;85c1
	jr c,$-87		;85c4
	call 0a5efh		;85c6
	call L_91CD		;85c9
	jp L_848A		;85cc
L_85CF:
	ld hl,0965dh		;85cf
	call L_9611		;85d2
	call L_873C		;85d5
	call L_8780		;85d8
	call L_9733		;85db
	ret c			;85de
	ld hl,09644h		;85df
	jp L_9611		;85e2
L_85E5:
	ld a,(0d332h)		;85e5
	or a			;85e8
	jp z,L_848D		;85e9
	call L_8796		;85ec
	call L_86F8		;85ef
	ld hl,087c5h		;85f2
	ld b,003h		;85f5
	call 0a7b2h		;85f7
	call 0a510h		;85fa

; ----------------------------------------------------------------------
; DATOS saltos_85FD: tabla de 3 palabras del despachador (call 0x408D en
;   0x85FA); lo leen el despachador (6 bytes)
;   0x85fd..0x8603  (6 bytes)
DATA_saltos_85FD:
	defb 012h,086h	; 85fd
	defb 003h,086h	; 85ff
	defb 08dh,084h	; 8601

; ======================================================================
; CODIGO 0x8603..0x8668  (101 bytes)
; ======================================================================


L_8603:
	call 0a655h		;8603
	call L_863C		;8606
	call L_86F8		;8609
	call L_9AB4		;860c
	jp L_848D		;860f
L_8612:
	call L_9C17		;8612
	call L_9D0A		;8615
	jp L_848D		;8618
L_861B:
	call 0a5efh		;861b
	xor a			;861e
	ld (0d135h),a		;861f
	ld (0d136h),a		;8622
	ld a,006h		;8625
	call 00141h		;8627   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;862a
	ret nz			;862c
	ld (0d13ch),a		;862d
	jp L_997E		;8630
L_8633:
	call 0a655h		;8633
	ld hl,08668h		;8636
	call 0a524h		;8639
L_863C:
	ld hl,(0d16ch)		;863c
	ld bc,000a0h		;863f
	add hl,bc			;8642
	ex de,hl			;8643
L_8644:
	ld a,(0d301h)		;8644
	inc a			;8647
	ret z			;8648
	ld hl,08697h		;8649
	push de			;864c
	call 0a520h		;864d
	ld a,(0d301h)		;8650
	ld hl,0da00h		;8653
	call L_943D		;8656
	pop hl			;8659
	ld bc,00004h		;865a
	add hl,bc			;865d
	ld de,0da00h		;865e
	ex de,hl			;8661
	ld bc,00002h		;8662
	jp 0005ch		;8665   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8668..0x869c  (52 bytes)
DATA_8668:
	defb 021h,03ah,040h,040h,04dh,045h,04eh,055h,040h,040h,0feh,02ch,03ah,044h,049h,053h	; 8668  !:@@MENU@@.,:DIS
	defb 04bh,000h,053h,041h,056h,045h,0feh,04ch,03ah,044h,049h,053h,04bh,000h,04ch,04fh	; 8678  K.SAVE.L:DISK.LO
	defb 041h,044h,0feh,06ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,052h	; 8688  AD.l:END.+:K:k:R
	defb 043h,040h,037h,0ffh	; 8698

; ======================================================================
; CODIGO 0x869c..0x86b4  (24 bytes)
; ======================================================================


L_869C:
	call 0a655h		;869c
	ld hl,086b4h		;869f
	call 0a524h		;86a2
	jp L_863C		;86a5
L_86A8:
	call 0a655h		;86a8
	ld hl,086deh		;86ab
	call 0a524h		;86ae
	jp L_863C		;86b1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x86b4..0x86f8  (68 bytes)
DATA_86B4:
	defb 02ch,03ah,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h,0feh,04ch,03ah	; 86b4  ,:SCREEN.DATA.L:
	defb 047h,041h,04dh,045h,000h,044h,041h,054h,041h,0feh,06ch,03ah,045h,04eh,044h,0ffh	; 86c4  GAME.DATA.l:END.
	defb 02bh,03ah,04bh,03ah,06bh,03ah,08bh,03ah,0cbh,03ah,02ch,03ah,047h,041h,04dh,045h	; 86d4  +:K:k:.:.:,:GAME
	defb 000h,044h,041h,054h,041h,0feh,04ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah	; 86e4  .DATA.L:END.+:K:
	defb 06bh,03ah,0abh,03ah	; 86f4

; ======================================================================
; CODIGO 0x86f8..0x870a  (18 bytes)
; ======================================================================


L_86F8:
	ld hl,0870ah		;86f8
	ld a,(0d136h)		;86fb
	and 0f0h		;86fe
	rrca			;8700
	rrca			;8701
	rrca			;8702
	rrca			;8703
	dec a			;8704
	ld bc,00000h		;8705
	jr $+66		;8708

; ----------------------------------------------------------------------
; DATOS sin identificar  0x870a..0x873c  (50 bytes)
DATA_870A:
	defb 018h,087h,022h,087h,000h,000h,000h,000h,000h,000h,02ch,087h,034h,087h,044h,049h	; 870a  ..".......,.4.DI
	defb 053h,04bh,040h,053h,041h,056h,045h,0ffh,044h,049h,053h,04bh,040h,04ch,04fh,041h	; 871a  SK@SAVE.DISK@LOA
	defb 044h,0ffh,052h,041h,04eh,04bh,049h,04eh,047h,0ffh,050h,052h,049h,04eh,054h,045h	; 872a  D.RANKING.PRINTE
	defb 052h,0ffh	; 873a

; ======================================================================
; CODIGO 0x873c..0x875b  (31 bytes)
; ======================================================================


L_873C:
	call 0a56eh		;873c
	ld a,(0d136h)		;873f
	and 00fh		;8742
	ld hl,0875bh		;8744
	ld bc,00040h		;8747
L_874A:
	ex de,hl			;874a
	ld hl,(0d16ch)		;874b
	add hl,bc			;874e
	ex de,hl			;874f
	add a,a			;8750
	call 0a3e6h		;8751
	ld a,(hl)			;8754
	inc hl			;8755
	ld h,(hl)			;8756
	ld l,a			;8757
	jp 0a520h		;8758

; ----------------------------------------------------------------------
; DATOS sin identificar  0x875b..0x8780  (37 bytes)
DATA_875B:
	defb 06fh,087h,068h,087h,063h,087h,078h,087h,047h,041h,04dh,045h,0ffh,053h,043h,052h	; 875b  o.h.c.x.GAME.SCR
	defb 045h,045h,04eh,0ffh,048h,049h,000h,053h,043h,04fh,052h,045h,0ffh,052h,041h,04eh	; 876b  EEN.HI.SCORE.RAN
	defb 04bh,049h,04eh,047h,0ffh	; 877b

; ======================================================================
; CODIGO 0x8780..0x878a  (10 bytes)
; ======================================================================


L_8780:
	ld de,(0d16eh)		;8780
	ld hl,0878ah		;8784
	jp 0a520h		;8787

; ----------------------------------------------------------------------
; DATOS sin identificar  0x878a..0x8796  (12 bytes)
DATA_878A:
	defb 053h,045h,041h,052h,043h,048h,000h,046h,049h,04ch,045h,0ffh	; 878a  SEARCH.FILE.

; ======================================================================
; CODIGO 0x8796..0x87a2  (12 bytes)
; ======================================================================


L_8796:
	call 0a655h		;8796
	ld hl,087a2h		;8799
	call 0a524h		;879c
	jp L_863C		;879f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x87a2..0x87cb  (41 bytes)
DATA_87A2:
	defb 02ch,03ah,044h,049h,053h,050h,04ch,041h,059h,000h,044h,041h,054h,041h,0feh,04ch	; 87a2  ,:DISPLAY.DATA.L
	defb 03ah,043h,048h,041h,04eh,047h,045h,000h,04eh,041h,04dh,045h,0feh,0cch,03ah,045h	; 87b2  :CHANGE.NAME..:E
	defb 04eh,044h,0ffh,02bh,03ah,04bh,03ah,0cbh,03ah	; 87c2  ND.+:K:.:

; ======================================================================
; CODIGO 0x87cb..0x87f6  (43 bytes)
; ======================================================================


L_87CB:
	ld hl,0d301h		;87cb
	ld a,(hl)			;87ce
	ld (hl),0ffh		;87cf
	ld (0d141h),a		;87d1
L_87D4:
	call 04095h		;87d4
	call L_88B6		;87d7
	call L_99D3		;87da
	call L_8CED		;87dd
	ld hl,0882eh		;87e0
	call 0a524h		;87e3
	ld hl,0888fh		;87e6
	ld b,005h		;87e9
	call 0a798h		;87eb
	cp 0ffh		;87ee
	jp z,L_9921		;87f0
	call 0a510h		;87f3

; ----------------------------------------------------------------------
; DATOS saltos_87F6: tabla de 5 palabras del despachador (call 0x408D en
;   0x87F3); lo leen el despachador (10 bytes)
;   0x87f6..0x8800  (10 bytes)
DATA_saltos_87F6:
	defb 0c3h,088h	; 87f6
	defb 026h,088h	; 87f8
	defb 013h,088h	; 87fa
	defb 000h,088h	; 87fc
	defb 099h,088h	; 87fe

; ======================================================================
; CODIGO 0x8800..0x882e  (46 bytes)
; ======================================================================


L_8800:
	call 04108h		;8800
	ld a,0e0h		;8803
	ld hl,03b00h		;8805
	ld bc,00080h		;8808
	call 00056h		;880b   ; BIOS FILVRM - Fills VRAM with value
	call 0a47fh		;880e
	jr $-61		;8811
L_8813:
	call 040f2h		;8813
	call 0a47fh		;8816
	ld a,0e0h		;8819
	ld hl,03b00h		;881b
	ld bc,00080h		;881e
	call 00056h		;8821   ; BIOS FILVRM - Fills VRAM with value
	jr $-80		;8824
L_8826:
	call 0a8e5h		;8826
	call 04095h		;8829
	jr $-88		;882c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x882e..0x8899  (107 bytes)
DATA_882E:
	defb 0c6h,038h,040h,040h,053h,045h,04ch,046h,000h,04dh,04fh,044h,045h,000h,04dh,045h	; 882e  .8@@SELF.MODE.ME
	defb 04eh,055h,040h,040h,0feh,027h,039h,04ch,04fh,041h,044h,000h,053h,043h,052h,045h	; 883e  NU@@.'9LOAD.SCRE
	defb 045h,04eh,000h,044h,041h,054h,041h,0feh,067h,039h,053h,052h,041h,04dh,000h,044h	; 884e  EN.DATA.g9SRAM.D
	defb 049h,053h,04bh,000h,055h,054h,049h,04ch,049h,054h,059h,0feh,0a7h,039h,054h,045h	; 885e  ISK.UTILITY..9TE
	defb 04eh,04eh,049h,053h,000h,041h,04eh,044h,000h,048h,04fh,043h,04bh,045h,059h,0feh	; 886e  NNIS.AND.HOCKEY.
	defb 0e7h,039h,042h,049h,04fh,052h,059h,054h,048h,04dh,0feh,027h,03ah,045h,04eh,044h	; 887e  .9BIORYTHM.':END
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h,026h,03ah	; 888e  .&9f9.9.9&:

; ======================================================================
; CODIGO 0x8899..0x88ad  (20 bytes)
; ======================================================================


L_8899:
	ld hl,0d317h		;8899
	ld a,(hl)			;889c
	or a			;889d
	jr nz,L_88A3		;889e
	ld (0d129h),a		;88a0
L_88A3:
	ld hl,0d301h		;88a3
	ld a,(0d141h)		;88a6
	ld (hl),a			;88a9
	jp L_9929		;88aa

; ----------------------------------------------------------------------
; DATOS sin identificar  0x88ad..0x88b0  (3 bytes)
DATA_88AD:
	defb 0cdh,09ch,089h	; 88ad

; ======================================================================
; CODIGO 0x88b0..0x891c  (108 bytes)
; ======================================================================


L_88B0:
	call 0a47fh		;88b0
	jp L_87D4		;88b3
L_88B6:
	ld hl,03921h		;88b6
	ld (0d16ch),hl		;88b9
	ld hl,0392ch		;88bc
	ld (0d16eh),hl		;88bf
	ret			;88c2
L_88C3:
	call L_945D		;88c3
	jp z,L_87D4		;88c6
	call L_8CED		;88c9
	ld a,021h		;88cc
	ld (0d136h),a		;88ce
	call L_8BFC		;88d1
	call L_9748		;88d4
	jp c,L_87D4		;88d7
	ld hl,09644h		;88da
	call L_9611		;88dd
	call L_8CED		;88e0
	call L_91B5		;88e3
	jp c,L_87D4		;88e6
	ld a,0ffh		;88e9
	ld (0d13dh),a		;88eb
	call L_899C		;88ee
	ld a,006h		;88f1
	call 00141h		;88f3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;88f6
	jp nz,L_8901		;88f8
	call L_84B0		;88fb
	call L_9116		;88fe
L_8901:
	xor a			;8901
	ld (0d13dh),a		;8902
	jp L_88B0		;8905
L_8908:
	call L_8CED		;8908
	ld hl,0894eh		;890b
	call 0a524h		;890e
L_8911:
	ld hl,08996h		;8911
	ld b,002h		;8914
	call 0a7b2h		;8916
	call 0a510h		;8919

; ----------------------------------------------------------------------
; DATOS saltos_891C: tabla de 2 palabras del despachador (call 0x408D en
;   0x8919); lo leen el despachador (4 bytes)
;   0x891c..0x8920  (4 bytes)
DATA_saltos_891C:
	defb 020h,089h	; 891c
	defb 0d4h,087h	; 891e

; ======================================================================
; CODIGO 0x8920..0x894e  (46 bytes)
; ======================================================================


L_8920:
	call L_893A		;8920
	jr z,L_892A		;8923
	call L_893A		;8925
	jr z,L_8932		;8928
L_892A:
	ld hl,08973h		;892a
	call 0a524h		;892d
	jr $-31		;8930
L_8932:
	ld hl,08986h		;8932
	call 0a524h		;8935
	jr $-39		;8938
L_893A:
	ld c,00ch		;893a
	ld ix,04020h		;893c
	ld iy,(0d12dh)		;8940
	call 0001ch		;8944   ; BIOS CALSLT - Executes inter-slot call
	ld c,00dh		;8947
	call 0001ch		;8949   ; BIOS CALSLT - Executes inter-slot call
	and a			;894c
	ret			;894d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x894e..0x899c  (78 bytes)
DATA_894E:
	defb 0c6h,038h,040h,040h,052h,041h,04dh,000h,044h,049h,053h,04bh,000h,046h,04fh,052h	; 894e  .8@@RAM.DISK.FOR
	defb 04dh,041h,054h,040h,040h,0feh,027h,039h,046h,04fh,052h,04dh,041h,054h,0feh,067h	; 895e  MAT@@.'9FORMAT.g
	defb 039h,045h,04eh,044h,0ffh,0c9h,039h,046h,04fh,052h,041h,04dh,054h,000h,043h,04fh	; 896e  9END..9FORAMT.CO
	defb 04dh,050h,04ch,045h,054h,045h,044h,0ffh,0c9h,039h,046h,04fh,052h,041h,04dh,054h	; 897e  MPLETED..9FORAMT
	defb 000h,046h,041h,049h,04ch,045h,044h,0ffh,026h,039h,066h,039h,0a6h,039h	; 898e  .FAILED.&9f9.9

; ======================================================================
; CODIGO 0x899c..0x89b0  (20 bytes)
; ======================================================================


L_899C:
	call 0a578h		;899c
	ld hl,089c2h		;899f
	call 0a524h		;89a2
	ld hl,089f7h		;89a5
	ld b,002h		;89a8
	call 0a7b2h		;89aa
	call 0a510h		;89ad

; ----------------------------------------------------------------------
; DATOS saltos_89B0: tabla de 2 palabras del despachador (call 0x408D en
;   0x89AD); lo leen el despachador (4 bytes)
;   0x89b0..0x89b4  (4 bytes)
DATA_saltos_89B0:
	defb 0b4h,089h	; 89b0
	defb 0bfh,089h	; 89b2

; ======================================================================
; CODIGO 0x89b4..0x89c2  (14 bytes)
; ======================================================================


L_89B4:
	call 0a5efh		;89b4
	call 00156h		;89b7   ; BIOS KILBUF - Clears keyboard buffer
	call 0009fh		;89ba   ; BIOS CHGET - One character input (waiting)
	jr $-33		;89bd
L_89BF:
	jp 0a5efh		;89bf

; ----------------------------------------------------------------------
; DATOS sin identificar  0x89c2..0x89fb  (57 bytes)
DATA_89C2:
	defb 026h,03ah,040h,040h,053h,043h,052h,045h,045h,04eh,000h,044h,049h,053h,050h,04ch	; 89c2  &:@@SCREEN.DISPL
	defb 041h,059h,000h,04dh,04fh,044h,045h,040h,040h,0feh,067h,03ah,044h,049h,053h,050h	; 89d2  AY.MODE@@.g:DISP
	defb 04ch,041h,059h,000h,041h,04ch,04ch,000h,053h,043h,052h,045h,045h,04eh,0feh,087h	; 89e2  LAY.ALL.SCREEN..
	defb 03ah,045h,04eh,044h,0ffh,066h,03ah,086h,03ah	; 89f2  :END.f:.:

; ======================================================================
; CODIGO 0x89fb..0x8a20  (37 bytes)
; ======================================================================


L_89FB:
	call L_88B6		;89fb
	call L_99D3		;89fe
	call L_8CED		;8a01
	ld hl,08c34h		;8a04
	call 0a524h		;8a07
	ld de,0384dh		;8a0a
	call L_8644		;8a0d
	ld hl,08c85h		;8a10
	ld b,003h		;8a13
	call 0a7b2h		;8a15
	cp 0ffh		;8a18
	jp z,L_9921		;8a1a
	call 0a510h		;8a1d

; ----------------------------------------------------------------------
; DATOS saltos_8A20: tabla de 3 palabras del despachador (call 0x408D en
;   0x8A1D); lo leen el despachador (6 bytes)
;   0x8a20..0x8a26  (6 bytes)
DATA_saltos_8A20:
	defb 02bh,08ah	; 8a20
	defb 0a5h,08ah	; 8a22
	defb 030h,08ch	; 8a24

; ======================================================================
; CODIGO 0x8a26..0x8a79  (83 bytes)
; ======================================================================


L_8A26:
	ld a,(0d301h)		;8a26
	inc a			;8a29
	ret			;8a2a
L_8A2B:
	call L_8A26		;8a2b
	jr z,$-51		;8a2e
	ld a,(0d302h)		;8a30
	inc a			;8a33
	jr nz,L_8A3F		;8a34
	ld hl,(0d30ah)		;8a36
	ld a,h			;8a39
	or l			;8a3a
	jr z,$-64		;8a3b
	jr L_8A47		;8a3d
L_8A3F:
	ld hl,09f11h		;8a3f
	call L_9AA4		;8a42
	jr nz,$-74		;8a45
L_8A47:
	call L_8CED		;8a47
	ld hl,08a79h		;8a4a
	call 0a524h		;8a4d
	ld hl,03974h		;8a50
	call L_8C8D		;8a53
	jp z,L_8C27		;8a56
	ld hl,0d31ah		;8a59
	call L_8CF7		;8a5c
	jp z,L_8C27		;8a5f
	ld hl,0d31bh		;8a62
	call L_8D1E		;8a65
	ld hl,(0d314h)		;8a68
	ld a,h			;8a6b
	or l			;8a6c
	ld hl,0d317h		;8a6d
	jr z,L_8A74		;8a70
	set 2,(hl)		;8a72
L_8A74:
	set 1,(hl)		;8a74
	jp L_8C27		;8a76

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a79..0x8aa5  (44 bytes)
DATA_8A79:
	defb 0c5h,038h,040h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,053h,054h,041h,047h	; 8a79  .8@@@MODIFY.STAG
	defb 045h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,040h,0feh,067h,039h,053h,054h	; 8a89  E.NUMBER@@@.g9ST
	defb 041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh	; 8a99  AGE.NUMBER>.

; ======================================================================
; CODIGO 0x8aa5..0x8af8  (83 bytes)
; ======================================================================


L_8AA5:
	call L_8A26		;8aa5
	jp z,L_89FB		;8aa8
	ld a,(0d302h)		;8aab
	inc a			;8aae
	jr nz,L_8ABB		;8aaf
	ld hl,(0d308h)		;8ab1
	ld a,h			;8ab4
	or l			;8ab5
	jp z,L_89FB		;8ab6
	jr L_8AC4		;8ab9
L_8ABB:
	ld hl,09ee0h		;8abb
	call L_9AA4		;8abe
	jp nz,L_89FB		;8ac1
L_8AC4:
	call L_8CED		;8ac4
	ld hl,08af8h		;8ac7
	call 0a524h		;8aca
	ld hl,03975h		;8acd
	call L_8C8D		;8ad0
	jp z,L_8C27		;8ad3
	ld hl,0d318h		;8ad6
	call L_8CF7		;8ad9
	jp z,L_8C27		;8adc
	ld hl,0d319h		;8adf
	call L_8D1E		;8ae2
	ld hl,0d317h		;8ae5
	set 0,(hl)		;8ae8
	ld de,(0d314h)		;8aea
	ld a,d			;8aee
	or e			;8aef
	jp z,L_8C27		;8af0
	set 2,(hl)		;8af3
	jp L_8C27		;8af5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8af8..0x8bfc  (260 bytes)
DATA_8AF8:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h	; 8af8  .8@@MODIFY.PLAYE
	defb 052h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,0feh,067h,039h,050h,04ch,041h	; 8b08  R.NUMBER@@.g9PLA
	defb 059h,045h,052h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh,0cdh,026h,08ah,0cah	; 8b18  YER.NUMBER>..&..
	defb 0fbh,089h,02ah,00eh,0d3h,07ch,0b5h,0cah,0fbh,089h,0cdh,0edh,08ch,021h,060h,08bh	; 8b28  ..*..|.......!`.
	defb 0cdh,024h,0a5h,021h,09fh,08bh,006h,003h,0cdh,0b2h,0a7h,0cdh,010h,0a5h,0d6h,08bh	; 8b38  .$.!............
	defb 04ch,08bh,027h,08ch,0cdh,0a5h,08bh,021h,017h,0d3h,0cbh,0feh,0c3h,027h,08ch,04bh	; 8b48  L.'....!.....'.K
	defb 04fh,04eh,041h,04dh,049h,000h,000h,001h,0c6h,038h,040h,040h,052h,041h,04eh,04bh	; 8b58  ONAMI....8@@RANK
	defb 049h,04eh,047h,000h,04dh,04fh,044h,045h,040h,040h,0feh,027h,039h,04ch,04fh,041h	; 8b68  ING.MODE@@.'9LOA
	defb 044h,000h,044h,049h,053h,04bh,000h,044h,041h,054h,041h,0feh,067h,039h,043h,04ch	; 8b78  D.DISK.DATA.g9CL
	defb 045h,041h,052h,000h,052h,041h,04eh,04bh,049h,04eh,047h,000h,044h,041h,054h,041h	; 8b88  EAR.RANKING.DATA
	defb 0feh,0a7h,039h,045h,04eh,044h,0ffh,026h,039h,066h,039h,0a6h,039h,021h,059h,0d4h	; 8b98  ..9END.&9f9.9!Y.
	defb 011h,05ah,0d4h,036h,000h,001h,01dh,000h,0edh,0b0h,021h,077h,0d4h,011h,078h,0d4h	; 8ba8  .Z.6......!w..x.
	defb 036h,03ch,001h,059h,000h,0edh,0b0h,011h,078h,0d4h,021h,057h,08bh,001h,006h,000h	; 8bb8  6<.Y....x.!W....
	defb 0edh,0b0h,011h,059h,0d4h,021h,05dh,08bh,001h,003h,000h,0edh,0b0h,0c9h,0cdh,05dh	; 8bc8  ...Y.!]........]
	defb 094h,0cah,03bh,08bh,03eh,023h,032h,036h,0d1h,0cdh,0fch,08bh,0cdh,048h,097h,0dah	; 8bd8  ....>#26.....H..
	defb 032h,08bh,021h,044h,096h,0cdh,011h,096h,0cdh,0edh,08ch,0cdh,0cdh,091h,0d2h,04fh	; 8be8  2.!D...........O
	defb 08bh,0c3h,032h,08bh	; 8bf8

; ======================================================================
; CODIGO 0x8bfc..0x8c34  (56 bytes)
; ======================================================================


L_8BFC:
	call L_8CED		;8bfc
	call L_88B6		;8bff
	call L_86F8		;8c02
	call L_873C		;8c05
	call L_8780		;8c08
	ld hl,0965dh		;8c0b
	call L_9611		;8c0e
	xor a			;8c11
	ld (0d163h),a		;8c12
	ld (0d165h),a		;8c15
	ld hl,0396ch		;8c18
	ld (0d168h),hl		;8c1b
	ld (0d16ah),hl		;8c1e
	ld a,080h		;8c21
	ld (0d164h),a		;8c23
	ret			;8c26
L_8C27:
	call L_99D3		;8c27
	call L_8CED		;8c2a
	jp L_89FB		;8c2d
L_8C30:
	di			;8c30
	jp L_9968		;8c31

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8c34..0x8c8d  (89 bytes)
DATA_8C34:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,04dh,04fh,044h,045h,000h	; 8c34  .8@@MODIFY.MODE.
	defb 04dh,045h,04eh,055h,040h,040h,0feh,027h,039h,04dh,04fh,044h,049h,046h,059h,000h	; 8c44  MENU@@.'9MODIFY.
	defb 053h,054h,041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,0feh,067h,039h,04dh	; 8c54  STAGE.NUMBER.g9M
	defb 04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h,052h,000h,04eh,055h,04dh	; 8c64  ODIFY.PLAYER.NUM
	defb 042h,045h,052h,0feh,0a7h,039h,053h,054h,041h,052h,054h,000h,047h,041h,04dh,045h	; 8c74  BER..9START.GAME
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h	; 8c84  .&9f9.9.9

; ======================================================================
; CODIGO 0x8c8d..0x8cc7  (58 bytes)
; ======================================================================


L_8C8D:
	ld a,0ffh		;8c8d
	ld b,002h		;8c8f
	jp 0a65fh		;8c91
L_8C94:
	call 0a47fh		;8c94
	ld de,03800h		;8c97
	ld b,010h		;8c9a
L_8C9C:
	push bc			;8c9c
	push de			;8c9d
	ld bc,00020h		;8c9e
	ld hl,08ccdh		;8ca1
	call 0005ch		;8ca4   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;8ca7
	ld bc,00020h		;8ca8
	add hl,bc			;8cab
	ex de,hl			;8cac
	pop bc			;8cad
	djnz L_8C9C		;8cae
	ld hl,03a07h		;8cb0
	ld bc,00810h		;8cb3
	ld a,00fh		;8cb6
	call 0a53bh		;8cb8
	ld de,03af9h		;8cbb
	ld hl,08cc7h		;8cbe
	ld bc,00006h		;8cc1
	jp 0005ch		;8cc4   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8cc7..0x8ced  (38 bytes)
DATA_8CC7:
	defb 088h,089h,08ah,08bh,08ch,08dh,080h,00eh,00eh,00eh,084h,00ah,00ah,00ah,00ah,081h	; 8cc7  ................
	defb 007h,007h,007h,085h,00ch,00ch,00ch,00ch,082h,00dh,00dh,00dh,086h,006h,006h,006h	; 8cd7  ................
	defb 006h,083h,004h,004h,004h,087h	; 8ce7

; ======================================================================
; CODIGO 0x8ced..0x8d87  (154 bytes)
; ======================================================================


L_8CED:
	ld hl,03880h		;8ced
	ld bc,00200h		;8cf0
	xor a			;8cf3
	jp 00056h		;8cf4   ; BIOS FILVRM - Fills VRAM with value
L_8CF7:
	xor a			;8cf7
	ld (hl),a			;8cf8
	ld a,(0d163h)		;8cf9
	or a			;8cfc
	ret z			;8cfd
	ld de,0d142h		;8cfe
	cp 001h		;8d01
	jr nz,L_8D0B		;8d03
	ld a,(de)			;8d05
	and 00fh		;8d06
	ld (hl),a			;8d08
	or a			;8d09
	ret			;8d0a
L_8D0B:
	cp 002h		;8d0b
	ret nz			;8d0d
	ld a,(de)			;8d0e
	and 00fh		;8d0f
	add a,a			;8d11
	ld b,a			;8d12
	add a,a			;8d13
	add a,a			;8d14
	add a,b			;8d15
	ld b,a			;8d16
	inc de			;8d17
	ld a,(de)			;8d18
	and 00fh		;8d19
	add a,b			;8d1b
	ld (hl),a			;8d1c
	ret			;8d1d
L_8D1E:
	xor a			;8d1e
	ld (hl),a			;8d1f
	ld a,(0d163h)		;8d20
	or a			;8d23
	ret z			;8d24
	ld de,0d142h		;8d25
	cp 001h		;8d28
	jr nz,L_8D32		;8d2a
	ld a,(de)			;8d2c
	and 00fh		;8d2d
	ld (hl),a			;8d2f
	or a			;8d30
	ret			;8d31
L_8D32:
	cp 002h		;8d32
	ret nz			;8d34
	ld a,(de)			;8d35
	and 00fh		;8d36
	add a,a			;8d38
	add a,a			;8d39
	add a,a			;8d3a
	add a,a			;8d3b
	ld b,a			;8d3c
	inc de			;8d3d
	ld a,(de)			;8d3e
	and 00fh		;8d3f
	add a,b			;8d41
	ld (hl),a			;8d42
	ret			;8d43
L_8D44:
	ld hl,08d98h		;8d44
	ld de,0d814h		;8d47
	ld bc,0004dh		;8d4a
	ldir		;8d4d
	push de			;8d4f
	ld hl,(0d132h)		;8d50
	ld bc,00100h		;8d53
	call L_8D74		;8d56
	pop hl			;8d59
	ld bc,00100h		;8d5a
L_8D5D:
	ld a,09bh		;8d5d
	cpir		;8d5f
	ret nz			;8d61
	ret po			;8d62
	ld a,0fdh		;8d63
	cp (hl)			;8d65
	jr nz,L_8D5D		;8d66
	dec hl			;8d68
	ld de,08d87h		;8d69
	ex de,hl			;8d6c
	ld bc,00005h		;8d6d
	ldir		;8d70
	xor a			;8d72
	ret			;8d73
L_8D74:
	push bc			;8d74
	push de			;8d75
	ld a,(0d12fh)		;8d76
	call 0000ch		;8d79   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;8d7c
	pop bc			;8d7d
	ld (de),a			;8d7e
	inc hl			;8d7f
	inc de			;8d80
	dec bc			;8d81
	ld a,b			;8d82
	or c			;8d83
	jr nz,L_8D74		;8d84
	ret			;8d86

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d87..0x8d8c  (5 bytes)
DATA_8D87:
	defb 030h,0d1h,0cdh,014h,0d8h	; 8d87

; ======================================================================
; CODIGO 0x8d8c..0x8f4d  (449 bytes)
; ======================================================================


L_8D8C:
	ld hl,L_8DE5		;8d8c
	ld de,0d170h		;8d8f
	ld bc,0018eh		;8d92
	ldir		;8d95
	ret			;8d97
L_8D98:
	di			;8d98
	ld de,0fd00h		;8d99
	ld hl,0d961h		;8d9c
	ld bc,002cah		;8d9f
	ldir		;8da2
	ld a,0c3h		;8da4
	ld (0fd9ah),a		;8da6
	ld hl,0d2d8h		;8da9
	ld (0fd9bh),hl		;8dac
	pop hl			;8daf
	dec hl			;8db0
	dec hl			;8db1
	dec hl			;8db2
	ld de,0d861h		;8db3
	and a			;8db6
	sbc hl,de		;8db7
	ld de,(0d132h)		;8db9
	add hl,de			;8dbd
	jp (hl)			;8dbe
L_8DBF:
	ld hl,0fd00h		;8dbf
	ld de,0d961h		;8dc2
	ld bc,002cah		;8dc5
	ldir		;8dc8
	ld a,(0d12fh)		;8dca
	ld hl,04000h		;8dcd
	call 00024h		;8dd0   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0d861h		;8dd3
	ld hl,(0fedch)		;8dd6
	ld de,(0d132h)		;8dd9
	and a			;8ddd
	sbc hl,de		;8dde
	ld de,0d861h		;8de0
	add hl,de			;8de3
	jp (hl)			;8de4
L_8DE5:
	di			;8de5
	ld a,(0d13bh)		;8de6
	or a			;8de9
	ret nz			;8dea
	call 0013eh		;8deb   ; BIOS RDVDP - Reads VDP status register
	ld ix,(0d130h)		;8dee
	ld a,007h		;8df2
	call 00141h		;8df4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8df7
	and 010h		;8df8
	ld b,a			;8dfa
	ld a,008h		;8dfb
	call 00141h		;8dfd   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8e00
	rrca			;8e01
	and 006h		;8e02
	or b			;8e04
	ld hl,0d137h		;8e05
	ld c,(hl)			;8e08
	ld (hl),a			;8e09
	xor c			;8e0a
	and (hl)			;8e0b
	ld c,a			;8e0c
	di			;8e0d
	bit 4,a		;8e0e
	jr z,L_8E19		;8e10
	ld ix,08f73h		;8e12
	jp 0d214h		;8e16
L_8E19:
	ld a,(0d317h)		;8e19
	or a			;8e1c
	jr z,L_8E37		;8e1d
	ld hl,(0d304h)		;8e1f
	ld a,(hl)			;8e22
	ld hl,0d316h		;8e23
	cp (hl)			;8e26
	jr z,L_8E37		;8e27
	ld (hl),a			;8e29
	ld a,(0d312h)		;8e2a
	cp (hl)			;8e2d
	jr nz,L_8E37		;8e2e
	ld ix,099fah		;8e30
	jp 0d214h		;8e34
L_8E37:
	ld a,(0d332h)		;8e37
	or a			;8e3a
	jr z,L_8E5C		;8e3b
	push bc			;8e3d
	ld a,(0d339h)		;8e3e
	rra			;8e41
	jr c,L_8E64		;8e42
	ld hl,(0d30eh)		;8e44
	ld de,(0d310h)		;8e47
L_8E4B:
	push de			;8e4b
	ld de,0d31eh		;8e4c
	call 0d2bfh		;8e4f
	ld de,0d321h		;8e52
	pop hl			;8e55
	ld a,h			;8e56
	or l			;8e57
	call nz,0d2bfh		;8e58
	pop bc			;8e5b
L_8E5C:
	ld a,(0d134h)		;8e5c
	rra			;8e5f
	jr c,L_8E7E		;8e60
	jp (ix)		;8e62
L_8E64:
	ld hl,(0d30eh)		;8e64
	ld de,0d335h		;8e67
	call 0d2b6h		;8e6a
	ld hl,(0d310h)		;8e6d
	ld de,0d338h		;8e70
	call 0d2b6h		;8e73
	ld hl,0d333h		;8e76
	ld de,0d336h		;8e79
	jr L_8E4B		;8e7c
L_8E7E:
	ld a,(0d135h)		;8e7e
	cp 002h		;8e81
	jr z,L_8EB9		;8e83
	ld ix,08fe8h		;8e85
L_8E89:
	push ix		;8e89
	ld a,(0d12eh)		;8e8b
	ld h,040h		;8e8e
	push af			;8e90
	call 00024h		;8e91   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;8e94
	ld h,080h		;8e95
	call 00024h		;8e97   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop ix		;8e9a
	ld a,002h		;8e9c
	ld (08000h),a		;8e9e
	inc a			;8ea1
	ld (0a000h),a		;8ea2
	call L_8EB7		;8ea5
	ld a,(0d12fh)		;8ea8
	ld h,040h		;8eab
	push af			;8ead
	call 00024h		;8eae   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;8eb1
	ld h,080h		;8eb2
	jp 00024h		;8eb4   ; BIOS ENASLT - Switches to specified slot and page definitively
L_8EB7:
	jp (ix)		;8eb7
L_8EB9:
	ld hl,0d13ah		;8eb9
	ld de,0d139h		;8ebc
	bit 1,c		;8ebf
	jr z,L_8EE3		;8ec1
	ld a,(hl)			;8ec3
	or a			;8ec4
	ret z			;8ec5
	sub 00dh		;8ec6
	jr z,L_8ECC		;8ec8
	jr nc,L_8EDF		;8eca
L_8ECC:
	push hl			;8ecc
	push de			;8ecd
	ld ix,08fc0h		;8ece
	call 0d214h		;8ed2
	ld ix,08f88h		;8ed5
	call 0d214h		;8ed9
	pop de			;8edc
	pop hl			;8edd
	xor a			;8ede
L_8EDF:
	ld (hl),a			;8edf
	xor a			;8ee0
	ld (de),a			;8ee1
	ret			;8ee2
L_8EE3:
	bit 2,c		;8ee3
	jr z,L_8EFF		;8ee5
	ld a,00dh		;8ee7
	add a,(hl)			;8ee9
	jr nc,L_8EEE		;8eea
	ld a,0ffh		;8eec
L_8EEE:
	ld (hl),a			;8eee
	cp 00dh		;8eef
	jr nz,L_8EFC		;8ef1
	push de			;8ef3
	ld ix,0902eh		;8ef4
	call 0d214h		;8ef8
	pop de			;8efb
L_8EFC:
	xor a			;8efc
	ld (de),a			;8efd
	ret			;8efe
L_8EFF:
	ld a,(hl)			;8eff
	or a			;8f00
	jr z,L_8F24		;8f01
	ld a,(de)			;8f03
	add a,(hl)			;8f04
	ld (de),a			;8f05
	ret nc			;8f06
	jp (ix)		;8f07
L_8F09:
	ld a,(0d12fh)		;8f09
	ld h,080h		;8f0c
	call 00024h		;8f0e   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld iy,(0d12eh)		;8f11
	ld ix,(0d130h)		;8f15
	call 0001ch		;8f19   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0d12eh)		;8f1c
	ld h,080h		;8f1f
	jp 00024h		;8f21   ; BIOS ENASLT - Switches to specified slot and page definitively
L_8F24:
	ld ix,08f88h		;8f24
	jp 0d214h		;8f28
L_8F2B:
	ld b,003h		;8f2b
L_8F2D:
	ld a,(hl)			;8f2d
	ld (de),a			;8f2e
	inc hl			;8f2f
	dec de			;8f30
	djnz L_8F2D		;8f31
	ret			;8f33
L_8F34:
	inc hl			;8f34
	inc hl			;8f35
	push hl			;8f36
	push de			;8f37
	ld b,003h		;8f38
L_8F3A:
	ld a,(de)			;8f3a
	cp (hl)			;8f3b
	jr c,L_8F45		;8f3c
	dec hl			;8f3e
	dec de			;8f3f
	djnz L_8F3A		;8f40
	pop de			;8f42
	pop hl			;8f43
	ret			;8f44
L_8F45:
	pop de			;8f45
	pop hl			;8f46
	ld bc,00003h		;8f47
	lddr		;8f4a
	ret			;8f4c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8f4d..0x8f73  (38 bytes)
DATA_8F4D:
	defb 021h,000h,000h,039h,011h,080h,0dfh,001h,080h,000h,0edh,0b0h,031h,080h,0dfh,021h	; 8f4d  !..9........1..!
	defb 000h,0d5h,011h,000h,0f1h,001h,014h,003h,0edh,0b0h,03eh,0c9h,032h,09fh,0fdh,021h	; 8f5d  ..........>.2..!
	defb 070h,0d1h,022h,09bh,0fdh,0c9h	; 8f6d

; ======================================================================
; CODIGO 0x8f73..0x9140  (461 bytes)
; ======================================================================


L_8F73:
	call 0013eh		;8f73   ; BIOS RDVDP - Reads VDP status register
	ld hl,0d134h		;8f76
	inc (hl)			;8f79
	ld a,(hl)			;8f7a
	rra			;8f7b
	jr nc,L_8FD9		;8f7c
	xor a			;8f7e
	ld (0d135h),a		;8f7f
	call 00132h		;8f82   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call L_8FC0		;8f85
L_8F88:
	ld e,000h		;8f88
	ld a,008h		;8f8a
	call 00093h		;8f8c   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;8f8f
	call 00093h		;8f90   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;8f93
	call 00093h		;8f94   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d4d4h)		;8f97
	and a			;8f9a
	ret z			;8f9b
	ld e,03fh		;8f9c
	ld a,(0d12fh)		;8f9e
	ld hl,l9000h		;8fa1
	call 00014h		;8fa4   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,000h		;8fa7
	ld a,(0d12fh)		;8fa9
	ld hl,0988fh		;8fac
	call 00014h		;8faf   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;8fb2
	ld e,a			;8fb5
	ld a,(0d12fh)		;8fb6
	ld hl,l9000h		;8fb9
	call 00014h		;8fbc   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;8fbf
L_8FC0:
	ld a,008h		;8fc0
	call 00096h		;8fc2   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12bh),a		;8fc5
	ld a,009h		;8fc8
	call 00096h		;8fca   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12ch),a		;8fcd
	ld a,00ah		;8fd0
	call 00096h		;8fd2   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12dh),a		;8fd5
	ret			;8fd8
L_8FD9:
	ld (hl),000h		;8fd9
	ld a,0ffh		;8fdb
	call 00132h		;8fdd   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call L_902E		;8fe0
	xor a			;8fe3
	ld (0d135h),a		;8fe4
	ret			;8fe7
L_8FE8:
	ld a,001h		;8fe8
	ld (0d13bh),a		;8fea
	call L_8FF5		;8fed
	xor a			;8ff0
	ld (0d13bh),a		;8ff1
	ret			;8ff4
L_8FF5:
	call L_8F88		;8ff5
	ld ix,(0d130h)		;8ff8
	ld iy,(0d12eh)		;8ffc
L_9000:
	ld a,(0d135h)		;9000
	or a			;9003
	jp nz,L_8487		;9004
	call L_9072		;9007
	ld a,c			;900a
	rla			;900b
	jr c,L_9022		;900c
	rla			;900e
	jr c,L_9028		;900f
	rla			;9011
	jr c,L_9015		;9012
	ret			;9014
L_9015:
	ld a,002h		;9015
	ld (0d135h),a		;9017
	xor a			;901a
	ld (0d13ah),a		;901b
	ld (0d139h),a		;901e
	ret			;9021
L_9022:
	call L_902E		;9022
	jp 0d294h		;9025
L_9028:
	ld a,001h		;9028
	ld (0d135h),a		;902a
	ret			;902d
L_902E:
	ld a,(0d12bh)		;902e
	ld e,a			;9031
	ld a,008h		;9032
	call 00093h		;9034   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d12ch)		;9037
	ld e,a			;903a
	ld a,009h		;903b
	call 00093h		;903d   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d12dh)		;9040
	ld e,a			;9043
	ld a,00ah		;9044
	call 00093h		;9046   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d4d4h)		;9049
	and a			;904c
	ret z			;904d
	ld e,03fh		;904e
	ld a,(0d12fh)		;9050
	ld hl,l9000h		;9053
	call 00014h		;9056   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,01fh		;9059
	ld a,(0d12fh)		;905b
	ld hl,0988fh		;905e
	call 00014h		;9061   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;9064
	ld e,a			;9067
	ld a,(0d12fh)		;9068
	ld hl,l9000h		;906b
	call 00014h		;906e   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;9071
L_9072:
	ld a,001h		;9072
	call 00141h		;9074   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9077
	and 080h		;9078
	ld d,a			;907a
	ld a,006h		;907b
	call 00141h		;907d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9080
	and 0e2h		;9081
	bit 1,a		;9083
	jr z,L_9089		;9085
	or 008h		;9087
L_9089:
	and 0e8h		;9089
	ld e,a			;908b
	ld a,007h		;908c
	call 00141h		;908e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9091
	and 007h		;9092
	or e			;9094
	rlca			;9095
	rlca			;9096
	rlca			;9097
	or d			;9098
	ld hl,0d138h		;9099
	ld c,(hl)			;909c
	ld (hl),a			;909d
	xor c			;909e
	and (hl)			;909f
	ld c,a			;90a0
	ret			;90a1
L_90A2:
	ld (0d127h),sp		;90a2
	call L_939A		;90a6
	ld hl,0c000h		;90a9
	ld de,0d500h		;90ac
	ld bc,00900h		;90af
	ldir		;90b2
	call L_94CE		;90b4
	call L_9482		;90b7
	call L_92EF		;90ba
	call L_94DE		;90bd
	ld hl,0d500h		;90c0
	ld de,0c000h		;90c3
	ld bc,00900h		;90c6
	ldir		;90c9
	jp L_93B1		;90cb
L_90CE:
	ld (0d127h),sp		;90ce
	call L_939A		;90d2
	call L_94CE		;90d5
	call L_9482		;90d8
	call L_91F6		;90db
	call L_92EF		;90de
	ld de,0c000h		;90e1
	ld c,01ah		;90e4
	call 0f37dh		;90e6
	di			;90e9
	ld hl,00000h		;90ea
	add hl,sp			;90ed
	push hl			;90ee
	ld hl,00000h		;90ef
	add hl,sp			;90f2
	ld de,0c000h		;90f3
	ld bc,00082h		;90f6
	ldir		;90f9
	pop hl			;90fb
	ei			;90fc
	ld hl,00082h		;90fd
	call L_94FE		;9100
	pop hl			;9103
	call L_94DE		;9104
	call L_944F		;9107
	call L_94BE		;910a
	call L_9482		;910d
	call L_9242		;9110
	jp L_93B1		;9113
L_9116:
	ld (0d127h),sp		;9116
	call L_939A		;911a
	ld hl,0d100h		;911d
	ld (0d125h),hl		;9120
	call L_944F		;9123
	ld de,0d109h		;9126
	ld hl,09140h		;9129
	ld bc,00003h		;912c
	ldir		;912f
	call L_94CE		;9131
	call L_9482		;9134
	call L_9336		;9137
	call L_94DE		;913a
	jp L_93B1		;913d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9140..0x9143  (3 bytes)
DATA_9140:
	defb 056h,052h,04dh	; 9140

; ======================================================================
; CODIGO 0x9143..0x9281  (318 bytes)
; ======================================================================


L_9143:
	ld (0d127h),sp		;9143
	call L_939A		;9147
	call L_94CE		;914a
	call L_9482		;914d
	call L_9C17		;9150
	call L_921F		;9153
	call L_94DE		;9156
	jp L_93B1		;9159
L_915C:
	ld (0d127h),sp		;915c
	call L_939A		;9160
	call L_94CE		;9163
	call L_9482		;9166
	call L_922D		;9169
	call L_94DE		;916c
	jp L_93B1		;916f
L_9172:
	ld (0d127h),sp		;9172
	call L_939A		;9176
	call L_94BE		;9179
	call L_9482		;917c
	ld hl,01100h		;917f
	call L_94B1		;9182
	call L_928F		;9185
	ld de,0c000h		;9188
	ld c,01ah		;918b
	call 0f37dh		;918d
	ld hl,00082h		;9190
	call L_94EE		;9193
	ld hl,(0c000h)		;9196
	ld sp,hl			;9199
	ld de,0c002h		;919a
	ex de,hl			;919d
	ld bc,00080h		;919e
	ldir		;91a1
	ld hl,00000h		;91a3
	call L_94B1		;91a6
	call L_9242		;91a9
	call L_8F88		;91ac
	call L_8FC0		;91af
	jp L_93B1		;91b2
L_91B5:
	ld (0d127h),sp		;91b5
	call L_939A		;91b9
	call L_94BE		;91bc
	call L_9482		;91bf
	call L_928F		;91c2
	jp z,L_93B1		;91c5
	call L_93B1		;91c8
	scf			;91cb
	ret			;91cc
L_91CD:
	ld (0d127h),sp		;91cd
	call L_939A		;91d1
	call L_94BE		;91d4
	call L_9482		;91d7
	call L_9250		;91da
	call L_9B75		;91dd
	jp L_93B1		;91e0
L_91E3:
	ld (0d127h),sp		;91e3
	call L_939A		;91e7
	call L_94BE		;91ea
	call L_9482		;91ed
	call L_925E		;91f0
	jp L_93B1		;91f3
L_91F6:
	ld hl,0c000h		;91f6
	ld b,022h		;91f9
L_91FB:
	push hl			;91fb
	push bc			;91fc
	ld bc,00080h		;91fd
	call L_920C		;9200
	pop bc			;9203
	pop hl			;9204
	ld de,00080h		;9205
	add hl,de			;9208
	djnz L_91FB		;9209
	ret			;920b
L_920C:
	push bc			;920c
	ld de,0c000h		;920d
	ldir		;9210
	ld de,0c000h		;9212
	ld c,01ah		;9215
	call 0f37dh		;9217
	pop hl			;921a
	call L_94FE		;921b
	ret			;921e
L_921F:
	ld de,0d459h		;921f
	ld c,01ah		;9222
	call 0f37dh		;9224
	ld hl,00078h		;9227
	jp L_94FE		;922a
L_922D:
	ld hl,(0d30ch)		;922d
	ld bc,02000h		;9230
	and a			;9233
	sbc hl,bc		;9234
	ex de,hl			;9236
	ld c,01ah		;9237
	call 0f37dh		;9239
	ld hl,00003h		;923c
	jp L_94FE		;923f
L_9242:
	ld de,0c000h		;9242
	ld c,01ah		;9245
	call 0f37dh		;9247
	ld hl,01100h		;924a
	jp L_94EE		;924d
L_9250:
	ld de,0d459h		;9250
	ld c,01ah		;9253
	call 0f37dh		;9255
	ld hl,00078h		;9258
	jp L_94EE		;925b
L_925E:
	ld hl,(0d30ch)		;925e
	ld bc,02000h		;9261
	and a			;9264
	sbc hl,bc		;9265
	ex de,hl			;9267
	ld c,01ah		;9268
	call 0f37dh		;926a
	ld hl,00003h		;926d
	jp L_94EE		;9270
L_9273:
	ld de,0c000h		;9273
	ld c,01ah		;9276
	call 0f37dh		;9278
	ld hl,01000h		;927b
	jp L_94FE		;927e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9281..0x928f  (14 bytes)
DATA_9281:
	defb 011h,000h,0c0h,00eh,01ah,0cdh,07dh,0f3h,021h,000h,010h,0c3h,0eeh,094h	; 9281  ......}.!.....

; ======================================================================
; CODIGO 0x928f..0x9439  (426 bytes)
; ======================================================================


L_928F:
	call L_92C0		;928f
	ret nz			;9292
	call L_9298		;9293
	xor a			;9296
	ret			;9297
L_9298:
	ld de,00000h		;9298
L_929B:
	push de			;929b
	call L_9536		;929c
	push hl			;929f
	ld de,0c000h		;92a0
	ld c,01ah		;92a3
	call 0f37dh		;92a5
	pop hl			;92a8
	call L_94EE		;92a9
	pop de			;92ac
	ld hl,0c000h		;92ad
	push de			;92b0
	call 0a4cfh		;92b1
	pop de			;92b4
	ld hl,00080h		;92b5
	add hl,de			;92b8
	ex de,hl			;92b9
	ld a,d			;92ba
	cp 040h		;92bb
	jr nz,L_929B		;92bd
	ret			;92bf
L_92C0:
	ld de,0c000h		;92c0
	ld c,01ah		;92c3
	call 0f37dh		;92c5
	ld hl,00009h		;92c8
	call L_94EE		;92cb
	ld hl,0c001h		;92ce
	ld e,008h		;92d1
	ld c,000h		;92d3
	call L_92E3		;92d5
	ld a,(0c000h)		;92d8
	ld (0d4d2h),a		;92db
	and a			;92de
	ret z			;92df
	or 0ffh		;92e0
	ret			;92e2
L_92E3:
	push bc			;92e3
	ld b,(hl)			;92e4
	inc hl			;92e5
	call 00047h		;92e6   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;92e9
	inc c			;92ea
	dec e			;92eb
	jr nz,L_92E3		;92ec
	ret			;92ee
L_92EF:
	ld de,0c000h		;92ef
	ld c,01ah		;92f2
	call 0f37dh		;92f4
	xor a			;92f7
	ld de,0c000h		;92f8
	ld (de),a			;92fb
	inc de			;92fc
	ld hl,0f3dfh		;92fd
	ld bc,00008h		;9300
	ldir		;9303
	ld hl,00009h		;9305
	call L_94FE		;9308
	ld hl,00000h		;930b
L_930E:
	push hl			;930e
	ld de,0c442h		;930f
	ld bc,00080h		;9312
	call 00059h		;9315   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call 0a829h		;9318
	ld de,0c000h		;931b
	ld c,01ah		;931e
	call 0f37dh		;9320
	ld hl,(0c000h)		;9323
	inc hl			;9326
	inc hl			;9327
	call L_94FE		;9328
	pop hl			;932b
	ld de,00080h		;932c
	add hl,de			;932f
	ld a,h			;9330
	cp 040h		;9331
	jr nz,L_930E		;9333
	ret			;9335
L_9336:
	ld a,0feh		;9336
	call L_9513		;9338
	ld hl,00000h		;933b
	call L_952D		;933e
	ld hl,03fffh		;9341
	call L_952D		;9344
	ld hl,00000h		;9347
	call L_952D		;934a
	ld hl,02000h		;934d
	ld b,018h		;9350
L_9352:
	push bc			;9352
	call L_937E		;9353
	pop bc			;9356
	djnz L_9352		;9357
	ld hl,03800h		;9359
	ld b,008h		;935c
L_935E:
	push bc			;935e
	call L_937E		;935f
	pop bc			;9362
	djnz L_935E		;9363
	ld hl,00000h		;9365
	ld b,018h		;9368
L_936A:
	push bc			;936a
	call L_937E		;936b
	pop bc			;936e
	djnz L_936A		;936f
	ld hl,01800h		;9371
	ld b,008h		;9374
L_9376:
	push bc			;9376
	call L_937E		;9377
	pop bc			;937a
	djnz L_9376		;937b
	ret			;937d
L_937E:
	ld bc,00100h		;937e
	push hl			;9381
	push bc			;9382
	ld de,0c000h		;9383
	call 00059h		;9386   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,0c000h		;9389
	ld c,01ah		;938c
	call 0f37dh		;938e
	pop hl			;9391
	push hl			;9392
	call L_94FE		;9393
	pop bc			;9396
	pop hl			;9397
	add hl,bc			;9398
	ret			;9399
L_939A:
	di			;939a
	call L_93D0		;939b
	ld hl,0f0ffh		;939e
	ld de,0f37fh		;93a1
	ld bc,01100h		;93a4
	lddr		;93a7
	ld hl,00000h		;93a9
	ld (0f1c0h),hl		;93ac
	ei			;93af
	ret			;93b0
L_93B1:
	di			;93b1
	ld bc,00200h		;93b2
L_93B5:
	push bc			;93b5
	call 0d4f0h		;93b6
	pop bc			;93b9
	dec bc			;93ba
	ld a,b			;93bb
	or c			;93bc
	jr nz,L_93B5		;93bd
	di			;93bf
	ld hl,0e280h		;93c0
	ld de,0e000h		;93c3
	ld bc,01100h		;93c6
	ldir		;93c9
	call L_93D0		;93cb
	ei			;93ce
	ret			;93cf
L_93D0:
	ld hl,0e000h		;93d0
	ld de,0c000h		;93d3
	ld bc,01100h		;93d6
L_93D9:
	push bc			;93d9
	ld b,(hl)			;93da
	ld a,(de)			;93db
	ld (hl),a			;93dc
	ld a,b			;93dd
	ld (de),a			;93de
	pop bc			;93df
	inc hl			;93e0
	inc de			;93e1
	dec bc			;93e2
	ld a,b			;93e3
	or c			;93e4
	jr nz,L_93D9		;93e5
	ret			;93e7
L_93E8:
	xor a			;93e8
	call 0a65fh		;93e9
	ld a,(0d163h)		;93ec
	or a			;93ef
	ret z			;93f0
	ld hl,0d100h		;93f1
	ld (0d125h),hl		;93f4
	ld d,h			;93f7
	ld e,l			;93f8
	ld (hl),020h		;93f9
	inc de			;93fb
	ld bc,00008h		;93fc
	ldir		;93ff
	xor a			;9401
	ld (de),a			;9402
	inc hl			;9403
	inc de			;9404
	ld bc,0001bh		;9405
	ldir		;9408
	ld de,0d100h		;940a
	ld (de),a			;940d
	inc de			;940e
	ld a,(0d163h)		;940f
	ld c,a			;9412
	ld b,000h		;9413
	ld hl,0d142h		;9415
	ldir		;9418
	call L_9421		;941a
	ld a,0ffh		;941d
	or a			;941f
	ret			;9420
L_9421:
	ld de,0d109h		;9421
	ld hl,09439h		;9424
	ld a,(0d136h)		;9427
	and 00fh		;942a
	call 0a3e6h		;942c
	ldi		;942f
	ld a,(0d301h)		;9431
	ex de,hl			;9434
	call L_943D		;9435
	ret			;9438

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9439..0x943d  (4 bytes)
DATA_9439:
	defb 048h,053h,047h,052h	; 9439

; ======================================================================
; CODIGO 0x943d..0x946b  (46 bytes)
; ======================================================================


L_943D:
	ld d,a			;943d
	and 0f0h		;943e
	rrca			;9440
	rrca			;9441
	rrca			;9442
	rrca			;9443
	or 030h		;9444
	ld (hl),a			;9446
	inc hl			;9447
	ld a,d			;9448
	and 00fh		;9449
	or 030h		;944b
	ld (hl),a			;944d
	ret			;944e
L_944F:
	ld hl,0d10ch		;944f
	ld de,0d10dh		;9452
	ld (hl),000h		;9455
	ld bc,00018h		;9457
	ldir		;945a
	ret			;945c
L_945D:
	ld a,(0d4f9h)		;945d
	and a			;9460
	jr nz,L_9469		;9461
	ld a,(0ffa7h)		;9463
	cp 0c9h		;9466
	ret			;9468
L_9469:
	xor a			;9469
	ret			;946a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x946b..0x9482  (23 bytes)
DATA_946B:
	defb 0edh,053h,025h,0d1h,0afh,012h,013h,001h,00bh,000h,0edh,0b0h,0afh,006h,019h,012h	; 946b  .S%.............
	defb 013h,010h,0fch,0c9h,022h,025h,0d1h	; 947b

; ======================================================================
; CODIGO 0x9482..0x949f  (29 bytes)
; ======================================================================


L_9482:
	ld hl,(0d125h)		;9482
	ld bc,0000ch		;9485
	add hl,bc			;9488
	ld (hl),b			;9489
	inc hl			;948a
	ld (hl),b			;948b
	inc hl			;948c
	ld bc,00001h		;948d
	ld (hl),c			;9490
	inc hl			;9491
	ld (hl),b			;9492
	ld bc,00011h		;9493
	add hl,bc			;9496
	ld b,005h		;9497
	xor a			;9499
L_949A:
	ld (hl),a			;949a
	inc hl			;949b
	djnz L_949A		;949c
	ret			;949e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x949f..0x94b1  (18 bytes)
DATA_949F:
	defb 02ah,025h,0d1h,001h,010h,000h,009h,07eh,023h,066h,06fh,0c9h,0edh,053h,025h,0d1h	; 949f  *%.....~#fo..S%.
	defb 018h,004h	; 94af

; ======================================================================
; CODIGO 0x94b1..0x956f  (190 bytes)
; ======================================================================


L_94B1:
	ld de,(0d125h)		;94b1
	ex de,hl			;94b5
	ld bc,00021h		;94b6
	add hl,bc			;94b9
	ld (hl),e			;94ba
	inc hl			;94bb
	ld (hl),d			;94bc
	ret			;94bd
L_94BE:
	ld de,(0d125h)		;94be
	ld c,00fh		;94c2
	call 0f37dh		;94c4
	ld c,000h		;94c7
	inc a			;94c9
	jp z,L_9541		;94ca
	ret			;94cd
L_94CE:
	ld de,(0d125h)		;94ce
	ld c,016h		;94d2
	call 0f37dh		;94d4
	ld c,001h		;94d7
	inc a			;94d9
	jp z,L_9541		;94da
	ret			;94dd
L_94DE:
	ld de,(0d125h)		;94de
	ld c,010h		;94e2
	call 0f37dh		;94e4
	ld c,002h		;94e7
	inc a			;94e9
	jp z,L_9541		;94ea
	ret			;94ed
L_94EE:
	ld de,(0d125h)		;94ee
	ld c,027h		;94f2
	call 0f37dh		;94f4
	ld c,003h		;94f7
	or a			;94f9
	jp nz,L_9541		;94fa
	ret			;94fd
L_94FE:
	ld de,(0d125h)		;94fe
	ld c,026h		;9502
	call 0f37dh		;9504
	ld c,004h		;9507
	or a			;9509
	jp nz,L_9541		;950a
	ret			;950d
L_950E:
	ld bc,L_94EE		;950e
	jr L_9516		;9511
L_9513:
	ld bc,L_94FE		;9513
L_9516:
	push af			;9516
	ld hl,00001h		;9517
	add hl,sp			;951a
	push bc			;951b
	ex de,hl			;951c
	ld c,01ah		;951d
	call 0f37dh		;951f
	pop bc			;9522
	call L_9528		;9523
	pop af			;9526
	ret			;9527
L_9528:
	ld hl,00001h		;9528
	push bc			;952b
	ret			;952c
L_952D:
	push hl			;952d
	ld a,l			;952e
	call L_9513		;952f
	pop hl			;9532
	ld a,h			;9533
	jr L_9513		;9534
L_9536:
	call L_950E		;9536
	ld l,a			;9539
	push hl			;953a
	call L_950E		;953b
	pop hl			;953e
	ld h,a			;953f
	ret			;9540
L_9541:
	push bc			;9541
	call L_93B1		;9542
	call 0a63ch		;9545
	call L_86F8		;9548
	call L_873C		;954b
	call L_863C		;954e
	ld hl,0956fh		;9551
	ld de,(0d16eh)		;9554
	push de			;9558
	call 0a520h		;9559
	pop hl			;955c
	ld bc,00040h		;955d
	add hl,bc			;9560
	ex de,hl			;9561
	pop bc			;9562
	call L_957E		;9563
	call 0a644h		;9566
	ld sp,(0d127h)		;9569
	scf			;956d
	ret			;956e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x956f..0x957e  (15 bytes)
DATA_956F:
	defb 040h,040h,044h,049h,053h,04bh,000h,045h,052h,052h,04fh,052h,040h,040h,0ffh	; 956f  @@DISK.ERROR@@.

; ======================================================================
; CODIGO 0x957e..0x95a6  (40 bytes)
; ======================================================================


L_957E:
	ld a,c			;957e
	add a,a			;957f
	ld hl,095b5h		;9580
	call 0a3e6h		;9583
	ld a,(hl)			;9586
	inc hl			;9587
	ld h,(hl)			;9588
	ld l,a			;9589
	push de			;958a
	call 0a520h		;958b
	pop hl			;958e
	ld bc,00040h		;958f
	add hl,bc			;9592
	ld de,095a6h		;9593
	ex de,hl			;9596
	call 0a520h		;9597
	call 00156h		;959a   ; BIOS KILBUF - Clears keyboard buffer
L_959D:
	ld a,007h		;959d
	call 00141h		;959f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rla			;95a2
	jr c,L_959D		;95a3
	ret			;95a5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x95a6..0x9611  (107 bytes)
DATA_95A6:
	defb 048h,049h,054h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh,045h,059h,0ffh,0c1h	; 95a6  HIT.RETURN.KEY..
	defb 095h,0d2h,095h,0e3h,095h,0efh,095h,0e3h,095h,001h,096h,03dh,046h,049h,04ch,045h	; 95b6  ...........=FILE
	defb 000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h,03dh,0ffh,03dh,054h,04fh,04fh	; 95c6  .NOT.FOUND=.=TOO
	defb 000h,04dh,041h,04eh,059h,000h,046h,049h,04ch,045h,053h,03dh,0ffh,03dh,044h,049h	; 95d6  .MANY.FILES=.=DI
	defb 053h,04bh,000h,046h,055h,04ch,04ch,03dh,0ffh,03dh,044h,049h,053h,04bh,000h,052h	; 95e6  SK.FULL=.=DISK.R
	defb 045h,041h,044h,000h,045h,052h,052h,04fh,052h,03dh,0ffh,03dh,044h,049h,053h,04bh	; 95f6  EAD.ERROR=.=DISK
	defb 000h,049h,04fh,000h,045h,052h,052h,04fh,052h,03dh,0ffh	; 9606  .IO.ERROR=.

; ======================================================================
; CODIGO 0x9611..0x9637  (38 bytes)
; ======================================================================


L_9611:
	ex de,hl			;9611
	ld hl,0d33eh		;9612
	push hl			;9615
	ld (0d33ch),hl		;9616
	ld hl,0d33ch		;9619
	ld (0d0a3h),hl		;961c
	pop hl			;961f
	push de			;9620
	ld de,09637h		;9621
	ld bc,0000dh		;9624
	ex de,hl			;9627
	ldir		;9628
	ld hl,0d343h		;962a
	ld a,(0d12eh)		;962d
	ld (hl),a			;9630
	inc hl			;9631
	pop de			;9632
	ld (hl),e			;9633
	inc hl			;9634
	ld (hl),d			;9635
	ret			;9636

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9637..0x9733  (252 bytes)
DATA_9637:
	defb 0fdh,0e5h,0ddh,0e5h,0f7h,000h,000h,000h,0ddh,0e1h,0fdh,0e1h,0c9h,0c5h,0cdh,0b1h	; 9637  ................
	defb 093h,0cdh,03ch,0a6h,0c1h,0cdh,074h,096h,0f5h,0cdh,044h,0a6h,0f1h,0dah,069h,095h	; 9647  ..<...t...D...i.
	defb 0cdh,09ah,093h,00eh,001h,0c9h,0c5h,0cdh,0b1h,093h,0c1h,0cdh,074h,096h,0dah,069h	; 9657  ............t..i
	defb 095h,0cdh,06eh,0a5h,0cdh,042h,085h,0cdh,09ah,093h,00eh,001h,0c9h,0c5h,0cdh,0f8h	; 9667  ..n..B..........
	defb 086h,0cdh,03ch,087h,0cdh,03ch,086h,021h,06fh,095h,0edh,05bh,06eh,0d1h,0cdh,020h	; 9677  ..<..<.!o..[n..
	defb 0a5h,0c1h,079h,0e6h,00eh,00fh,0feh,002h,038h,006h,0feh,006h,038h,046h,018h,006h	; 9687  ..y.....8...8F..
	defb 021h,0edh,096h,00fh,030h,003h,021h,0feh,096h,0ebh,02ah,06eh,0d1h,001h,040h,000h	; 9697  !...0.!...*n..@.
	defb 009h,0ebh,001h,011h,000h,0d5h,0cdh,05ch,000h,0e1h,001h,040h,000h,009h,0ebh,021h	; 96a7  .......\...@...!
	defb 00fh,097h,0d5h,0cdh,020h,0a5h,0e1h,001h,020h,000h,009h,011h,021h,097h,0ebh,0cdh	; 96b7  .... ... ...!...
	defb 020h,0a5h,0cdh,056h,001h,0cdh,09fh,000h,0feh,00dh,028h,006h,0feh,020h,028h,011h	; 96c7   ..V......(.. (.
	defb 018h,0f3h,0a7h,0c9h,02ah,06eh,0d1h,001h,040h,000h,009h,0ebh,00eh,005h,0cdh,07eh	; 96d7  ....*n..@......~
	defb 095h,0cdh,06eh,0a5h,037h,0c9h,03dh,057h,052h,049h,054h,045h,000h,050h,052h,04fh	; 96e7  ..n.7.=WRITE.PRO
	defb 054h,045h,043h,054h,045h,044h,03dh,03dh,044h,049h,053h,04bh,000h,04fh,046h,046h	; 96f7  TECTED==DISK.OFF
	defb 04ch,049h,04eh,045h,03dh,000h,000h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh	; 9707  LINE=...RETURN.K
	defb 045h,059h,040h,040h,052h,045h,054h,052h,059h,0ffh,053h,050h,041h,043h,045h,000h	; 9717  EY@@RETRY.SPACE.
	defb 04bh,045h,059h,000h,040h,040h,041h,042h,04fh,052h,054h,0ffh	; 9727  KEY.@@ABORT.

; ======================================================================
; CODIGO 0x9733..0x980e  (219 bytes)
; ======================================================================


L_9733:
	xor a			;9733
	ld (0d163h),a		;9734
	ld (0d165h),a		;9737
	ld hl,03a6ch		;973a
	ld (0d168h),hl		;973d
	ld (0d16ah),hl		;9740
	ld a,080h		;9743
	ld (0d164h),a		;9745
L_9748:
	call 0a74fh		;9748
	ld (0d127h),sp		;974b
	call L_9871		;974f
	call L_989B		;9752
	jp z,L_97EA		;9755
	call L_8542		;9758
	call 0a778h		;975b
L_975E:
	call L_9825		;975e
	call 00156h		;9761   ; BIOS KILBUF - Clears keyboard buffer
L_9764:
	ld hl,0d163h		;9764
	ld de,0d165h		;9767
	call 0009fh		;976a   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;976d
	jr z,L_97DA		;976f
	cp 01fh		;9771
	jr z,L_97A2		;9773
	cp 020h		;9775
	jr nz,L_9764		;9777
	ld a,(0d163h)		;9779
	ld hl,0d34eh		;977c
	cp (hl)			;977f
	ccf			;9780
	ret c			;9781
	call L_9903		;9782
	push hl			;9785
	call L_987E		;9786
	pop hl			;9789
	ld de,0d100h		;978a
	ld (0d125h),de		;978d
	inc de			;9791
	ld a,(0d129h)		;9792
	cp 001h		;9795
	ld bc,00008h		;9797
	jr nz,L_979E		;979a
	ld c,00bh		;979c
L_979E:
	ldir		;979e
	or a			;97a0
	ret			;97a1
L_97A2:
	ld a,(0d34eh)		;97a2
	cp (hl)			;97a5
	jr z,L_9764		;97a6
	inc (hl)			;97a8
	ld a,(de)			;97a9
	ld b,a			;97aa
	ld a,(hl)			;97ab
	sub b			;97ac
	cp 003h		;97ad
	jr c,L_97B9		;97af
	inc b			;97b1
	ld a,b			;97b2
	ld (de),a			;97b3
	ld bc,00000h		;97b4
	jr L_97BC		;97b7
L_97B9:
	ld bc,00020h		;97b9
L_97BC:
	call 0a788h		;97bc
	add hl,bc			;97bf
	push hl			;97c0
	ld de,(0d16ah)		;97c1
	and a			;97c5
	sbc hl,de		;97c6
	ld a,(0d164h)		;97c8
	ld d,000h		;97cb
	ld e,a			;97cd
	rst 20h			;97ce
	pop hl			;97cf
	jr nc,L_97D5		;97d0
	ld (0d168h),hl		;97d2
L_97D5:
	call 0a778h		;97d5
	jr L_975E		;97d8
L_97DA:
	ld a,(hl)			;97da
	or a			;97db
	jr z,L_9764		;97dc
	dec (hl)			;97de
	ex de,hl			;97df
	ld a,(de)			;97e0
	cp (hl)			;97e1
	jr nc,L_97E5		;97e2
	dec (hl)			;97e4
L_97E5:
	ld bc,0ffe0h		;97e5
	jr L_97BC		;97e8
L_97EA:
	ld hl,0980eh		;97ea
	ld de,(0d16ah)		;97ed
	call 0a520h		;97f1
	ld de,09816h		;97f4
	ld hl,(0d16ah)		;97f7
	ld bc,00040h		;97fa
	add hl,bc			;97fd
	ex de,hl			;97fe
	call 0a520h		;97ff
	call 00156h		;9802   ; BIOS KILBUF - Clears keyboard buffer
L_9805:
	call 0009fh		;9805   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;9808
	jr nz,L_9805		;980a
	scf			;980c
	ret			;980d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x980e..0x9825  (23 bytes)
DATA_980E:
	defb 04eh,04fh,000h,046h,049h,04ch,045h,0ffh,048h,049h,054h,000h,052h,045h,054h,055h	; 980e  NO.FILE.HIT.RETU
	defb 052h,04eh,000h,04bh,045h,059h,0ffh	; 981e

; ======================================================================
; CODIGO 0x9825..0x98e3  (190 bytes)
; ======================================================================


L_9825:
	ld a,(0d165h)		;9825
	call L_9903		;9828
	ld de,(0d16ah)		;982b
	inc de			;982f
	inc de			;9830
	ex de,hl			;9831
	ld b,003h		;9832
L_9834:
	push bc			;9834
	push hl			;9835
	push hl			;9836
	xor a			;9837
	ld bc,0000ch		;9838
	call 00056h		;983b   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;983e
	ld b,008h		;983f
L_9841:
	ld a,(de)			;9841
	cp 020h		;9842
	jr z,L_984A		;9844
	call 0004dh		;9846   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9849
L_984A:
	inc de			;984a
	djnz L_9841		;984b
	ld a,(0d129h)		;984d
	cp 001h		;9850
	jr nz,L_9868		;9852
	ld a,(de)			;9854
	or a			;9855
	jr z,L_985A		;9856
	ld a,03ch		;9858
L_985A:
	call 0004dh		;985a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;985d
	ld b,003h		;985e
L_9860:
	ld a,(de)			;9860
	call 0004dh		;9861   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;9864
	inc hl			;9865
	djnz L_9860		;9866
L_9868:
	pop hl			;9868
	ld bc,00020h		;9869
	add hl,bc			;986c
	pop bc			;986d
	djnz L_9834		;986e
	ret			;9870
L_9871:
	ld hl,0d351h		;9871
	ld de,0d352h		;9874
	ld (hl),000h		;9877
	ld bc,00107h		;9879
	ldir		;987c
L_987E:
	ld hl,0d100h		;987e
	ld de,0d101h		;9881
	ld (hl),000h		;9884
	ld bc,00024h		;9886
	ldir		;9889
	ld hl,0d101h		;988b
	ld de,0d102h		;988e
	ld (hl),03fh		;9891
	ld bc,0000ah		;9893
	ldir		;9896
	jp L_9421		;9898
L_989B:
	call L_939A		;989b
	xor a			;989e
	ld (0d34eh),a		;989f
	ld de,0d351h		;98a2
	ld c,01ah		;98a5
	call 0f37dh		;98a7
	ld de,0d100h		;98aa
	ld c,011h		;98ad
	call 0f37dh		;98af
	inc a			;98b2
	jr z,L_98DE		;98b3
L_98B5:
	ld hl,0d34eh		;98b5
	inc (hl)			;98b8
	push hl			;98b9
	call L_98EE		;98ba
	pop hl			;98bd
	ld a,(hl)			;98be
	cp 014h		;98bf
	jr z,L_98CE		;98c1
	ld de,0d100h		;98c3
	ld c,012h		;98c6
	call 0f37dh		;98c8
	inc a			;98cb
	jr nz,L_98B5		;98cc
L_98CE:
	ld a,(0d34eh)		;98ce
	push af			;98d1
	ld de,098e3h		;98d2
	call L_98F5		;98d5
	call L_93B1		;98d8
	pop af			;98db
	or a			;98dc
	ret			;98dd
L_98DE:
	call L_93B1		;98de
	xor a			;98e1
	ret			;98e2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x98e3..0x98ee  (11 bytes)
DATA_98E3:
	defb 040h,040h,045h,04eh,044h,040h,040h,000h,000h,000h,000h	; 98e3  @@END@@....

; ======================================================================
; CODIGO 0x98ee..0x994c  (94 bytes)
; ======================================================================


L_98EE:
	ld de,0d352h		;98ee
	ld a,(0d34eh)		;98f1
	dec a			;98f4
L_98F5:
	call L_9903		;98f5
	ex de,hl			;98f8
	ld bc,00008h		;98f9
	jr z,L_9900		;98fc
	ld c,00bh		;98fe
L_9900:
	ldir		;9900
	ret			;9902
L_9903:
	ld l,a			;9903
	ld h,000h		;9904
	ld a,(0d129h)		;9906
	cp 001h		;9909
	jr z,L_9912		;990b
	add hl,hl			;990d
	add hl,hl			;990e
	add hl,hl			;990f
	jr L_991B		;9910
L_9912:
	ld b,h			;9912
	ld c,l			;9913
	add hl,hl			;9914
	add hl,bc			;9915
	add hl,hl			;9916
	add hl,hl			;9917
	and a			;9918
	sbc hl,bc		;9919
L_991B:
	ld bc,0d372h		;991b
	add hl,bc			;991e
	or a			;991f
	ret			;9920
L_9921:
	call L_9952		;9921
	call 04058h		;9924
	jr L_993B		;9927
L_9929:
	call L_9952		;9929
	call 0404fh		;992c
	call 04061h		;992f
	call 04069h		;9932
	call 04071h		;9935
	call 04079h		;9938
L_993B:
	call 04081h		;993b
	call 04089h		;993e
	push af			;9941
	call 0a47fh		;9942
	call 04095h		;9945
	pop af			;9948
	call 0a510h		;9949

; ----------------------------------------------------------------------
; DATOS saltos_994C: tabla de 3 palabras del despachador (call 0x408D en
;   0x9949); lo leen el despachador (6 bytes)
;   0x994c..0x9952  (6 bytes)
DATA_saltos_994C:
	defb 059h,099h	; 994c
	defb 081h,099h	; 994e
	defb 08ch,099h	; 9950

; ======================================================================
; CODIGO 0x9952..0x99c2  (112 bytes)
; ======================================================================


L_9952:
	ld a,(0d13ch)		;9952
	ld (0e000h),a		;9955
	ret			;9958
L_9959:
	ld a,(0d13ch)		;9959
	inc a			;995c
	jr nz,$-34		;995d
	ld bc,00107h		;995f
	call 00047h		;9962   ; BIOS WRTVDP - Writes data in the VDP-register
	call 0a47fh		;9965
L_9968:
	di			;9968
	ld hl,0fd9ah		;9969
	ld a,0c9h		;996c
	ld b,00ah		;996e
L_9970:
	ld (hl),a			;9970
	inc hl			;9971
	djnz L_9970		;9972
	xor a			;9974
	ld (0d134h),a		;9975
	ld (0d13bh),a		;9978
	jp L_832C		;997b
L_997E:
	jp 040efh		;997e
L_9981:
	ld a,(0d13ch)		;9981
	inc a			;9984
	jp nz,L_993B		;9985
	ld a,002h		;9988
	jr L_998E		;998a
L_998C:
	ld a,001h		;998c
L_998E:
	ld (0d129h),a		;998e
	ld bc,00107h		;9991
	call 00047h		;9994   ; BIOS WRTVDP - Writes data in the VDP-register
	call 0a47fh		;9997
	call 04095h		;999a
	ld a,(0d129h)		;999d
	cp 002h		;99a0
	jp z,L_89FB		;99a2
	jp L_87CB		;99a5
L_99A8:
	ld a,(0002dh)		;99a8
	and a			;99ab
	jr nz,L_99B8		;99ac
	ld hl,00000h		;99ae
	ld bc,04000h		;99b1
	xor a			;99b4
	jp 00056h		;99b5   ; BIOS FILVRM - Fills VRAM with value
L_99B8:
	ld hl,00000h		;99b8
	ld bc,00000h		;99bb
	xor a			;99be
	jp 0016bh		;99bf   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)

; ----------------------------------------------------------------------
; DATOS sin identificar  0x99c2..0x99d3  (17 bytes)
DATA_99C2:
	defb 006h,001h,021h,000h,000h,02bh,0cdh,09ch,000h,0c0h,07ch,0b5h,020h,0f7h,010h,0f2h	; 99c2  ..!..+....|. ...
	defb 0c9h	; 99d2

; ======================================================================
; CODIGO 0x99d3..0x9b38  (357 bytes)
; ======================================================================


L_99D3:
	ld hl,03800h		;99d3
	ld b,002h		;99d6
L_99D8:
	push bc			;99d8
	ld c,004h		;99d9
	call L_99E5		;99db
	pop bc			;99de
	ld hl,03a80h		;99df
	djnz L_99D8		;99e2
	ret			;99e4
L_99E5:
	ld b,010h		;99e5
	ld a,001h		;99e7
L_99E9:
	call 0004dh		;99e9   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;99ec
	call 0004dh		;99ed   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;99f0
	inc a			;99f1
	and 00fh		;99f2
	djnz L_99E9		;99f4
	dec c			;99f6
	jr nz,L_99E5		;99f7
	ret			;99f9
L_99FA:
	ld a,(0d317h)		;99fa
	ld b,a			;99fd
	bit 0,b		;99fe
	call nz,L_9A65		;9a00
	bit 1,b		;9a03
	call nz,L_9A76		;9a05
	bit 2,b		;9a08
	call nz,L_9A8B		;9a0a
	ld a,b			;9a0d
	and 0f8h		;9a0e
	ld d,a			;9a10
	call L_9B4B		;9a11
	jr z,L_9A26		;9a14
	ld a,(0d301h)		;9a16
	cp 015h		;9a19
	jr z,L_9A26		;9a1b
	ld hl,0d33ah		;9a1d
	inc (hl)			;9a20
	bit 1,(hl)		;9a21
	jr nz,L_9A26		;9a23
	ld d,b			;9a25
L_9A26:
	ei			;9a26
	ld hl,0d317h		;9a27
	ld (hl),d			;9a2a
	bit 7,d		;9a2b
	ret z			;9a2d
	res 7,(hl)		;9a2e
	ld a,0ffh		;9a30
	ld (0d13bh),a		;9a32
	ld hl,0d322h		;9a35
	ld de,0d323h		;9a38
	ld (hl),03ch		;9a3b
	ld bc,0000fh		;9a3d
	ldir		;9a40
	ld hl,0d31ch		;9a42
	ld de,0d31dh		;9a45
	ld (hl),000h		;9a48
	ld bc,00005h		;9a4a
	ldir		;9a4d
	call L_8F88		;9a4f
	call 0a578h		;9a52
	call L_9AB4		;9a55
	call 0a5efh		;9a58
	xor a			;9a5b
	ld (0d13bh),a		;9a5c
	ld a,0ffh		;9a5f
	ld (0d332h),a		;9a61
	ret			;9a64
L_9A65:
	ld a,(0d302h)		;9a65
	inc a			;9a68
	jr z,L_9A70		;9a69
	ld hl,09ee0h		;9a6b
	jr L_9A7F		;9a6e
L_9A70:
	push bc			;9a70
	call L_9F69		;9a71
	pop bc			;9a74
	ret			;9a75
L_9A76:
	ld a,(0d302h)		;9a76
	inc a			;9a79
	jr z,L_9A85		;9a7a
	ld hl,09f11h		;9a7c
L_9A7F:
	push bc			;9a7f
	call L_9A91		;9a80
	pop bc			;9a83
	ret			;9a84
L_9A85:
	push bc			;9a85
	call L_9F7B		;9a86
	pop bc			;9a89
	ret			;9a8a
L_9A8B:
	push bc			;9a8b
	call 04997h		;9a8c
	pop bc			;9a8f
	ret			;9a90
L_9A91:
	ld a,(hl)			;9a91
	inc a			;9a92
	ret z			;9a93
	ld a,(0d301h)		;9a94
	cp (hl)			;9a97
	inc hl			;9a98
	jr z,L_9A9F		;9a99
	inc hl			;9a9b
	inc hl			;9a9c
	jr L_9A91		;9a9d
L_9A9F:
	ld e,(hl)			;9a9f
	inc hl			;9aa0
	ld d,(hl)			;9aa1
	ex de,hl			;9aa2
	jp (hl)			;9aa3
L_9AA4:
	ld a,(hl)			;9aa4
	inc a			;9aa5
	jr z,L_9AB2		;9aa6
	ld a,(0d301h)		;9aa8
	cp (hl)			;9aab
	ret z			;9aac
	inc hl			;9aad
	inc hl			;9aae
	inc hl			;9aaf
	jr L_9AA4		;9ab0
L_9AB2:
	inc a			;9ab2
	ret			;9ab3
L_9AB4:
	ld hl,03a8ch		;9ab4
	ld bc,00312h		;9ab7
	xor a			;9aba
	call 0a53bh		;9abb
	ld hl,09bc2h		;9abe
	call 0a524h		;9ac1
	call L_9B90		;9ac4
	ld hl,03acch		;9ac7
	call L_9B3D		;9aca
	jr z,L_9AE8		;9acd
	ld hl,0d142h		;9acf
	ld de,0d322h		;9ad2
	ld bc,00008h		;9ad5
	ldir		;9ad8
	ld hl,0d31ch		;9ada
	call L_9B44		;9add
	ld a,031h		;9ae0
	call L_9B7C		;9ae2
	call L_9B90		;9ae5
L_9AE8:
	call L_9B4B		;9ae8
	jr z,L_9B1D		;9aeb
	ld hl,09bdch		;9aed
	call 0a524h		;9af0
	ld hl,03acch		;9af3
	push hl			;9af6
	ld bc,0000ah		;9af7
	xor a			;9afa
	call 00056h		;9afb   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;9afe
	call L_9B3D		;9aff
	jr z,L_9B1D		;9b02
	ld hl,0d142h		;9b04
	ld de,0d32ah		;9b07
	ld bc,00008h		;9b0a
	ldir		;9b0d
	ld hl,0d31fh		;9b0f
	call L_9B44		;9b12
	ld a,032h		;9b15
	call L_9B7C		;9b17
	call L_9B90		;9b1a
L_9B1D:
	ld hl,03a8ch		;9b1d
	ld bc,00312h		;9b20
	xor a			;9b23
	call 0a53bh		;9b24
	ld hl,09c06h		;9b27
	call 0a524h		;9b2a
	ld hl,09c13h		;9b2d
	ld b,002h		;9b30
	call 0a7b2h		;9b32
	call 0a510h		;9b35

; ----------------------------------------------------------------------
; DATOS saltos_9B38: tabla de 2 palabras del despachador (call 0x408D en
;   0x9B35); lo leen el despachador (4 bytes)
;   0x9b38..0x9b3c  (4 bytes)
DATA_saltos_9B38:
	defb 03ch,09bh	; 9b38
	defb 0b4h,09ah	; 9b3a

; ======================================================================
; CODIGO 0x9b3c..0x9bc2  (134 bytes)
; ======================================================================


L_9B3C:
	ret			;9b3c
L_9B3D:
	ld a,0feh		;9b3d
	ld b,008h		;9b3f
	jp 0a65fh		;9b41
L_9B44:
	xor a			;9b44
	ld (hl),a			;9b45
	inc hl			;9b46
	ld (hl),a			;9b47
	inc hl			;9b48
	ld (hl),a			;9b49
	ret			;9b4a
L_9B4B:
	ld hl,(0d310h)		;9b4b
	ld a,h			;9b4e
	or l			;9b4f
	ret z			;9b50
	ld hl,(0d306h)		;9b51
	ld a,h			;9b54
	or l			;9b55
	ret z			;9b56
	ld a,(0d301h)		;9b57
	ld c,a			;9b5a
	sub 003h		;9b5b
	cp 002h		;9b5d
	jr c,L_9B71		;9b5f
	ld a,c			;9b61
	sub 010h		;9b62
	cp 002h		;9b64
	jr nc,L_9B6D		;9b66
	ld a,(hl)			;9b68
	cpl			;9b69
	and 001h		;9b6a
	ret			;9b6c
L_9B6D:
	ld a,(hl)			;9b6d
	bit 5,a		;9b6e
	ret			;9b70
L_9B71:
	ld a,(hl)			;9b71
	and 001h		;9b72
	ret			;9b74
L_9B75:
	ld a,031h		;9b75
	call L_9B7C		;9b77
	ld a,032h		;9b7a
L_9B7C:
	ld hl,0d477h		;9b7c
	ld b,00ah		;9b7f
	ld c,a			;9b81
L_9B82:
	ld a,c			;9b82
	cp (hl)			;9b83
	jr nz,L_9B88		;9b84
	ld (hl),000h		;9b86
L_9B88:
	ld a,009h		;9b88
	call 0a3e6h		;9b8a
	djnz L_9B82		;9b8d
	ret			;9b8f
L_9B90:
	ld hl,03a2ch		;9b90
	ld bc,00212h		;9b93
	xor a			;9b96
	call 0a53bh		;9b97
	ld hl,09bech		;9b9a
	call 0a524h		;9b9d
	ld hl,0d322h		;9ba0
	ld de,03a36h		;9ba3
	ld bc,00008h		;9ba6
	call 0005ch		;9ba9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	call L_9B4B		;9bac
	ret z			;9baf
	ld hl,09bf9h		;9bb0
	call 0a524h		;9bb3
	ld hl,0d32ah		;9bb6
	ld de,03a56h		;9bb9
	ld bc,00008h		;9bbc
	jp 0005ch		;9bbf   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9bc2..0x9c17  (85 bytes)
DATA_9BC2:
	defb 021h,03ah,052h,041h,04eh,04bh,049h,04eh,047h,0feh,08ch,03ah,049h,04eh,050h,055h	; 9bc2  !:RANKING..:INPU
	defb 054h,000h,031h,050h,000h,04eh,041h,04dh,045h,0ffh,08ch,03ah,049h,04eh,050h,055h	; 9bd2  T.1P.NAME..:INPU
	defb 054h,000h,032h,050h,000h,04eh,041h,04dh,045h,0ffh,02ch,03ah,031h,050h,000h,04eh	; 9be2  T.2P.NAME.,:1P.N
	defb 041h,04dh,045h,000h,03eh,000h,0ffh,04ch,03ah,032h,050h,000h,04eh,041h,04dh,045h	; 9bf2  AME.>..L:2P.NAME
	defb 000h,03eh,000h,0ffh,08ch,03ah,04fh,04bh,0feh,0cch,03ah,052h,045h,054h,052h,059h	; 9c02  .>...:OK..:RETRY
	defb 0ffh,08bh,03ah,0cbh,03ah	; 9c12

; ======================================================================
; CODIGO 0x9c17..0x9e6f  (600 bytes)
; ======================================================================


L_9C17:
	ld hl,0d31eh		;9c17
	ld a,031h		;9c1a
	call L_9C28		;9c1c
	call L_9B4B		;9c1f
	ret z			;9c22
	ld hl,0d321h		;9c23
	ld a,032h		;9c26
L_9C28:
	ld de,0d477h		;9c28
	ex de,hl			;9c2b
	ld c,a			;9c2c
	ld b,00ah		;9c2d
L_9C2F:
	ld a,c			;9c2f
	cp (hl)			;9c30
	jr z,L_9C3E		;9c31
	ld a,009h		;9c33
	call 0a3e6h		;9c35
	djnz L_9C2F		;9c38
	ld b,009h		;9c3a
	jr L_9C45		;9c3c
L_9C3E:
	ld a,00ah		;9c3e
	sub b			;9c40
	ld b,a			;9c41
	jp z,L_9C79		;9c42
L_9C45:
	ld a,c			;9c45
	ld c,000h		;9c46
	ld hl,0d45bh		;9c48
L_9C4B:
	push af			;9c4b
	push bc			;9c4c
	push hl			;9c4d
	push de			;9c4e
	ld b,003h		;9c4f
	ex de,hl			;9c51
L_9C52:
	ld a,(de)			;9c52
	cp (hl)			;9c53
	jr c,L_9C5C		;9c54
	jr nz,L_9C69		;9c56
	dec de			;9c58
	dec hl			;9c59
	djnz L_9C52		;9c5a
L_9C5C:
	pop de			;9c5c
	pop hl			;9c5d
	pop bc			;9c5e
	pop af			;9c5f
	call L_9C7E		;9c60
	call L_9CC3		;9c63
	jp L_9CE4		;9c66
L_9C69:
	pop de			;9c69
	pop hl			;9c6a
	pop bc			;9c6b
	pop af			;9c6c
	inc hl			;9c6d
	inc hl			;9c6e
	inc hl			;9c6f
	inc c			;9c70
	djnz L_9C4B		;9c71
	call L_9CC3		;9c73
	jp L_9CE4		;9c76
L_9C79:
	ld a,c			;9c79
	ld c,b			;9c7a
	jp L_9CC3		;9c7b
L_9C7E:
	ld ix,0d458h		;9c7e
	ld iy,0d45bh		;9c82
	ld d,000h		;9c86
	call L_9C95		;9c88
	ld ix,0d476h		;9c8b
	ld iy,0d47fh		;9c8f
	ld d,001h		;9c93
L_9C95:
	push af			;9c95
	push bc			;9c96
	ld e,b			;9c97
	ld a,c			;9c98
	add a,b			;9c99
	ld b,a			;9c9a
	add a,a			;9c9b
	add a,b			;9c9c
	bit 0,d		;9c9d
	jr z,L_9CA4		;9c9f
	ld b,a			;9ca1
	add a,a			;9ca2
	add a,b			;9ca3
L_9CA4:
	ld c,a			;9ca4
	ld b,000h		;9ca5
	add ix,bc		;9ca7
	add iy,bc		;9ca9
	ld a,e			;9cab
	add a,a			;9cac
	add a,e			;9cad
	bit 0,d		;9cae
	jr z,L_9CB5		;9cb0
	ld b,a			;9cb2
	add a,a			;9cb3
	add a,b			;9cb4
L_9CB5:
	ld c,a			;9cb5
	ld b,000h		;9cb6
	push ix		;9cb8
	pop hl			;9cba
	push iy		;9cbb
	pop de			;9cbd
	lddr		;9cbe
	pop bc			;9cc0
	pop af			;9cc1
	ret			;9cc2
L_9CC3:
	push af			;9cc3
	push bc			;9cc4
	push af			;9cc5
	ld a,c			;9cc6
	ld b,a			;9cc7
	add a,a			;9cc8
	add a,b			;9cc9
	ld hl,0d459h		;9cca
	call 0a3e6h		;9ccd
	pop af			;9cd0
	ld de,0d31ch		;9cd1
	cp 032h		;9cd4
	jr nz,L_9CDB		;9cd6
	ld de,0d31fh		;9cd8
L_9CDB:
	ex de,hl			;9cdb
	ld bc,00003h		;9cdc
	ldir		;9cdf
	pop bc			;9ce1
	pop af			;9ce2
	ret			;9ce3
L_9CE4:
	push af			;9ce4
	push bc			;9ce5
	push af			;9ce6
	ld a,c			;9ce7
	ld b,a			;9ce8
	add a,a			;9ce9
	add a,b			;9cea
	ld b,a			;9ceb
	add a,a			;9cec
	add a,b			;9ced
	ld hl,0d477h		;9cee
	call 0a3e6h		;9cf1
	pop af			;9cf4
	ld de,0d322h		;9cf5
	cp 032h		;9cf8
	jr nz,L_9CFF		;9cfa
	ld de,0d32ah		;9cfc
L_9CFF:
	ex de,hl			;9cff
	ld (de),a			;9d00
	inc de			;9d01
	ld bc,00008h		;9d02
	ldir		;9d05
	pop bc			;9d07
	pop af			;9d08
	ret			;9d09
L_9D0A:
	ld hl,03a29h		;9d0a
	ld bc,00616h		;9d0d
	xor a			;9d10
	call 0a53bh		;9d11
	call 0a74fh		;9d14
	xor a			;9d17
	ld (0d163h),a		;9d18
	ld (0d165h),a		;9d1b
	ld hl,03a29h		;9d1e
	ld (0d16ah),hl		;9d21
	inc hl			;9d24
	ld (0d168h),hl		;9d25
	ld a,0c0h		;9d28
	ld (0d164h),a		;9d2a
	call 0a778h		;9d2d
L_9D30:
	call L_9D9C		;9d30
	call 00156h		;9d33   ; BIOS KILBUF - Clears keyboard buffer
L_9D36:
	ld hl,0d163h		;9d36
	ld de,0d165h		;9d39
	call 0009fh		;9d3c   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;9d3f
	jr z,L_9D86		;9d41
	cp 01fh		;9d43
	jr z,L_9D4C		;9d45
	cp 020h		;9d47
	jr nz,L_9D36		;9d49
	ret			;9d4b
L_9D4C:
	ld a,009h		;9d4c
	cp (hl)			;9d4e
	jr z,L_9D36		;9d4f
	inc (hl)			;9d51
	ld a,(de)			;9d52
	ld b,a			;9d53
	ld a,(hl)			;9d54
	sub b			;9d55
	cp 005h		;9d56
	jr c,L_9D62		;9d58
	inc b			;9d5a
	ld a,b			;9d5b
	ld (de),a			;9d5c
	ld bc,00000h		;9d5d
	jr L_9D65		;9d60
L_9D62:
	ld bc,00020h		;9d62
L_9D65:
	ld a,(hl)			;9d65
	cp 009h		;9d66
	jr nz,L_9D6B		;9d68
	dec bc			;9d6a
L_9D6B:
	call 0a788h		;9d6b
	add hl,bc			;9d6e
	push hl			;9d6f
	ld de,(0d16ah)		;9d70
	and a			;9d74
	sbc hl,de		;9d75
	ld a,(0d164h)		;9d77
	ld d,000h		;9d7a
	ld e,a			;9d7c
	rst 20h			;9d7d
	pop hl			;9d7e
	jr nc,L_9D84		;9d7f
	ld (0d168h),hl		;9d81
L_9D84:
	jr L_9D30		;9d84
L_9D86:
	ld a,(hl)			;9d86
	or a			;9d87
	jr z,L_9D36		;9d88
	dec (hl)			;9d8a
	ex de,hl			;9d8b
	ld a,(de)			;9d8c
	cp (hl)			;9d8d
	jr nc,L_9D91		;9d8e
	dec (hl)			;9d90
L_9D91:
	ld bc,0ffe0h		;9d91
	ld a,(de)			;9d94
	cp 008h		;9d95
	jr nz,L_9D9A		;9d97
	inc bc			;9d99
L_9D9A:
	jr L_9D6B		;9d9a
L_9D9C:
	ld a,(0d165h)		;9d9c
	call L_9E72		;9d9f
	push hl			;9da2
	pop ix		;9da3
	ld a,(0d165h)		;9da5
	call L_9E80		;9da8
	push hl			;9dab
	pop iy		;9dac
	ld hl,(0d16ah)		;9dae
	inc hl			;9db1
	ld a,(0d165h)		;9db2
	add a,031h		;9db5
	ld c,a			;9db7
	ld b,005h		;9db8
L_9DBA:
	push bc			;9dba
	push hl			;9dbb
	push hl			;9dbc
	push bc			;9dbd
	xor a			;9dbe
	ld bc,00015h		;9dbf
	call 00056h		;9dc2   ; BIOS FILVRM - Fills VRAM with value
	call 0a778h		;9dc5
	pop bc			;9dc8
	pop hl			;9dc9
	ld a,c			;9dca
	cp 03ah		;9dcb
	jr z,L_9DD5		;9dcd
	inc hl			;9dcf
	call 0004dh		;9dd0   ; BIOS WRTVRM - Writes data in VRAM
	jr L_9DE0		;9dd3
L_9DD5:
	ld a,031h		;9dd5
	call 0004dh		;9dd7   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9dda
	ld a,030h		;9ddb
	call 0004dh		;9ddd   ; BIOS WRTVRM - Writes data in VRAM
L_9DE0:
	inc hl			;9de0
	ld a,03bh		;9de1
	call 0004dh		;9de3   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9de6
	push ix		;9de7
	pop de			;9de9
	ex de,hl			;9dea
	ld bc,00008h		;9deb
	push de			;9dee
	push bc			;9def
	call 0005ch		;9df0   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0da00h		;9df3
	ld a,(iy+002h)		;9df6
	call L_943D		;9df9
	inc hl			;9dfc
	ld a,(iy+001h)		;9dfd
	call L_943D		;9e00
	inc hl			;9e03
	ld a,(iy+000h)		;9e04
	call L_943D		;9e07
	pop bc			;9e0a
	pop hl			;9e0b
	add hl,bc			;9e0c
	ld a,03eh		;9e0d
	call 0004dh		;9e0f   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e12
	ld de,0da00h		;9e13
	ld bc,00600h		;9e16
	ld a,(0d301h)		;9e19
	cp 029h		;9e1c
	jr nz,L_9E23		;9e1e
	inc de			;9e20
	dec b			;9e21
	inc c			;9e22
L_9E23:
	ld a,(de)			;9e23
	cp 030h		;9e24
	jr nz,L_9E37		;9e26
	inc hl			;9e28
	inc de			;9e29
	djnz L_9E23		;9e2a
	bit 0,c		;9e2c
	jr nz,L_9E31		;9e2e
	dec hl			;9e30
L_9E31:
	call 0004dh		;9e31   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e34
	jr L_9E4F		;9e35
L_9E37:
	push bc			;9e37
	ld c,b			;9e38
	ld b,000h		;9e39
	ex de,hl			;9e3b
	push bc			;9e3c
	push de			;9e3d
	call 0005ch		;9e3e   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;9e41
	pop bc			;9e42
	add hl,bc			;9e43
	pop bc			;9e44
	bit 0,c		;9e45
	jr z,L_9E4F		;9e47
	ld a,030h		;9e49
	call 0004dh		;9e4b   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e4e
L_9E4F:
	ld de,09e6fh		;9e4f
	ex de,hl			;9e52
	ld bc,00003h		;9e53
	call 0005ch		;9e56   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld bc,00009h		;9e59
	add ix,bc		;9e5c
	ld bc,00003h		;9e5e
	add iy,bc		;9e61
	pop hl			;9e63
	ld bc,00020h		;9e64
	add hl,bc			;9e67
	pop bc			;9e68
	inc c			;9e69
	dec b			;9e6a
	jp nz,L_9DBA		;9e6b
	ret			;9e6e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9e6f..0x9e72  (3 bytes)
DATA_9E6F:
	defb 050h,054h,053h	; 9e6f

; ======================================================================
; CODIGO 0x9e72..0x9e8a  (24 bytes)
; ======================================================================


L_9E72:
	ld b,a			;9e72
	add a,a			;9e73
	add a,b			;9e74
	ld b,a			;9e75
	add a,a			;9e76
	add a,b			;9e77
	ld hl,0d477h		;9e78
	call 0a3e6h		;9e7b
	inc hl			;9e7e
	ret			;9e7f
L_9E80:
	ld b,a			;9e80
	add a,a			;9e81
	add a,b			;9e82
	ld hl,0d459h		;9e83
	call 0a3e6h		;9e86
	ret			;9e89

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9e8a..0x9f51  (199 bytes)
DATA_9E8A:
	defb 0b1h,0d9h,02ah,02ah,02ah,020h,052h,043h,02dh,037h,020h,020h,020h,053h,043h,04fh	; 9e8a  ..*** RC-7   SCO
	defb 052h,045h,020h,052h,041h,04eh,04bh,049h,04eh,047h,020h,02ah,02ah,02ah,0feh,0ebh	; 9e9a  RE RANKING ***..
	defb 0d9h,052h,061h,06eh,06bh,02eh,020h,020h,04eh,061h,06dh,065h,02eh,020h,020h,020h	; 9eaa  .Rank.  Name.
	defb 053h,063h,06fh,072h,065h,02eh,0feh,005h,0dah,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 9eba  Score....-------
	defb 02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 9eca  ----------------
	defb 02dh,02dh,02dh,02dh,02dh,0ffh,000h,061h,09fh,002h,061h,09fh,003h,061h,09fh,004h	; 9eda  -----..a..a..a..
	defb 061h,09fh,005h,061h,09fh,006h,061h,09fh,012h,061h,09fh,013h,061h,09fh,014h,061h	; 9eea  a..a..a..a..a..a
	defb 09fh,016h,061h,09fh,025h,051h,09fh,021h,061h,09fh,027h,061h,09fh,028h,06eh,09fh	; 9efa  ..a.%Q.!a.'a.(n.
	defb 029h,069h,09fh,037h,069h,09fh,0ffh,000h,08ah,09fh,001h,0afh,09fh,010h,0eah,09fh	; 9f0a  )i.7i...........
	defb 011h,0eah,09fh,012h,033h,0a0h,013h,049h,0a0h,014h,09bh,0a0h,015h,09eh,0a0h,016h	; 9f1a  ....3..I........
	defb 08ah,09fh,017h,0a5h,0a0h,018h,0b1h,0a0h,021h,0e9h,0a0h,025h,0fah,0a0h,027h,02ah	; 9f2a  ........!..%..'*
	defb 0a1h,028h,07bh,0a1h,029h,096h,0a1h,030h,0a9h,0a1h,032h,0c8h,0a1h,033h,0d1h,0a1h	; 9f3a  .({.)..0..2..3..
	defb 036h,0dah,0a1h,037h,000h,0a2h,0ffh	; 9f4a

; ======================================================================
; CODIGO 0x9f51..0x9fd6  (133 bytes)
; ======================================================================


L_9F51:
	ld a,0ffh		;9f51
	ld (0e052h),a		;9f53
	ld a,(0d318h)		;9f56
	cp 00bh		;9f59
	jr c,L_9F5F		;9f5b
	ld a,00ah		;9f5d
L_9F5F:
	jr L_9F64		;9f5f
L_9F61:
	ld a,(0d318h)		;9f61
L_9F64:
	ld hl,(0d308h)		;9f64
	ld (hl),a			;9f67
	ret			;9f68
L_9F69:
	ld a,(0d319h)		;9f69
	jr L_9F64		;9f6c
L_9F6E:
	ld a,(0d318h)		;9f6e
	ld (0e050h),a		;9f71
	ld a,(0d319h)		;9f74
	ld (0e051h),a		;9f77
	ret			;9f7a
L_9F7B:
	ld a,(0d313h)		;9f7b
	ld c,a			;9f7e
	ld a,(0d31ah)		;9f7f
	call 0a21eh		;9f82
	ld a,l			;9f85
	inc a			;9f86
	jp 0a125h		;9f87
L_9F8A:
	ld a,(0d31ah)		;9f8a
	dec a			;9f8d
	ld l,a			;9f8e
	ld h,000h		;9f8f
	add hl,hl			;9f91
	ld b,h			;9f92
	ld c,l			;9f93
	add hl,hl			;9f94
	add hl,hl			;9f95
	add hl,bc			;9f96
	call 0a54bh		;9f97
	ld a,e			;9f9a
	ld (0e059h),a		;9f9b
	push af			;9f9e
	add a,010h		;9f9f
	daa			;9fa1
	ld (0e05ah),a		;9fa2
	pop af			;9fa5
	call 0a55ch		;9fa6
	ld (0e054h),a		;9fa9
	jp 0a122h		;9fac
L_9FAF:
	ld a,(0d31ah)		;9faf
	ld c,00ah		;9fb2
	call 0a21eh		;9fb4
	ld a,l			;9fb7
	ld (0e0e1h),a		;9fb8
	ld (0e0e8h),a		;9fbb
	ld b,a			;9fbe
	ld a,(0d303h)		;9fbf
	or a			;9fc2
	ld hl,09fd6h		;9fc3
	jr z,L_9FCB		;9fc6
	ld hl,09fe0h		;9fc8
L_9FCB:
	ld a,b			;9fcb
	call 0a3e6h		;9fcc
	ld a,(hl)			;9fcf
	ld (0e0e2h),a		;9fd0
	jp 0a122h		;9fd3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9fd6..0x9fea  (20 bytes)
DATA_9FD6:
	defb 000h,006h,00dh,013h,01ah,022h,027h,02dh,033h,035h,000h,007h,00fh,014h,01ah,020h	; 9fd6  ....."'-35.....
	defb 022h,02fh,035h,03ch	; 9fe6

; ======================================================================
; CODIGO 0x9fea..0x9fff  (21 bytes)
; ======================================================================


L_9FEA:
	ld a,(0d31ah)		;9fea
	ld c,004h		;9fed
	call 0a21eh		;9fef
	ld a,l			;9ff2
	inc a			;9ff3
	ld hl,(0d30ah)		;9ff4
	ld (hl),a			;9ff7
	ld (0e015h),a		;9ff8
	dec a			;9ffb
	push af			;9ffc
	add a,a			;9ffd
	ld b,a			;9ffe

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9fff..0xa000  (1 bytes)
DATA_9FFF:
	defb 021h	; 9fff
