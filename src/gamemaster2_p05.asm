; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 05 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x82d7  (727 bytes)
; ======================================================================


L_8000:
	di			;8000
	ld hl,00000h		;8001
	add hl,sp			;8004
	ld (0f0f6h),hl		;8005
	ld hl,0e000h		;8008
	ld de,0e001h		;800b
	ld bc,010f4h		;800e
	ld (hl),000h		;8011
	ldir		;8013
	ld hl,L_8030		;8015
	ld de,0fd9fh		;8018
	ld bc,00003h		;801b
	ldir		;801e
	ld a,(0002dh)		;8020
	nop			;8023
	ld (0f0f5h),a		;8024
	call L_8056		;8027
	call L_8062		;802a
	jp L_8B14		;802d
L_8030:
	jp L_8033		;8030
L_8033:
	call 0013eh		;8033   ; BIOS RDVDP - Reads VDP status register
	ld a,006h		;8036
	call 00141h		;8038   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;803b
	jp nz,0013eh		;803d   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;8040
	call 00141h		;8042   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;8045
	jp c,0013eh		;8046   ; BIOS RDVDP - Reads VDP status register
	ld a,0c9h		;8049
	ld (0fd9fh),a		;804b
	call 0013eh		;804e   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f0f6h)		;8051
	ld sp,hl			;8054
	ret			;8055
L_8056:
	ld a,(0f0f5h)		;8056
	and a			;8059
	jr nz,L_805F		;805a
	jp L_873D		;805c
L_805F:
	jp L_8768		;805f
L_8062:
	ld a,(0f0f5h)		;8062
	and a			;8065
	jr nz,L_806B		;8066
	jp L_8C73		;8068
L_806B:
	jp L_8D22		;806b
L_806E:
	add a,l			;806e
	ld l,a			;806f
	ret nc			;8070
	inc h			;8071
	ret			;8072
L_8073:
	add a,e			;8073
	ld e,a			;8074
	ret nc			;8075
	inc d			;8076
	ret			;8077
L_8078:
	pop hl			;8078
	add a,a			;8079
	call L_806E		;807a
	ld e,(hl)			;807d
	inc hl			;807e
	ld d,(hl)			;807f
	ex de,hl			;8080
	jp (hl)			;8081
L_8082:
	ex af,af'			;8082
	call 00053h		;8083   ; BIOS SETWRT - Enables VDP to write
	exx			;8086
	ld a,(00007h)		;8087
	ld c,a			;808a
	exx			;808b
	ex af,af'			;808c
	ret			;808d
L_808E:
	call 00050h		;808e   ; BIOS SETRD - Enables VDP to read
	exx			;8091
	ld a,(00006h)		;8092
	ld c,a			;8095
	exx			;8096
	ret			;8097
L_8098:
	ex de,hl			;8098
	jp 0005ch		;8099   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_809C:
	exx			;809c
	ld b,003h		;809d
L_809F:
	exx			;809f
	push bc			;80a0
	push de			;80a1
	call L_8098		;80a2
	ld de,00800h		;80a5
	add hl,de			;80a8
	pop de			;80a9
	pop bc			;80aa
	exx			;80ab
	djnz L_809F		;80ac
	ret			;80ae
L_80AF:
	ld d,003h		;80af
L_80B1:
	push bc			;80b1
	push de			;80b2
	call 00056h		;80b3   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;80b6
	add hl,de			;80b9
	pop de			;80ba
	pop bc			;80bb
	dec d			;80bc
	jr nz,L_80B1		;80bd
	ret			;80bf
L_80C0:
	ld b,003h		;80c0
L_80C2:
	push bc			;80c2
	push de			;80c3
	call L_80F7		;80c4
	ld de,00800h		;80c7
	add hl,de			;80ca
	pop de			;80cb
	pop bc			;80cc
	djnz L_80C2		;80cd
	ret			;80cf
L_80D0:
	call L_80D4		;80d0
	ret			;80d3
L_80D4:
	ld c,0ffh		;80d4
L_80D6:
	ex de,hl			;80d6
	ld e,(hl)			;80d7
	inc hl			;80d8
	ld d,(hl)			;80d9
	ex de,hl			;80da
	inc de			;80db
L_80DC:
	ld a,(de)			;80dc
	inc de			;80dd
	cp 080h		;80de
	ret z			;80e0
	cp 081h		;80e1
	jr z,L_80D6		;80e3
	and c			;80e5
	ld (hl),a			;80e6
	inc hl			;80e7
	jr L_80DC		;80e8
L_80EA:
	call L_80ED		;80ea
L_80ED:
	ld c,000h		;80ed
	jr L_80D6		;80ef
L_80F1:
	ex de,hl			;80f1
	ld e,(hl)			;80f2
	inc hl			;80f3
	ld d,(hl)			;80f4
	ex de,hl			;80f5
	inc de			;80f6
L_80F7:
	call L_8082		;80f7
L_80FA:
	ld a,(de)			;80fa
	and a			;80fb
	ret z			;80fc
	inc de			;80fd
	ld b,a			;80fe
	and 07fh		;80ff
	cp b			;8101
	jr z,L_8112		;8102
	and a			;8104
	jr z,L_80F1		;8105
	ld b,a			;8107
L_8108:
	ld a,(de)			;8108
	inc de			;8109
	exx			;810a
	out (c),a		;810b
	exx			;810d
	djnz L_8108		;810e
	jr L_80FA		;8110
L_8112:
	ld a,(de)			;8112
	inc de			;8113
L_8114:
	exx			;8114
	out (c),a		;8115
	exx			;8117
	djnz L_8114		;8118
	jr L_80FA		;811a
L_811C:
	call L_819C		;811c
	call L_812F		;811f
	ex af,af'			;8122
	ld a,(00006h)		;8123
	ld c,a			;8126
	ex af,af'			;8127
L_8128:
	inir		;8128
	dec a			;812a
	jr nz,L_8128		;812b
	ex de,hl			;812d
	ret			;812e
L_812F:
	ex de,hl			;812f
	ld a,c			;8130
	or a			;8131
	ld a,b			;8132
	ld b,c			;8133
	ret z			;8134
	inc a			;8135
	ret			;8136
L_8137:
	ex de,hl			;8137
	call L_817D		;8138
	call L_812F		;813b
	ex af,af'			;813e
	ld a,(00007h)		;813f
	ld c,a			;8142
	ex af,af'			;8143
L_8144:
	otir		;8144
	dec a			;8146
	jr nz,L_8144		;8147
	ret			;8149
L_814A:
	push de			;814a
	push af			;814b
	call L_817D		;814c
	ld d,c			;814f
	ld a,c			;8150
	or a			;8151
	jr z,L_8155		;8152
	inc b			;8154
L_8155:
	ld a,(00007h)		;8155
	ld c,a			;8158
	pop af			;8159
L_815A:
	out (c),a		;815a
	dec d			;815c
	jr nz,L_815A		;815d
	djnz L_815A		;815f
	pop de			;8161
	ret			;8162
L_8163:
	push bc			;8163
	call L_819C		;8164
	ld a,(00006h)		;8167
	ld c,a			;816a
	in a,(c)		;816b
	pop bc			;816d
	ret			;816e
L_816F:
	push bc			;816f
	push af			;8170
	call L_817D		;8171
	ld a,(00007h)		;8174
	ld c,a			;8177
	pop af			;8178
	out (c),a		;8179
	pop bc			;817b
	ret			;817c
L_817D:
	push bc			;817d
	ld a,(00007h)		;817e
	inc a			;8181
	ld c,a			;8182
	ld a,h			;8183
	rlca			;8184
	rlca			;8185
	and 003h		;8186
	di			;8188
	out (c),a		;8189
	ld a,08eh		;818b
	out (c),a		;818d
	ld a,l			;818f
	out (c),a		;8190
	ld a,h			;8192
	and 03fh		;8193
	or 040h		;8195
	out (c),a		;8197
	pop bc			;8199
	ei			;819a
	ret			;819b
L_819C:
	push bc			;819c
	ld a,(00007h)		;819d
	inc a			;81a0
	ld c,a			;81a1
	ld a,h			;81a2
	rlca			;81a3
	rlca			;81a4
	and 003h		;81a5
	di			;81a7
	out (c),a		;81a8
	ld a,08eh		;81aa
	out (c),a		;81ac
	ld a,l			;81ae
	out (c),a		;81af
	ld a,h			;81b1
	and 03fh		;81b2
	out (c),a		;81b4
	pop bc			;81b6
	ei			;81b7
	ret			;81b8
L_81B9:
	ld c,000h		;81b9
L_81BB:
	ex de,hl			;81bb
	ld e,(hl)			;81bc
	inc hl			;81bd
	ld d,(hl)			;81be
	inc hl			;81bf
	ex de,hl			;81c0
L_81C1:
	call L_817D		;81c1
	exx			;81c4
	ld a,(00007h)		;81c5
	ld c,a			;81c8
	exx			;81c9
L_81CA:
	ld a,(de)			;81ca
	and a			;81cb
	ret z			;81cc
	inc de			;81cd
	ld b,a			;81ce
	and 07fh		;81cf
	cp b			;81d1
	jr z,L_81E3		;81d2
	and a			;81d4
	jr z,L_81B9		;81d5
	ld b,a			;81d7
L_81D8:
	call L_8238		;81d8
	exx			;81db
	out (c),a		;81dc
	exx			;81de
	djnz L_81D8		;81df
	jr L_81CA		;81e1
L_81E3:
	call L_8238		;81e3
L_81E6:
	exx			;81e6
	out (c),a		;81e7
	exx			;81e9
	djnz L_81E6		;81ea
	jr L_81CA		;81ec
L_81EE:
	ld c,000h		;81ee
	jr L_81C1		;81f0
L_81F2:
	ld c,001h		;81f2
	jr L_81BB		;81f4
L_81F6:
	ld c,001h		;81f6
	jr L_81C1		;81f8
L_81FA:
	call L_821C		;81fa
	ld a,020h		;81fd
	call L_8073		;81ff
	dec c			;8202
	jr nz,L_81FA		;8203
	ret			;8205
L_8206:
	call L_821C		;8206
	ld a,0e0h		;8209
	add a,e			;820b
	ld e,a			;820c
	jr c,L_8210		;820d
	dec d			;820f
L_8210:
	call L_821C		;8210
	ld a,060h		;8213
	call L_8073		;8215
	dec c			;8218
	jr nz,L_8206		;8219
	ret			;821b
L_821C:
	push de			;821c
L_821D:
	ld b,010h		;821d
L_821F:
	ex de,hl			;821f
	call L_8163		;8220
	ex de,hl			;8223
	call L_823D		;8224
	call L_816F		;8227
	inc e			;822a
	inc hl			;822b
	djnz L_821F		;822c
	ld a,e			;822e
	sub 020h		;822f
	ld e,a			;8231
	bit 4,e		;8232
	jr z,L_821D		;8234
	pop de			;8236
	ret			;8237
L_8238:
	ld a,(de)			;8238
	inc de			;8239
	bit 0,c		;823a
	ret z			;823c
L_823D:
	push bc			;823d
	ld c,a			;823e
	ld b,008h		;823f
L_8241:
	rr c		;8241
	rla			;8243
	djnz L_8241		;8244
	pop bc			;8246
	ret			;8247
L_8248:
	call L_827B		;8248
	call L_826E		;824b
	ld hl,00000h		;824e
	ld bc,00000h		;8251
	xor a			;8254
	ld d,000h		;8255
	call L_83C8		;8257
	ld b,000h		;825a
	ld c,017h		;825c
	call 00047h		;825e   ; BIOS WRTVDP - Writes data in the VDP-register
L_8261:
	ld a,(0f3e0h)		;8261
	or 040h		;8264
	ld b,a			;8266
	ld c,001h		;8267
	call 00047h		;8269   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_828E		;826c
L_826E:
	ld a,(0f3e0h)		;826e
	and 0bfh		;8271
	ld b,a			;8273
	ld c,001h		;8274
	call 00047h		;8276   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_8283		;8279
L_827B:
	ld hl,0f600h		;827b
	ld a,0d8h		;827e
	jp L_816F		;8280
L_8283:
	ld a,(0ffe7h)		;8283
	or 002h		;8286
	ld b,a			;8288
	ld c,008h		;8289
	jp 00047h		;828b   ; BIOS WRTVDP - Writes data in the VDP-register
L_828E:
	ld a,(0ffe7h)		;828e
	and 0fdh		;8291
	ld b,a			;8293
	ld c,008h		;8294
	jp 00047h		;8296   ; BIOS WRTVDP - Writes data in the VDP-register
L_8299:
	push bc			;8299
	push hl			;829a
	ld b,a			;829b
	ld a,(00007h)		;829c
	inc a			;829f
	ld c,a			;82a0
	di			;82a1
	out (c),b		;82a2
	ld a,090h		;82a4
	out (c),a		;82a6
	inc c			;82a8
	out (c),d		;82a9
	push af			;82ab
	pop af			;82ac
	out (c),e		;82ad
	dec c			;82af
	ld hl,0f680h		;82b0
	ld a,b			;82b3
	add a,a			;82b4
	add a,l			;82b5
	ld l,a			;82b6
	call L_817D		;82b7
	dec c			;82ba
	out (c),d		;82bb
	out (c),e		;82bd
	pop hl			;82bf
	pop bc			;82c0
	ei			;82c1
	ret			;82c2
L_82C3:
	ld hl,082d7h		;82c3
L_82C6:
	ld b,010h		;82c6
	ld a,000h		;82c8
L_82CA:
	ld d,(hl)			;82ca
	inc hl			;82cb
	ld e,(hl)			;82cc
	inc hl			;82cd
	push af			;82ce
	call L_8299		;82cf
	pop af			;82d2
	inc a			;82d3
	djnz L_82CA		;82d4
	ret			;82d6

; ----------------------------------------------------------------------
; DATOS resto_82D7: lo apuntan con el banco puesto p05:82C3 (0x82D7); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:82C3 (46 bytes)
;   0x82d7..0x8305  (46 bytes)
DATA_resto_82D7:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 82d7  ......3...'.Q.'.
	defb 071h,001h,073h,003h,061h,006h,064h,006h,011h,004h,065h,002h,055h,005h,077h,007h	; 82e7  q.s.a.d...e.U.w.
	defb 07eh,023h,03ch,0c8h,03dh,056h,023h,05eh,023h,0cdh,099h,082h,018h,0f2h	; 82f7  ~#<.=V#^#.....

; ======================================================================
; CODIGO 0x8305..0x8758  (1107 bytes)
; ======================================================================


L_8305:
	ld a,002h		;8305
	call L_830F		;8307
	rra			;830a
	jp c,L_8305		;830b
	ret			;830e
L_830F:
	push bc			;830f
	push hl			;8310
	ld hl,(00006h)		;8311
	inc h			;8314
	inc l			;8315
	ld c,h			;8316
	di			;8317
	out (c),a		;8318
	ld a,08fh		;831a
	out (c),a		;831c
	ld c,l			;831e
	in a,(c)		;831f
	push af			;8321
	xor a			;8322
	ld c,h			;8323
	out (c),a		;8324
	ld a,08fh		;8326
	out (c),a		;8328
	pop af			;832a
	pop hl			;832b
	pop bc			;832c
	ei			;832d
	ret			;832e
L_832F:
	call L_8305		;832f
	push bc			;8332
	ld a,(00007h)		;8333
	inc a			;8336
	ld c,a			;8337
	ld a,024h		;8338
	di			;833a
	out (c),a		;833b
	ld a,091h		;833d
	out (c),a		;833f
	inc c			;8341
	inc c			;8342
	out (c),h		;8343
	xor a			;8345
	out (c),a		;8346
	out (c),l		;8348
	out (c),a		;834a
	pop hl			;834c
	out (c),h		;834d
	xor a			;834f
	cp h			;8350
	jr nz,L_8354		;8351
	inc a			;8353
L_8354:
	out (c),a		;8354
	xor a			;8356
	out (c),a		;8357
	out (c),a		;8359
	out (c),l		;835b
	out (c),a		;835d
	ld a,070h		;835f
	out (c),a		;8361
	ei			;8363
	ret			;8364
L_8365:
	call L_8305		;8365
	push bc			;8368
	ld a,(00007h)		;8369
	inc a			;836c
	ld c,a			;836d
	ld a,024h		;836e
	di			;8370
	out (c),a		;8371
	ld a,091h		;8373
	out (c),a		;8375
	inc c			;8377
	inc c			;8378
	out (c),h		;8379
	xor a			;837b
	out (c),a		;837c
	out (c),l		;837e
	out (c),a		;8380
	pop hl			;8382
	out (c),h		;8383
	xor a			;8385
	cp h			;8386
	jr nz,L_838A		;8387
	inc a			;8389
L_838A:
	out (c),a		;838a
	xor a			;838c
	out (c),a		;838d
	out (c),a		;838f
	out (c),l		;8391
	inc a			;8393
	out (c),a		;8394
	ld a,070h		;8396
	out (c),a		;8398
	ei			;839a
	ret			;839b
L_839C:
	ld b,e			;839c
	call L_83B4		;839d
	ld b,d			;83a0
	call L_83BE		;83a1
	push hl			;83a4
	ld a,l			;83a5
	add a,e			;83a6
	ld l,a			;83a7
	ld b,d			;83a8
	call L_83BE		;83a9
	pop hl			;83ac
	ld a,h			;83ad
	add a,d			;83ae
	ld h,a			;83af
	ld b,e			;83b0
	jp L_83B4		;83b1
L_83B4:
	push hl			;83b4
	push de			;83b5
	push bc			;83b6
	call L_8365		;83b7
	pop bc			;83ba
	pop de			;83bb
	pop hl			;83bc
	ret			;83bd
L_83BE:
	push hl			;83be
	push de			;83bf
	push bc			;83c0
	call L_832F		;83c1
	pop bc			;83c4
	pop de			;83c5
	pop hl			;83c6
	ret			;83c7
L_83C8:
	ex af,af'			;83c8
	call L_8305		;83c9
	push bc			;83cc
	ld a,(00007h)		;83cd
	inc a			;83d0
	ld c,a			;83d1
	ld a,024h		;83d2
	di			;83d4
	out (c),a		;83d5
	ld a,091h		;83d7
	out (c),a		;83d9
	inc c			;83db
	inc c			;83dc
	out (c),h		;83dd
	xor a			;83df
	out (c),a		;83e0
	out (c),l		;83e2
	out (c),d		;83e4
	pop hl			;83e6
	out (c),h		;83e7
	cp h			;83e9
	jr nz,L_83ED		;83ea
	inc a			;83ec
L_83ED:
	out (c),a		;83ed
	xor a			;83ef
	out (c),l		;83f0
	cp l			;83f2
	jr nz,L_83F6		;83f3
	inc a			;83f5
L_83F6:
	out (c),a		;83f6
	ex af,af'			;83f8
	out (c),a		;83f9
	xor a			;83fb
	out (c),a		;83fc
	ld a,0c0h		;83fe
	out (c),a		;8400
	ei			;8402
	ret			;8403
L_8404:
	ex af,af'			;8404
	call L_8305		;8405
	push bc			;8408
	ld a,(00007h)		;8409
	inc a			;840c
	ld c,a			;840d
	ld a,020h		;840e
	di			;8410
	out (c),a		;8411
	ld a,091h		;8413
	out (c),a		;8415
	inc c			;8417
	inc c			;8418
	out (c),h		;8419
	xor a			;841b
	out (c),a		;841c
	out (c),l		;841e
	ex af,af'			;8420
	ld l,a			;8421
	and 003h		;8422
	out (c),a		;8424
	out (c),d		;8426
	xor a			;8428
	out (c),a		;8429
	out (c),e		;842b
	ld a,l			;842d
	rra			;842e
	rra			;842f
	and 003h		;8430
	out (c),a		;8432
	pop hl			;8434
	out (c),h		;8435
	xor a			;8437
	out (c),a		;8438
	out (c),l		;843a
	out (c),a		;843c
	out (c),a		;843e
	out (c),a		;8440
	ld a,0d0h		;8442
	out (c),a		;8444
	ei			;8446
	ret			;8447
L_8448:
	ex af,af'			;8448
	call L_8305		;8449
	push bc			;844c
	ld a,(00007h)		;844d
	inc a			;8450
	ld c,a			;8451
	ld a,024h		;8452
	di			;8454
	out (c),a		;8455
	ld a,091h		;8457
	out (c),a		;8459
	inc c			;845b
	inc c			;845c
	out (c),d		;845d
	xor a			;845f
	out (c),a		;8460
	out (c),e		;8462
	ex af,af'			;8464
	out (c),a		;8465
	pop de			;8467
	out (c),d		;8468
	xor a			;846a
	out (c),a		;846b
	out (c),e		;846d
	out (c),a		;846f
	ld a,(hl)			;8471
	inc hl			;8472
	out (c),a		;8473
	xor a			;8475
	out (c),a		;8476
	ld a,0f0h		;8478
	out (c),a		;847a
	dec c			;847c
	dec c			;847d
	ld a,0ach		;847e
	out (c),a		;8480
	ld a,091h		;8482
	out (c),a		;8484
	inc c			;8486
	inc c			;8487
L_8488:
	ld a,002h		;8488
	call L_830F		;848a
	rra			;848d
	ret nc			;848e
	add a,a			;848f
	add a,a			;8490
	jr nc,L_8488		;8491
	ld a,(hl)			;8493
	inc hl			;8494
	out (c),a		;8495
	jr L_8488		;8497
L_8499:
	ex af,af'			;8499
	call L_8305		;849a
	ld a,(00007h)		;849d
	inc a			;84a0
	ld c,a			;84a1
	ld a,022h		;84a2
	di			;84a4
	out (c),a		;84a5
	ld a,091h		;84a7
	out (c),a		;84a9
	inc c			;84ab
	inc c			;84ac
	out (c),l		;84ad
	ex af,af'			;84af
	ld l,a			;84b0
	and 003h		;84b1
	out (c),a		;84b3
	out (c),h		;84b5
	xor a			;84b7
	out (c),a		;84b8
	out (c),e		;84ba
	ld a,l			;84bc
	rra			;84bd
	rra			;84be
	and 003h		;84bf
	out (c),a		;84c1
	xor a			;84c3
	out (c),a		;84c4
	out (c),a		;84c6
	out (c),d		;84c8
	cp d			;84ca
	jr nz,L_84CE		;84cb
	inc a			;84cd
L_84CE:
	out (c),a		;84ce
	xor a			;84d0
	out (c),a		;84d1
	out (c),a		;84d3
	ld a,0e0h		;84d5
	out (c),a		;84d7
	ei			;84d9
	ret			;84da
L_84DB:
	ex af,af'			;84db
	call L_8305		;84dc
	push bc			;84df
	ld a,(00007h)		;84e0
	inc a			;84e3
	ld c,a			;84e4
	ld a,024h		;84e5
	di			;84e7
	out (c),a		;84e8
	ld a,091h		;84ea
	out (c),a		;84ec
	inc c			;84ee
	inc c			;84ef
	out (c),d		;84f0
	xor a			;84f2
	out (c),a		;84f3
	out (c),e		;84f5
	ex af,af'			;84f7
	ld b,a			;84f8
	rlca			;84f9
	rlca			;84fa
	and 003h		;84fb
	out (c),a		;84fd
	pop de			;84ff
	out (c),d		;8500
	xor a			;8502
	out (c),a		;8503
	out (c),e		;8505
	cp e			;8507
	jr nz,L_850B		;8508
	inc a			;850a
L_850B:
	out (c),a		;850b
	ld a,(hl)			;850d
	inc hl			;850e
	out (c),a		;850f
	xor a			;8511
	out (c),a		;8512
	ld a,b			;8514
	and 00fh		;8515
	or 0b0h		;8517
	out (c),a		;8519
	dec c			;851b
	dec c			;851c
	ld a,0ach		;851d
	out (c),a		;851f
	ld a,091h		;8521
	out (c),a		;8523
	inc c			;8525
	inc c			;8526
L_8527:
	ld a,002h		;8527
	call L_830F		;8529
	rra			;852c
	ret nc			;852d
	add a,a			;852e
	add a,a			;852f
	jr nc,L_8527		;8530
	ld a,(hl)			;8532
	inc hl			;8533
	out (c),a		;8534
	jr L_8527		;8536
L_8538:
	ex af,af'			;8538
	call L_8305		;8539
	ld a,007h		;853c
	call L_830F		;853e
	push de			;8541
	push bc			;8542
	ld a,(00007h)		;8543
	inc a			;8546
	ld c,a			;8547
	ld a,020h		;8548
	di			;854a
	out (c),a		;854b
	ld a,091h		;854d
	out (c),a		;854f
	inc c			;8551
	inc c			;8552
	out (c),h		;8553
	xor a			;8555
	out (c),a		;8556
	out (c),l		;8558
	ex af,af'			;855a
	ld h,a			;855b
	rlca			;855c
	rlca			;855d
	and 003h		;855e
	out (c),a		;8560
	out (c),a		;8562
	out (c),a		;8564
	out (c),a		;8566
	out (c),a		;8568
	pop de			;856a
	out (c),d		;856b
	xor a			;856d
	out (c),a		;856e
	out (c),e		;8570
	cp e			;8572
	jr nz,L_8576		;8573
	inc a			;8575
L_8576:
	out (c),a		;8576
	out (c),a		;8578
	xor a			;857a
	out (c),a		;857b
	ld a,h			;857d
	and 00fh		;857e
	or 0a0h		;8580
	out (c),a		;8582
	pop de			;8584
L_8585:
	ld a,002h		;8585
	call L_830F		;8587
	rra			;858a
	ret nc			;858b
	add a,a			;858c
	add a,a			;858d
	jr nc,L_8585		;858e
	ld a,007h		;8590
	call L_830F		;8592
	ld (de),a			;8595
	inc de			;8596
	jr L_8585		;8597
L_8599:
	ex af,af'			;8599
	call L_8305		;859a
	push bc			;859d
	ld a,(00007h)		;859e
	inc a			;85a1
	ld c,a			;85a2
	ld a,020h		;85a3
	di			;85a5
	out (c),a		;85a6
	ld a,091h		;85a8
	out (c),a		;85aa
	inc c			;85ac
	inc c			;85ad
	out (c),h		;85ae
	xor a			;85b0
	out (c),a		;85b1
	out (c),l		;85b3
	ex af,af'			;85b5
	rlca			;85b6
	rlca			;85b7
	ld l,a			;85b8
	and 003h		;85b9
	out (c),a		;85bb
	out (c),d		;85bd
	xor a			;85bf
	out (c),a		;85c0
	out (c),e		;85c2
	ld a,l			;85c4
	ld e,a			;85c5
	rlca			;85c6
	rlca			;85c7
	and 003h		;85c8
	out (c),a		;85ca
	pop hl			;85cc
	out (c),h		;85cd
	xor a			;85cf
	out (c),a		;85d0
	out (c),l		;85d2
	out (c),a		;85d4
	out (c),a		;85d6
	out (c),a		;85d8
	ld a,e			;85da
	rra			;85db
	rra			;85dc
	and 00fh		;85dd
	or 090h		;85df
	out (c),a		;85e1
	ei			;85e3
	ret			;85e4
L_85E5:
	ld (0faf5h),a		;85e5
	ld d,a			;85e8
	add a,a			;85e9
	ld l,a			;85ea
	add a,a			;85eb
	add a,a			;85ec
	add a,a			;85ed
	ld e,a			;85ee
	add a,a			;85ef
	ld h,a			;85f0
	ld a,(0f3e1h)		;85f1
	and 01fh		;85f4
	or h			;85f6
	ld b,a			;85f7
	ld c,002h		;85f8
	call 00047h		;85fa   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0ffe9h)		;85fd
	and 001h		;8600
	or l			;8602
	ld b,a			;8603
	ld c,00ah		;8604
	call 00047h		;8606   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0f3e3h)		;8609
	and 00fh		;860c
	or e			;860e
	ld b,a			;860f
	ld c,004h		;8610
	call 00047h		;8612   ; BIOS WRTVDP - Writes data in the VDP-register
	ld b,d			;8615
	ld c,00bh		;8616
	call 00047h		;8618   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0f3e5h)		;861b
	and 00fh		;861e
	or e			;8620
	ld b,a			;8621
	ld c,006h		;8622
	call 00047h		;8624   ; BIOS WRTVDP - Writes data in the VDP-register
	ret			;8627
L_8628:
	call L_867F		;8628
	call L_8733		;862b
	djnz L_8628		;862e
	ret			;8630
L_8631:
	push bc			;8631
	push de			;8632
	push hl			;8633
	push de			;8634
	call L_864F		;8635
	pop de			;8638
	ld hl,0e090h		;8639
	ld bc,00808h		;863c
	ld a,001h		;863f
	call L_8448		;8641
	call L_8305		;8644
	pop hl			;8647
	ld bc,00008h		;8648
	add hl,bc			;864b
	pop de			;864c
	pop bc			;864d
	ret			;864e
L_864F:
	ld b,008h		;864f
	ld de,0e090h		;8651
L_8654:
	push bc			;8654
	push hl			;8655
	ex de,hl			;8656
	ld a,(de)			;8657
	ld d,a			;8658
	ld b,004h		;8659
L_865B:
	ld a,c			;865b
	rl d		;865c
	jr c,L_8664		;865e
	rrca			;8660
	rrca			;8661
	rrca			;8662
	rrca			;8663
L_8664:
	and 00fh		;8664
	rld		;8666
	ld a,c			;8668
	rl d		;8669
	jr c,L_8671		;866b
	rrca			;866d
	rrca			;866e
	rrca			;866f
	rrca			;8670
L_8671:
	and 00fh		;8671
	rld		;8673
	inc hl			;8675
	djnz L_865B		;8676
	ex de,hl			;8678
	pop hl			;8679
	inc hl			;867a
	pop bc			;867b
	djnz L_8654		;867c
	ret			;867e
L_867F:
	push bc			;867f
	push de			;8680
	push hl			;8681
	push de			;8682
	call L_864F		;8683
	pop de			;8686
	ld b,d			;8687
	ld d,e			;8688
	ld e,b			;8689
	srl d		;868a
	rr e		;868c
	ld a,d			;868e
	add a,080h		;868f
	ld d,a			;8691
	ld hl,0e090h		;8692
	ld b,008h		;8695
L_8697:
	push bc			;8697
	ld bc,00004h		;8698
	call L_8137		;869b
	ex de,hl			;869e
	ld bc,00080h		;869f
	add hl,bc			;86a2
	ex de,hl			;86a3
	pop bc			;86a4
	djnz L_8697		;86a5
	pop hl			;86a7
	ld bc,00008h		;86a8
	add hl,bc			;86ab
	pop de			;86ac
	pop bc			;86ad
	ret			;86ae
L_86AF:
	ld c,0ffh		;86af
	jr L_86B5		;86b1
L_86B3:
	ld c,000h		;86b3
L_86B5:
	ld d,(hl)			;86b5
	inc hl			;86b6
	ld e,(hl)			;86b7
	inc hl			;86b8
L_86B9:
	ld a,(hl)			;86b9
	inc hl			;86ba
	ld b,a			;86bb
	inc b			;86bc
	ret z			;86bd
	inc b			;86be
	jr z,L_86AF		;86bf
	and c			;86c1
	call L_86FC		;86c2
	ld a,d			;86c5
	add a,008h		;86c6
	ld d,a			;86c8
	jr L_86B9		;86c9
L_86CB:
	ld a,(hl)			;86cb
	inc hl			;86cc
	ld b,a			;86cd
	inc b			;86ce
	ret z			;86cf
	inc b			;86d0
	and c			;86d1
	ex de,hl			;86d2
	call 0004dh		;86d3   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;86d6
	inc de			;86d7
	push bc			;86d8
	push hl			;86d9
	push de			;86da
	call L_8720		;86db
	ld bc,00808h		;86de
	ld a,001h		;86e1
	call L_8404		;86e3
	pop de			;86e6
	pop hl			;86e7
	pop bc			;86e8
	ret			;86e9
L_86EA:
	push bc			;86ea
	push hl			;86eb
	push de			;86ec
	call L_8720		;86ed
	ld bc,00808h		;86f0
	ld a,001h		;86f3
	call L_8404		;86f5
	pop de			;86f8
	pop hl			;86f9
	pop bc			;86fa
	ret			;86fb
L_86FC:
	push bc			;86fc
	push hl			;86fd
	push de			;86fe
	call L_8720		;86ff
	ld bc,00808h		;8702
	ld a,048h		;8705
	call L_8599		;8707
	pop de			;870a
	pop hl			;870b
	pop bc			;870c
	ret			;870d
L_870E:
	push bc			;870e
	push hl			;870f
	push de			;8710
	call L_8720		;8711
	ld bc,00808h		;8714
	ld a,005h		;8717
	call L_8404		;8719
	pop de			;871c
	pop hl			;871d
	pop bc			;871e
	ret			;871f
L_8720:
	and a			;8720
	jr z,L_8725		;8721
	sub 020h		;8723
L_8725:
	ld b,a			;8725
	and 01fh		;8726
	add a,a			;8728
	add a,a			;8729
	add a,a			;872a
	ld h,a			;872b
	ld a,b			;872c
	and 0e0h		;872d
	rrca			;872f
	rrca			;8730
	ld l,a			;8731
	ret			;8732
L_8733:
	ld a,d			;8733
	add a,008h		;8734
	ld d,a			;8736
	ret nz			;8737
	ld a,e			;8738
	add a,008h		;8739
	ld e,a			;873b
	ret			;873c
L_873D:
	ld hl,00000h		;873d
	ld bc,04000h		;8740
	xor a			;8743
	call 00056h		;8744   ; BIOS FILVRM - Fills VRAM with value
	ld hl,08758h		;8747
	ld d,008h		;874a
	ld c,000h		;874c
L_874E:
	ld b,(hl)			;874e
	call 00047h		;874f   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;8752
	inc c			;8753
	dec d			;8754
	jr nz,L_874E		;8755
	ret			;8757

; ----------------------------------------------------------------------
; DATOS resto_8758: lo apuntan con el banco puesto p05:8747 (0x8758); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8747 (8 bytes)
;   0x8758..0x8760  (8 bytes)
DATA_resto_8758:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0efh	; 8758  .....v..

; ======================================================================
; CODIGO 0x8760..0x877f  (31 bytes)
; ======================================================================


L_8760:
	ld c,007h		;8760
	jp L_8765		;8762
L_8765:
	jp 00047h		;8765   ; BIOS WRTVDP - Writes data in the VDP-register
L_8768:
	ld a,(0f0f5h)		;8768
	and a			;876b
	jr nz,$+27		;876c
	ld hl,0877fh		;876e
	ld bc,00800h		;8771
L_8774:
	push bc			;8774
	ld b,(hl)			;8775
	call 00047h		;8776   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;8779
	inc hl			;877a
	inc c			;877b
	djnz L_8774		;877c
	ret			;877e

; ----------------------------------------------------------------------
; DATOS resto_877F: lo apuntan con el banco puesto p05:876E (0x877F); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:876E (8 bytes)
;   0x877f..0x8787  (8 bytes)
DATA_resto_877F:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 877f  .....v..

; ======================================================================
; CODIGO 0x8787..0x87b2  (43 bytes)
; ======================================================================


L_8787:
	ld a,005h		;8787
	call 0005fh		;8789   ; BIOS CHGMOD - Switches to given screen mode
	ld a,00fh		;878c
	ld (0f3ebh),a		;878e
	call 00062h		;8791   ; BIOS CHGCLR - Changes the screen colors
	ld b,004h		;8794
	ld hl,087b2h		;8796
L_8799:
	push bc			;8799
	ld c,(hl)			;879a
	inc hl			;879b
	ld b,(hl)			;879c
	inc hl			;879d
	push hl			;879e
	call 00047h		;879f   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;87a2
	pop bc			;87a3
	djnz L_8799		;87a4
	call L_82C3		;87a6
	ld bc,00007h		;87a9
	call 00047h		;87ac   ; BIOS WRTVDP - Writes data in the VDP-register
	jp L_8283		;87af

; ----------------------------------------------------------------------
; DATOS resto_87B2: lo apuntan con el banco puesto p05:8796 (0x87B2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8796 (8 bytes)
;   0x87b2..0x87ba  (8 bytes)
DATA_resto_87B2:
	defb 001h,062h,005h,0efh,006h,01fh,00bh,001h	; 87b2  .b......

; ======================================================================
; CODIGO 0x87ba..0x8808  (78 bytes)
; ======================================================================


L_87BA:
	call L_87D2		;87ba
	ld de,08808h		;87bd
	ld hl,02080h		;87c0
	call L_80C0		;87c3
	ld a,0f4h		;87c6
	ld hl,00080h		;87c8
	ld bc,00780h		;87cb
	call L_80AF		;87ce
	ret			;87d1
L_87D2:
	ld hl,02000h		;87d2
	ld bc,00080h		;87d5
	xor a			;87d8
	call L_80AF		;87d9
	ld hl,00000h		;87dc
	ld de,00008h		;87df
	ld b,010h		;87e2
L_87E4:
	push bc			;87e4
	ld bc,00008h		;87e5
	push hl			;87e8
	call L_80AF		;87e9
	pop hl			;87ec
	add hl,de			;87ed
	inc a			;87ee
	pop bc			;87ef
	djnz L_87E4		;87f0
	ret			;87f2
L_87F3:
	ld hl,02500h		;87f3
	ld de,08951h		;87f6
	call L_80F7		;87f9
	ld a,0f4h		;87fc
	ld hl,00500h		;87fe
	ld bc,000c0h		;8801
	call L_80AF		;8804
	ret			;8807

; ----------------------------------------------------------------------
; DATOS resto_8808: lo apuntan con el banco puesto p05:87BD (0x8808), p05:87F6
;   (0x8951); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:87BD, p05:87F6 (358 bytes)
;   0x8808..0x896e  (358 bytes)
DATA_resto_8808:
	defb 08bh,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,004h,018h,0c9h,07eh	; 8808  ..."ccc"...8...~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 8818  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 8828  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 8838  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 8848  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,0a8h,000h,07eh,063h,063h,063h,07eh,060h	; 8858  <B....B<..~ccc~`
	defb 060h,000h,03eh,063h,060h,03eh,003h,063h,03eh,000h,03ch,018h,018h,018h,018h,018h	; 8868  `.>c`>.c>.<.....
	defb 03ch,000h,018h,018h,07eh,07eh,018h,018h,000h,000h,000h,000h,07eh,07eh,000h,000h	; 8878  <...~~......~~..
	defb 000h,004h,000h,001h,07eh,004h,000h,0c1h,01ch,036h,063h,063h,07fh,063h,063h,000h	; 8888  ....~....6cc.cc.
	defb 07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h,03eh,000h	; 8898  ~cc~cc~.>c```c>.
	defb 07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h,07fh,000h	; 88a8  |fcccf|..``~``..
	defb 07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h,03fh,000h	; 88b8  .``~```.>c`gcc?.
	defb 063h,063h,063h,07fh,063h,063h,063h,000h,03ch,005h,018h,083h,03ch,000h,01fh,004h	; 88c8  ccc.ccc.<...<...
	defb 006h,08bh,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh,067h,000h,006h,060h,093h	; 88d8  ..f<.cflx|ng..`.
	defb 07fh,000h,063h,077h,07fh,07fh,06bh,063h,063h,000h,063h,073h,07bh,07fh,06fh,067h	; 88e8  ..cw..kcc.cs{.og
	defb 063h,000h,03eh,005h,063h,0a3h,03eh,000h,07eh,063h,063h,063h,07eh,060h,060h,000h	; 88f8  c.>.c.>.~ccc~``.
	defb 03eh,063h,063h,063h,06fh,066h,03dh,000h,07eh,063h,063h,062h,07ch,066h,063h,000h	; 8908  >cccof=.~ccb|fc.
	defb 03eh,063h,060h,03eh,003h,063h,03eh,000h,07eh,006h,018h,001h,000h,006h,063h,082h	; 8918  >c`>.c>.~.....c.
	defb 03eh,000h,004h,063h,0a3h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h,022h	; 8928  >..c.6...cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h,018h	; 8938  .cv<..7c.ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh,000h,001h,0ffh,007h,080h,007h,080h,001h	; 8948  .....8p.........
	defb 0ffh,008h,080h,001h,0ffh,007h,001h,007h,001h,001h,0ffh,008h,001h,001h,0ffh,007h	; 8958  ................
	defb 000h,007h,000h,001h,0ffh,000h	; 8968

; ======================================================================
; CODIGO 0x896e..0x89b4  (70 bytes)
; ======================================================================


L_896E:
	ld a,001h		;896e
	ld (0faf6h),a		;8970
	ld de,00000h		;8973
	ld bc,01000h		;8976
L_8979:
	push bc			;8979
	push de			;897a
	ld hl,08b0ch		;897b
	call L_867F		;897e
	pop de			;8981
	call L_8733		;8982
	pop bc			;8985
	inc c			;8986
	djnz L_8979		;8987
	ld de,00008h		;8989
	ld a,020h		;898c
	call L_89A8		;898e
	ld bc,0600fh		;8991
	call L_8628		;8994
	ld de,08000h		;8997
	ld hl,089b4h		;899a
	ld bc,02b0fh		;899d
	call L_8628		;89a0
	xor a			;89a3
	ld (0faf6h),a		;89a4
	ret			;89a7
L_89A8:
	ld l,a			;89a8
	ld h,000h		;89a9
	ld bc,(00004h)		;89ab
	add hl,hl			;89af
	add hl,hl			;89b0
	add hl,hl			;89b1
	add hl,bc			;89b2
	ret			;89b3

; ----------------------------------------------------------------------
; DATOS resto_89B4: lo apuntan con el banco puesto p05:899A (0x89B4), p05:897B
;   (0x8B0C); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:899A, p05:897B (352 bytes)
;   0x89b4..0x8b14  (352 bytes)
DATA_resto_89B4:
	defb 000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,018h,018h,018h,018h,07eh	; 89b4  .."ccc"...8....~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 89c4  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 89d4  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 89e4  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 89f4  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,000h,018h,018h,07eh,07eh,018h,018h,000h	; 8a04  <B....B<...~~...
	defb 000h,000h,000h,07eh,07eh,000h,000h,000h,000h,000h,000h,0eeh,06bh,06bh,06bh,0ebh	; 8a14  ...~~.......kkk.
	defb 000h,000h,000h,073h,01ah,07ah,05ah,07ah,000h,003h,000h,0f3h,05bh,05bh,05bh,05bh	; 8a24  ...s.zZz....[[[[
	defb 000h,000h,000h,000h,07eh,000h,000h,000h,000h,01ch,036h,063h,063h,07fh,063h,063h	; 8a34  ....~.....6cc.cc
	defb 000h,07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h,03eh	; 8a44  .~cc~cc~.>c```c>
	defb 000h,07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h,07fh	; 8a54  .|fcccf|..``~``.
	defb 000h,07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h,03fh	; 8a64  ..``~```.>c`gcc?
	defb 000h,063h,063h,063h,07fh,063h,063h,063h,000h,03ch,018h,018h,018h,018h,018h,03ch	; 8a74  .ccc.ccc.<.....<
	defb 000h,01fh,006h,006h,006h,006h,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh,067h	; 8a84  ......f<.cflx|ng
	defb 000h,060h,060h,060h,060h,060h,060h,07fh,000h,063h,077h,07fh,07fh,06bh,063h,063h	; 8a94  .``````..cw..kcc
	defb 000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,063h,063h,063h,063h,063h,03eh	; 8aa4  .cs{.ogc.>ccccc>
	defb 000h,07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h,03dh	; 8ab4  .~ccc~``.>cccof=
	defb 000h,07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h,03eh	; 8ac4  .~ccb|fc.>c`>.c>
	defb 000h,07eh,018h,018h,018h,018h,018h,018h,000h,063h,063h,063h,063h,063h,063h,03eh	; 8ad4  .~.......cccccc>
	defb 000h,063h,063h,063h,063h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h,022h	; 8ae4  .cccc6...cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h,018h	; 8af4  .cv<..7c.ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8b04  .....8p.........

; ======================================================================
; CODIGO 0x8b14..0x8b1b  (7 bytes)
; ======================================================================


L_8B14:
	call L_8B58		;8b14
	call L_8B40		;8b17
	jp (hl)			;8b1a

; ----------------------------------------------------------------------
; DATOS resto_8B1B: lo apuntan con el banco puesto p05:8B40 (0x8B1B), p05:8B49
;   (0x8B29); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:8B40, p05:8B49 (37 bytes)
;   0x8b1b..0x8b40  (37 bytes)
DATA_resto_8B1B:
	defb 05dh,08bh,06fh,08bh,078h,08bh,08dh,08bh,0bdh,08bh,0dbh,08bh,02bh,08ch,066h,08bh	; 8b1b  ].o.x.......+.f.
	defb 06fh,08bh,084h,08bh,0a5h,08bh,0cfh,08bh,002h,08ch,02bh,08ch,0cdh,02fh,08ch,03ah	; 8b2b  o.........+../.:
	defb 058h,0e0h,0e6h,004h,0c9h	; 8b3b

; ======================================================================
; CODIGO 0x8b40..0x8ce2  (418 bytes)
; ======================================================================


L_8B40:
	ld hl,08b1bh		;8b40
	ld a,(0f0f5h)		;8b43
	and a			;8b46
	jr z,L_8B4C		;8b47
	ld hl,08b29h		;8b49
L_8B4C:
	ld a,(0e002h)		;8b4c
	add a,a			;8b4f
	call L_806E		;8b50
	ld e,(hl)			;8b53
	inc hl			;8b54
	ld d,(hl)			;8b55
	ex de,hl			;8b56
	ret			;8b57
L_8B58:
	ld hl,0e001h		;8b58
	inc (hl)			;8b5b
	ret			;8b5c
L_8B5D:
	call L_95B7		;8b5d
	jp c,L_8C59		;8b60
	jp L_8C6A		;8b63
L_8B66:
	call L_9701		;8b66
	jp c,L_8C59		;8b69
	jp L_8C6A		;8b6c
L_8B6F:
	call L_8E34		;8b6f
	call L_9386		;8b72
	jp L_8C59		;8b75
L_8B78:
	call L_9DE1		;8b78
	call L_9DFE		;8b7b
	call L_8D07		;8b7e
	jp L_8C59		;8b81
L_8B84:
	call L_9FEC		;8b84
	call 0a336h		;8b87
	jp L_8C59		;8b8a
L_8B8D:
	ld a,(0e001h)		;8b8d
	and 03fh		;8b90
	jr nz,L_8BA2		;8b92
	call L_90B8		;8b94
	call L_9179		;8b97
	ld a,(0e03fh)		;8b9a
	cp 0c0h		;8b9d
	jp nc,L_8C59		;8b9f
L_8BA2:
	jp L_8C6A		;8ba2
L_8BA5:
	ld a,(0e001h)		;8ba5
	and 07fh		;8ba8
	jr nz,L_8BBA		;8baa
	call L_923E		;8bac
	call L_9179		;8baf
	ld a,(0e03fh)		;8bb2
	cp 0c0h		;8bb5
	jp nc,L_8C59		;8bb7
L_8BBA:
	jp L_8C6A		;8bba
L_8BBD:
	call L_9DF1		;8bbd
	call L_9CCB		;8bc0
	call L_9D21		;8bc3
	call L_9D55		;8bc6
	call L_8D07		;8bc9
	jp L_8C59		;8bcc
L_8BCF:
	call L_9FF6		;8bcf
	call L_9CCB		;8bd2
	call 0a3a4h		;8bd5
	jp L_8C59		;8bd8
L_8BDB:
	ld a,(0e001h)		;8bdb
	and 007h		;8bde
	jr nz,L_8BFF		;8be0
	call L_8D07		;8be2
	call L_8CFA		;8be5
	call L_8C2F		;8be8
	ld a,(0e058h)		;8beb
	cp 001h		;8bee
	jr z,L_8C59		;8bf0
	cp 004h		;8bf2
	jr z,L_8C2E		;8bf4
	call L_9D16		;8bf6
	call L_8C2F		;8bf9
	ld a,(0e058h)		;8bfc
L_8BFF:
	jp L_8C6A		;8bff
L_8C02:
	ld a,(0e001h)		;8c02
	and 00fh		;8c05
	jr nz,L_8C20		;8c07
	call L_8DD5		;8c09
	call 0a27eh		;8c0c
	call L_8C2F		;8c0f
	ld a,(0e058h)		;8c12
	cp 001h		;8c15
	jr z,L_8C59		;8c17
	cp 004h		;8c19
	jr z,L_8C2E		;8c1b
	call L_9B3E		;8c1d
L_8C20:
	call L_8C26		;8c20
	jp L_8C6A		;8c23
L_8C26:
	ld b,010h		;8c26
L_8C28:
	djnz L_8C28		;8c28
	ret			;8c2a
L_8C2B:
	jp L_8000		;8c2b
L_8C2E:
	ret			;8c2e
L_8C2F:
	ld hl,0e057h		;8c2f
	call L_8C3D		;8c32
	ld (hl),a			;8c35
	inc hl			;8c36
	ld b,(hl)			;8c37
	ld c,a			;8c38
	xor b			;8c39
	and c			;8c3a
	ld (hl),a			;8c3b
	ret			;8c3c
L_8C3D:
	ld a,008h		;8c3d
	call 00141h		;8c3f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8c42
	and 099h		;8c43
	push af			;8c45
	ld a,007h		;8c46
	call 00141h		;8c48   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8c4b
	and 004h		;8c4c
	ld b,a			;8c4e
	pop af			;8c4f
	or b			;8c50
	ret			;8c51
L_8C52:
	ld hl,0e002h		;8c52
	dec (hl)			;8c55
	jp L_8B14		;8c56
L_8C59:
	ld hl,0e002h		;8c59
	inc (hl)			;8c5c
	call L_8C6D		;8c5d
	jp L_8B14		;8c60
L_8C63:
	ld hl,0e003h		;8c63
	inc (hl)			;8c66
	jp L_8B14		;8c67
L_8C6A:
	jp L_8B14		;8c6a
L_8C6D:
	xor a			;8c6d
	ld hl,0e003h		;8c6e
	ld (hl),a			;8c71
	ret			;8c72
L_8C73:
	call L_8C8C		;8c73
	call L_8D14		;8c76
	call L_87BA		;8c79
	call L_87F3		;8c7c
	call L_8CA1		;8c7f
	call L_8CD1		;8c82
	call L_8CB7		;8c85
	call L_8C92		;8c88
	ret			;8c8b
L_8C8C:
	ld b,000h		;8c8c
	call L_8760		;8c8e
	ret			;8c91
L_8C92:
	ld hl,0e300h		;8c92
	ld de,0e301h		;8c95
	ld bc,0013fh		;8c98
	ld a,004h		;8c9b
	ld (hl),a			;8c9d
	ldir		;8c9e
	ret			;8ca0
L_8CA1:
	ld hl,02a00h		;8ca1
	ld bc,00dffh		;8ca4
	xor a			;8ca7
	call 00056h		;8ca8   ; BIOS FILVRM - Fills VRAM with value
	ld hl,00a00h		;8cab
	ld bc,011ffh		;8cae
	ld a,0f4h		;8cb1
	call 00056h		;8cb3   ; BIOS FILVRM - Fills VRAM with value
	ret			;8cb6
L_8CB7:
	ld hl,0e400h		;8cb7
	ld b,002h		;8cba
L_8CBC:
	xor a			;8cbc
L_8CBD:
	ld (hl),a			;8cbd
	inc hl			;8cbe
	inc a			;8cbf
	cp 000h		;8cc0
	jr nz,L_8CBD		;8cc2
	djnz L_8CBC		;8cc4
	ld hl,0e400h		;8cc6
	xor a			;8cc9
	ld b,040h		;8cca
L_8CCC:
	ld (hl),a			;8ccc
	inc hl			;8ccd
	djnz L_8CCC		;8cce
	ret			;8cd0
L_8CD1:
	ld hl,01800h		;8cd1
	ld de,08dcch		;8cd4
	call L_80F7		;8cd7
	ret			;8cda
L_8CDB:
	ld hl,08ce2h		;8cdb
	call L_8DA1		;8cde
	ret			;8ce1

; ----------------------------------------------------------------------
; DATOS resto_8CE2: lo apuntan con el banco puesto p05:8CDB (0x8CE2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8CDB (24 bytes)
;   0x8ce2..0x8cfa  (24 bytes)
DATA_resto_8CE2:
	defb 050h,05bh,000h,00fh,060h,05bh,000h,00fh,070h,05bh,000h,00fh,080h,05bh,000h,00fh	; 8ce2  P[..`[..p[...[..
	defb 090h,05bh,000h,00fh,0a0h,05bh,000h,00fh	; 8cf2  .[...[..

; ======================================================================
; CODIGO 0x8cfa..0x8d77  (125 bytes)
; ======================================================================


L_8CFA:
	ld hl,03b00h		;8cfa
	ld de,0e280h		;8cfd
	ld bc,0001eh		;8d00
	call L_8098		;8d03
	ret			;8d06
L_8D07:
	ld hl,03800h		;8d07
	ld de,0e300h		;8d0a
	ld bc,00300h		;8d0d
	call L_8098		;8d10
	ret			;8d13
L_8D14:
	ld hl,0e280h		;8d14
	ld de,0e281h		;8d17
	ld bc,0007fh		;8d1a
	ld (hl),0e0h		;8d1d
	ldir		;8d1f
	ret			;8d21
L_8D22:
	call L_827B		;8d22
	call L_8D70		;8d25
	call L_8D61		;8d28
	call L_8D38		;8d2b
	call L_896E		;8d2e
	call L_8DF9		;8d31
	call L_8261		;8d34
	ret			;8d37
L_8D38:
	ld hl,00000h		;8d38
	call L_8D4A		;8d3b
	ld hl,00040h		;8d3e
	call L_8D4A		;8d41
	ld hl,00080h		;8d44
	call L_8D4A		;8d47
L_8D4A:
	ld bc,00808h		;8d4a
	ld a,001h		;8d4d
	ld d,a			;8d4f
	jp L_83C8		;8d50
L_8D53:
	xor a			;8d53
	ld hl,0e000h		;8d54
	ld de,0e001h		;8d57
	ld bc,000ffh		;8d5a
	ld (hl),a			;8d5d
	ldir		;8d5e
	ret			;8d60
L_8D61:
	ld a,0d8h		;8d61
	ld hl,0e280h		;8d63
	ld de,0e281h		;8d66
	ld bc,0007fh		;8d69
	ld (hl),a			;8d6c
	ldir		;8d6d
	ret			;8d6f
L_8D70:
	ld hl,08d77h		;8d70
	call L_82C6		;8d73
	ret			;8d76

; ----------------------------------------------------------------------
; DATOS resto_8D77: lo apuntan con el banco puesto p05:8D70 (0x8D77); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8D70 (32 bytes)
;   0x8d77..0x8d97  (32 bytes)
DATA_resto_8D77:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 8d77  ......3...'.Q.'.
	defb 071h,001h,013h,001h,016h,005h,061h,006h,077h,007h,077h,007h,077h,007h,077h,007h	; 8d87  q.....a.w.w.w.w.

; ======================================================================
; CODIGO 0x8d97..0x8daa  (19 bytes)
; ======================================================================


L_8D97:
	ld hl,08daah		;8d97
	call L_8DA1		;8d9a
	call L_8DC2		;8d9d
	ret			;8da0
L_8DA1:
	ld de,0e280h		;8da1
	ld bc,00018h		;8da4
	ldir		;8da7
	ret			;8da9

; ----------------------------------------------------------------------
; DATOS resto_8DAA: lo apuntan con el banco puesto p05:8D97 (0x8DAA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8D97 (24 bytes)
;   0x8daa..0x8dc2  (24 bytes)
DATA_resto_8DAA:
	defb 058h,05ch,000h,00fh,068h,05ch,000h,00fh,078h,05ch,000h,00fh,088h,05ch,000h,00fh	; 8daa  X\..h\..x\...\..
	defb 098h,05ch,000h,00fh,0a8h,05ch,000h,00fh	; 8dba  .\...\..

; ======================================================================
; CODIGO 0x8dc2..0x8dcc  (10 bytes)
; ======================================================================


L_8DC2:
	ld hl,0f800h		;8dc2
	ld de,08dcch		;8dc5
	call L_81EE		;8dc8
	ret			;8dcb

; ----------------------------------------------------------------------
; DATOS resto_8DCC: lo apuntan con el banco puesto p05:8CD4 (0x8DCC), p05:8DC5
;   (0x8DCC); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:8CD4, p05:8DC5 (9 bytes)
;   0x8dcc..0x8dd5  (9 bytes)
DATA_resto_8DCC:
	defb 008h,080h,008h,080h,008h,000h,008h,000h,000h	; 8dcc  .........

; ======================================================================
; CODIGO 0x8dd5..0x8e06  (49 bytes)
; ======================================================================


L_8DD5:
	ld de,0f600h		;8dd5
	ld hl,0e280h		;8dd8
	ld bc,0001ch		;8ddb
	call L_8137		;8dde
	ld hl,0f400h		;8de1
	ld bc,000e0h		;8de4
	ld a,00fh		;8de7
	call L_814A		;8de9
	ret			;8dec
L_8DED:
	call L_826E		;8ded
	call L_8261		;8df0
	ld a,001h		;8df3
	ld (0e008h),a		;8df5
	ret			;8df8
L_8DF9:
	ld de,00018h		;8df9
	ld hl,08e06h		;8dfc
	ld bc,0020fh		;8dff
	call L_8628		;8e02
	ret			;8e05

; ----------------------------------------------------------------------
; DATOS resto_8E06: lo apuntan con el banco puesto p05:8DFC (0x8E06); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8DFC (46 bytes)
;   0x8e06..0x8e34  (46 bytes)
DATA_resto_8E06:
	defb 000h,000h,000h,0ffh,0ffh,000h,000h,000h,018h,018h,018h,0ffh,0ffh,018h,018h,018h	; 8e06  ................
	defb 001h,007h,002h,0cdh,047h,000h,0cdh,048h,082h,0c9h,0cdh,06eh,082h,021h,000h,000h	; 8e16  ....G..H...n.!..
	defb 001h,000h,000h,03eh,0ddh,016h,000h,0cdh,0c8h,083h,0cdh,061h,082h,0c9h	; 8e26  ...>.......a..

; ======================================================================
; CODIGO 0x8e34..0x9043  (527 bytes)
; ======================================================================


L_8E34:
	call L_8E56		;8e34
	call L_8E7E		;8e37
	call L_8E91		;8e3a
	call L_8EA4		;8e3d
	call L_8EB7		;8e40
	call L_8F83		;8e43
	call L_8F98		;8e46
	call L_8FCC		;8e49
	call L_901A		;8e4c
	call L_9049		;8e4f
	call L_9055		;8e52
	ret			;8e55
L_8E56:
	ld ix,0e018h		;8e56
	ld hl,(0e010h)		;8e5a
	call L_8E6B		;8e5d
	ld ix,0e01ch		;8e60
	ld hl,(0e012h)		;8e64
	call L_8E6B		;8e67
	ret			;8e6a
L_8E6B:
	ld de,0016dh		;8e6b
	call L_9405		;8e6e
	ld (ix+000h),e		;8e71
	ld (ix+001h),d		;8e74
	ld (ix+002h),l		;8e77
	ld (ix+003h),h		;8e7a
	ret			;8e7d
L_8E7E:
	ld hl,(0e010h)		;8e7e
	ld de,0e018h		;8e81
	call L_8ED2		;8e84
	ld hl,(0e012h)		;8e87
	ld de,0e01ch		;8e8a
	call L_8ED2		;8e8d
	ret			;8e90
L_8E91:
	ld hl,(0e010h)		;8e91
	ld de,0e018h		;8e94
	call L_8EF1		;8e97
	ld hl,(0e012h)		;8e9a
	ld de,0e01ch		;8e9d
	call L_8EF1		;8ea0
	ret			;8ea3
L_8EA4:
	ld hl,(0e010h)		;8ea4
	ld de,0e018h		;8ea7
	call L_8F08		;8eaa
	ld hl,(0e012h)		;8ead
	ld de,0e01ch		;8eb0
	call L_8F08		;8eb3
	ret			;8eb6
L_8EB7:
	ld hl,0e010h		;8eb7
	ld ix,0e014h		;8eba
	ld de,0e018h		;8ebe
	call L_8F1F		;8ec1
	ld hl,0e012h		;8ec4
	ld ix,0e015h		;8ec7
	ld de,0e01ch		;8ecb
	call L_8F1F		;8ece
	ret			;8ed1
L_8ED2:
	push de			;8ed2
	ld de,00004h		;8ed3
	call L_8EE5		;8ed6
	pop de			;8ed9
	jr c,L_8EE4		;8eda
	call L_94CF		;8edc
	ex de,hl			;8edf
	call L_93F0		;8ee0
	ret			;8ee3
L_8EE4:
	ret			;8ee4
L_8EE5:
	dec hl			;8ee5
	ld a,h			;8ee6
	and 080h		;8ee7
	jr nz,L_8EEF		;8ee9
	rst 20h			;8eeb
	jr c,L_8EEF		;8eec
	ret			;8eee
L_8EEF:
	scf			;8eef
	ret			;8ef0
L_8EF1:
	push de			;8ef1
	ld de,00064h		;8ef2
	call L_8EE5		;8ef5
	pop de			;8ef8
	jr c,L_8F07		;8ef9
	push de			;8efb
	ex de,hl			;8efc
	ld bc,00064h		;8efd
	call L_9430		;8f00
	pop hl			;8f03
	call L_93A7		;8f04
L_8F07:
	ret			;8f07
L_8F08:
	push de			;8f08
	ld de,00190h		;8f09
	call L_8EE5		;8f0c
	pop de			;8f0f
	jr c,L_8F1E		;8f10
	push de			;8f12
	ex de,hl			;8f13
	ld bc,00190h		;8f14
	call L_9430		;8f17
	pop hl			;8f1a
	call L_93F0		;8f1b
L_8F1E:
	ret			;8f1e
L_8F1F:
	push de			;8f1f
	push hl			;8f20
	ld a,(ix+000h)		;8f21
	dec a			;8f24
	ld hl,0959eh		;8f25
	add a,a			;8f28
	call L_806E		;8f29
	ld d,(hl)			;8f2c
	inc hl			;8f2d
	ld e,(hl)			;8f2e
	ld a,(ix+002h)		;8f2f
	call L_8073		;8f32
	pop hl			;8f35
	push de			;8f36
	call L_8F4A		;8f37
	pop de			;8f3a
	jr nc,L_8F45		;8f3b
	ld a,002h		;8f3d
	cp (ix+000h)		;8f3f
	jr nc,L_8F45		;8f42
	inc de			;8f44
L_8F45:
	pop hl			;8f45
	call L_93F0		;8f46
	ret			;8f49
L_8F4A:
	xor a			;8f4a
	ld (0e041h),a		;8f4b
	ld e,(hl)			;8f4e
	inc hl			;8f4f
	ld d,(hl)			;8f50
	ld bc,00004h		;8f51
	push de			;8f54
	call L_9430		;8f55
	pop de			;8f58
	ld a,l			;8f59
	and a			;8f5a
	jr nz,L_8F7E		;8f5b
	ld bc,00064h		;8f5d
	push de			;8f60
	call L_9430		;8f61
	pop de			;8f64
	ld a,l			;8f65
	and a			;8f66
	jr nz,L_8F77		;8f67
	ld bc,00190h		;8f69
	call L_9430		;8f6c
	ld a,h			;8f6f
	and a			;8f70
	jr nz,L_8F7E		;8f71
	ld a,l			;8f73
	and a			;8f74
	jr nz,L_8F7E		;8f75
L_8F77:
	ld a,001h		;8f77
	ld (0e041h),a		;8f79
	scf			;8f7c
	ret			;8f7d
L_8F7E:
	xor a			;8f7e
	ld (0e041h),a		;8f7f
	ret			;8f82
L_8F83:
	ld hl,0e01ch		;8f83
	ld de,0e020h		;8f86
	ld bc,00004h		;8f89
	ldir		;8f8c
	ld hl,0e020h		;8f8e
	ld de,0e018h		;8f91
	call L_93B8		;8f94
	ret			;8f97
L_8F98:
	ld hl,(0e020h)		;8f98
	ld de,(0e022h)		;8f9b
	ld ix,0e02dh		;8f9f
	ld bc,00017h		;8fa3
	call L_8FEB		;8fa6
	ld hl,(0e020h)		;8fa9
	ld de,(0e022h)		;8fac
	ld ix,0e02fh		;8fb0
	ld bc,0001ch		;8fb4
	call L_8FEB		;8fb7
	ld hl,(0e020h)		;8fba
	ld de,(0e022h)		;8fbd
	ld ix,0e031h		;8fc1
	ld bc,00021h		;8fc5
	call L_8FEB		;8fc8
	ret			;8fcb
L_8FCC:
	ld ix,0e02dh		;8fcc
	ld bc,00017h		;8fd0
	call L_8FFB		;8fd3
	ld ix,0e02fh		;8fd6
	ld bc,0001ch		;8fda
	call L_8FFB		;8fdd
	ld ix,0e031h		;8fe0
	ld bc,00021h		;8fe4
	call L_8FFB		;8fe7
	ret			;8fea
L_8FEB:
	call L_90A0		;8feb
	jr c,L_8FF4		;8fee
	call L_944A		;8ff0
	ex de,hl			;8ff3
L_8FF4:
	ld (ix+000h),e		;8ff4
	ld (ix+001h),d		;8ff7
	ret			;8ffa
L_8FFB:
	ld e,(ix+000h)		;8ffb
	ld d,(ix+001h)		;8ffe
	call L_90AC		;9001
	jr z,L_9012		;9004
	push bc			;9006
	ld bc,00168h		;9007
	call L_93DB		;900a
	ex de,hl			;900d
	pop bc			;900e
	call L_9430		;900f
L_9012:
	ex de,hl			;9012
	ld (ix+000h),l		;9013
	ld (ix+001h),h		;9016
	ret			;9019
L_901A:
	ld b,003h		;901a
	ld ix,0e02dh		;901c
	ld iy,09043h		;9020
L_9024:
	ld l,(ix+000h)		;9024
	ld h,(ix+001h)		;9027
	ld e,(iy+000h)		;902a
	ld d,(iy+001h)		;902d
	xor a			;9030
	sbc hl,de		;9031
	ld (ix+000h),l		;9033
	ld (ix+001h),h		;9036
	ld de,00002h		;9039
	add ix,de		;903c
	add iy,de		;903e
	djnz L_9024		;9040
	ret			;9042

; ----------------------------------------------------------------------
; DATOS resto_9043: lo apuntan con el banco puesto p05:9020 (0x9043), p05:9CED
;   (0x9043); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9020, p05:9CED (6 bytes)
;   0x9043..0x9049  (6 bytes)
DATA_resto_9043:
	defb 0ebh,000h,0c1h,000h,0a4h,000h	; 9043

; ======================================================================
; CODIGO 0x9049..0x94e8  (1183 bytes)
; ======================================================================


L_9049:
	ld hl,0e02dh		;9049
	ld de,0e033h		;904c
	ld bc,00006h		;904f
	ldir		;9052
	ret			;9054
L_9055:
	ld hl,(0e02dh)		;9055
	call L_9085		;9058
	ld (0e02dh),hl		;905b
	call L_92A9		;905e
	ld (0e039h),a		;9061
	ld hl,(0e02fh)		;9064
	call L_9085		;9067
	call L_92A9		;906a
	ld (0e03bh),a		;906d
	ld hl,(0e031h)		;9070
	call L_9085		;9073
	call L_92A9		;9076
	ld (0e03dh),a		;9079
	ret			;907c
L_907D:
	push af			;907d
	push de			;907e
	call L_9085		;907f
	pop de			;9082
	pop af			;9083
	ret			;9084
L_9085:
	ld a,h			;9085
	add a,080h		;9086
	jr nc,L_9095		;9088
L_908A:
	ld de,00168h		;908a
	add hl,de			;908d
	ld a,h			;908e
	add a,080h		;908f
	jr c,L_908A		;9091
	jr L_909F		;9093
L_9095:
	push hl			;9095
	ld de,00168h		;9096
	sbc hl,de		;9099
	pop de			;909b
	jr nc,L_9095		;909c
	ex de,hl			;909e
L_909F:
	ret			;909f
L_90A0:
	ld a,d			;90a0
	add a,e			;90a1
	and a			;90a2
	ret nz			;90a3
	ld a,h			;90a4
	and a			;90a5
	ret nz			;90a6
	ld a,l			;90a7
	cp b			;90a8
	ret nc			;90a9
	ex de,hl			;90aa
	ret			;90ab
L_90AC:
	ld a,d			;90ac
	or e			;90ad
	and a			;90ae
	ret			;90af
L_90B0:
	ex de,hl			;90b0
	ld bc,00010h		;90b1
	call L_9430		;90b4
	ret			;90b7
L_90B8:
	call L_9265		;90b8
	call L_90C3		;90bb
	ld hl,0e03fh		;90be
	inc (hl)			;90c1
	ret			;90c2
L_90C3:
	ld hl,(0e05ah)		;90c3
	ld bc,001f0h		;90c6
	call L_90DF		;90c9
	ld hl,(0e05ch)		;90cc
	ld bc,00180h		;90cf
	call L_90DF		;90d2
	ld hl,(0e05eh)		;90d5
	ld bc,001c0h		;90d8
	call L_90DF		;90db
	ret			;90de
L_90DF:
	call L_90FD		;90df
	call L_9145		;90e2
	ld c,0f0h		;90e5
	call L_914F		;90e7
	ret			;90ea
L_90EB:
	ld a,l			;90eb
	cp 088h		;90ec
	jr z,L_90F9		;90ee
	ld a,h			;90f0
	cp 058h		;90f1
	jr c,L_90FB		;90f3
	cp 060h		;90f5
	jr nc,L_90FB		;90f7
L_90F9:
	scf			;90f9
	ret			;90fa
L_90FB:
	xor a			;90fb
	ret			;90fc
L_90FD:
	ld a,h			;90fd
	ld h,a			;90fe
	ld a,l			;90ff
	ld l,a			;9100
	sub 008h		;9101
	ld l,a			;9103
	ex de,hl			;9104
	push de			;9105
	ld l,e			;9106
	ld c,008h		;9107
	call L_94C1		;9109
	ld a,h			;910c
	ld (0e088h),hl		;910d
	ld b,000h		;9110
	ld c,l			;9112
	ld de,00100h		;9113
	call L_93DB		;9116
	ld a,(0e089h)		;9119
	call L_806E		;911c
	ld (0e08ch),hl		;911f
	pop de			;9122
	ld l,d			;9123
	ld c,008h		;9124
	call L_94C1		;9126
	ld (0e088h),hl		;9129
	ld b,000h		;912c
	ld c,l			;912e
	ld de,00008h		;912f
	call L_93DB		;9132
	ex de,hl			;9135
	ld hl,(0e08ch)		;9136
	add hl,de			;9139
	ld (0e08ch),hl		;913a
	ld a,(0e089h)		;913d
	ld b,a			;9140
	ld a,007h		;9141
	sub b			;9143
	ret			;9144
L_9145:
	inc a			;9145
	ld b,a			;9146
	ld a,001h		;9147
L_9149:
	sla a		;9149
	djnz L_9149		;914b
	rra			;914d
	ret			;914e
L_914F:
	ld b,a			;914f
	ld hl,(0e08ch)		;9150
	call 0004ah		;9153   ; BIOS RDVRM - Reads the content of VRAM
	cp 0f0h		;9156
	jr z,L_915C		;9158
	cp c			;915a
	ret nz			;915b
L_915C:
	ld a,c			;915c
	ld hl,(0e08ch)		;915d
	call 0004dh		;9160   ; BIOS WRTVRM - Writes data in VRAM
	ld de,02000h		;9163
	ld hl,(0e08ch)		;9166
	add hl,de			;9169
	call 0004ah		;916a   ; BIOS RDVRM - Reads the content of VRAM
	or b			;916d
	ld hl,(0e08ch)		;916e
	ld de,02000h		;9171
	add hl,de			;9174
	call 0004dh		;9175   ; BIOS WRTVRM - Writes data in VRAM
	ret			;9178
L_9179:
	call L_9183		;9179
	call L_9197		;917c
	call L_91B7		;917f
	ret			;9182
L_9183:
	ld a,(0e03fh)		;9183
	ld hl,0e06ch		;9186
	ld c,006h		;9189
	call L_9C61		;918b
	ret nc			;918e
	ld hl,(0e02fh)		;918f
	inc hl			;9192
	ld (0e02fh),hl		;9193
	ret			;9196
L_9197:
	ld a,(0e03fh)		;9197
	ld hl,0e06bh		;919a
	ld c,004h		;919d
	call L_9C61		;919f
	ret nc			;91a2
	ld a,(0e03fh)		;91a3
	ld hl,0e06dh		;91a6
	ld c,014h		;91a9
	call L_9C61		;91ab
	ret nc			;91ae
	ld hl,(0e02dh)		;91af
	dec hl			;91b2
	ld (0e02dh),hl		;91b3
	ret			;91b6
L_91B7:
	ld a,(0e06bh)		;91b7
	and a			;91ba
	ret z			;91bb
	ld hl,(0e031h)		;91bc
	inc hl			;91bf
	ld (0e031h),hl		;91c0
	ret			;91c3
L_91C4:
	call L_91CE		;91c4
	call L_91E2		;91c7
	call L_91FF		;91ca
	ret			;91cd
L_91CE:
	ld a,(0e03fh)		;91ce
	ld hl,0e06ch		;91d1
	ld c,006h		;91d4
	call L_9C48		;91d6
	ret nc			;91d9
	ld hl,(0e02fh)		;91da
	dec hl			;91dd
	ld (0e02fh),hl		;91de
	ret			;91e1
L_91E2:
	ld a,(0e03fh)		;91e2
	ld hl,0e06bh		;91e5
	ld c,004h		;91e8
	call L_9C48		;91ea
	ret nc			;91ed
	ld hl,0e06dh		;91ee
	ld c,014h		;91f1
	call L_9C48		;91f3
	ret nc			;91f6
	ld hl,(0e02dh)		;91f7
	inc hl			;91fa
	ld (0e02dh),hl		;91fb
	ret			;91fe
L_91FF:
	ld a,(0e06bh)		;91ff
	and a			;9202
	ret z			;9203
	ld hl,(0e031h)		;9204
	dec hl			;9207
	ld (0e031h),hl		;9208
	ret			;920b
L_920C:
	ld de,02000h		;920c
L_920F:
	add hl,de			;920f
	push af			;9210
	ld d,a			;9211
	call 0004ah		;9212   ; BIOS RDVRM - Reads the content of VRAM
	or d			;9215
	call 0004dh		;9216   ; BIOS WRTVRM - Writes data in VRAM
	pop af			;9219
	ld de,00008h		;921a
	djnz L_920F		;921d
	ret			;921f
L_9220:
	ld de,02000h		;9220
	add hl,de			;9223
L_9224:
	push bc			;9224
	push hl			;9225
	ld b,008h		;9226
L_9228:
	push af			;9228
	ld d,a			;9229
	call 0004ah		;922a   ; BIOS RDVRM - Reads the content of VRAM
	or d			;922d
	call 0004dh		;922e   ; BIOS WRTVRM - Writes data in VRAM
	pop af			;9231
	inc hl			;9232
	djnz L_9228		;9233
	pop hl			;9235
	ld de,00100h		;9236
	add hl,de			;9239
	pop bc			;923a
	djnz L_9224		;923b
	ret			;923d
L_923E:
	call L_9265		;923e
	call L_9249		;9241
	ld hl,0e03fh		;9244
	inc (hl)			;9247
	ret			;9248
L_9249:
	ld hl,(0e05ah)		;9249
	ld bc,0010ch		;924c
	call L_931C		;924f
	ld hl,(0e05ch)		;9252
	ld bc,0010dh		;9255
	call L_931C		;9258
	ld hl,(0e05eh)		;925b
	ld bc,0010eh		;925e
	call L_931C		;9261
	ret			;9264
L_9265:
	ld hl,0e02dh		;9265
	ld de,0e05ah		;9268
	ld a,004h		;926b
	call L_92C8		;926d
	ld hl,0e02fh		;9270
	ld de,0e05ch		;9273
	ld a,003h		;9276
	call L_92C8		;9278
	ld hl,0e031h		;927b
	ld de,0e05eh		;927e
	ld a,002h		;9281
	call L_92C8		;9283
	ret			;9286
L_9287:
	ld hl,0e02dh		;9287
	ld de,0e05ah		;928a
	ld a,0fch		;928d
	call L_92C8		;928f
	ld hl,0e02fh		;9292
	ld de,0e05ch		;9295
	ld a,0fdh		;9298
	call L_92C8		;929a
	ld hl,0e031h		;929d
	ld de,0e05eh		;92a0
	ld a,0feh		;92a3
	call L_92C8		;92a5
	ret			;92a8
L_92A9:
	ld hl,0e02dh		;92a9
	ld de,0e05ah		;92ac
	xor a			;92af
	call L_92C8		;92b0
	ld hl,0e02fh		;92b3
	ld de,0e05ch		;92b6
	xor a			;92b9
	call L_92C8		;92ba
	ld hl,0e031h		;92bd
	ld de,0e05eh		;92c0
	xor a			;92c3
	call L_92C8		;92c4
	ret			;92c7
L_92C8:
	push de			;92c8
	push hl			;92c9
	call L_92E3		;92ca
	pop hl			;92cd
	call L_930E		;92ce
	pop de			;92d1
	ex de,hl			;92d2
	call L_92D7		;92d3
	ret			;92d6
L_92D7:
	ld a,e			;92d7
	add a,088h		;92d8
	ld e,a			;92da
	ld (hl),a			;92db
	inc hl			;92dc
	ld a,d			;92dd
	add a,020h		;92de
	ld d,a			;92e0
	ld (hl),d			;92e1
	ret			;92e2
L_92E3:
	push hl			;92e3
	ld e,(hl)			;92e4
	inc hl			;92e5
	ld d,(hl)			;92e6
	call L_92F4		;92e7
	ex de,hl			;92ea
	call L_9085		;92eb
	ex de,hl			;92ee
	pop hl			;92ef
	ld (hl),e			;92f0
	inc hl			;92f1
	ld (hl),d			;92f2
	ret			;92f3
L_92F4:
	add a,080h		;92f4
	jr nc,L_92FC		;92f6
	call L_9302		;92f8
	ret			;92fb
L_92FC:
	add a,080h		;92fc
	call L_8073		;92fe
	ret			;9301
L_9302:
	add a,080h		;9302
	neg		;9304
	ld b,a			;9306
	ld a,e			;9307
	sub b			;9308
	ld e,a			;9309
	jr nc,L_930D		;930a
	dec d			;930c
L_930D:
	ret			;930d
L_930E:
	ld e,(hl)			;930e
	inc hl			;930f
	ld d,(hl)			;9310
	ex de,hl			;9311
	call L_932F		;9312
	ld e,a			;9315
	ld a,(0e03fh)		;9316
	ld d,a			;9319
	ex de,hl			;931a
	ret			;931b
L_931C:
	call L_8365		;931c
	ret			;931f
L_9320:
	scf			;9320
	ccf			;9321
	srl d		;9322
	rr e		;9324
	srl d		;9326
	rr e		;9328
	srl d		;932a
	rr e		;932c
	ret			;932e
L_932F:
	ld de,0010eh		;932f
	rst 20h			;9332
	jr nc,L_9374		;9333
	ld de,000b4h		;9335
	rst 20h			;9338
	jr nc,L_9363		;9339
	ld de,0005ah		;933b
	rst 20h			;933e
	jr nc,L_934F		;933f
	ld a,l			;9341
	add a,a			;9342
	ld hl,094e8h		;9343
	call L_806E		;9346
	ld a,(hl)			;9349
	neg		;934a
	inc hl			;934c
	ld b,(hl)			;934d
	ret			;934e
L_934F:
	ld de,000b4h		;934f
	ex de,hl			;9352
	sbc hl,de		;9353
	ld a,l			;9355
	add a,a			;9356
	ld hl,094e8h		;9357
	call L_806E		;935a
	ld a,(hl)			;935d
	neg		;935e
	inc hl			;9360
	ld b,(hl)			;9361
	ret			;9362
L_9363:
	ld de,000b4h		;9363
	sbc hl,de		;9366
	ld a,l			;9368
	add a,a			;9369
	ld hl,094e8h		;936a
	call L_806E		;936d
	ld a,(hl)			;9370
	inc hl			;9371
	ld b,(hl)			;9372
	ret			;9373
L_9374:
	ld de,00168h		;9374
	ex de,hl			;9377
	sbc hl,de		;9378
	ld a,l			;937a
	add a,a			;937b
	ld hl,094e8h		;937c
	call L_806E		;937f
	ld a,(hl)			;9382
	inc hl			;9383
	ld b,(hl)			;9384
	ret			;9385
L_9386:
	call L_8F4A		;9386
	ld a,000h		;9389
	jr nc,L_9392		;938b
	ld a,001h		;938d
	ld (0e041h),a		;938f
L_9392:
	ld hl,0959eh		;9392
	dec a			;9395
	add a,a			;9396
	call L_806E		;9397
	ld d,(hl)			;939a
	inc hl			;939b
	ld e,(hl)			;939c
	dec a			;939d
	ld b,a			;939e
	call L_8073		;939f
	ld (0e042h),de		;93a2
	ret			;93a6
L_93A7:
	ld a,(hl)			;93a7
	sub e			;93a8
	ld (hl),a			;93a9
	inc hl			;93aa
	ld a,(hl)			;93ab
	sbc a,d			;93ac
	ld (hl),a			;93ad
	jr nc,L_93B7		;93ae
	inc hl			;93b0
	ld a,(hl)			;93b1
	dec a			;93b2
	jr nc,L_93B7		;93b3
	inc hl			;93b5
	dec (hl)			;93b6
L_93B7:
	ret			;93b7
L_93B8:
	ex de,hl			;93b8
	ld a,(de)			;93b9
	ld b,(hl)			;93ba
	sub b			;93bb
	ld (de),a			;93bc
	inc hl			;93bd
	inc de			;93be
	ld a,(de)			;93bf
	ld b,(hl)			;93c0
	sbc a,b			;93c1
	ld (de),a			;93c2
	inc hl			;93c3
	inc de			;93c4
	ld a,(de)			;93c5
	ld b,(hl)			;93c6
	sbc a,b			;93c7
	ld (de),a			;93c8
	inc hl			;93c9
	inc de			;93ca
	ld a,(de)			;93cb
	ld b,(hl)			;93cc
	sbc a,b			;93cd
	ld (de),a			;93ce
	ret			;93cf
L_93D0:
	ld b,004h		;93d0
	or a			;93d2
L_93D3:
	ld a,(de)			;93d3
	inc de			;93d4
	adc a,(hl)			;93d5
	ld (hl),a			;93d6
	inc hl			;93d7
	djnz L_93D3		;93d8
	ret			;93da
L_93DB:
	ld hl,00000h		;93db
L_93DE:
	ld a,c			;93de
	or b			;93df
	jr z,L_93EF		;93e0
	srl b		;93e2
	rr c		;93e4
	jr nc,L_93E9		;93e6
	add hl,de			;93e8
L_93E9:
	sla e		;93e9
	rl d		;93eb
	jr L_93DE		;93ed
L_93EF:
	ret			;93ef
L_93F0:
	xor a			;93f0
	ld a,(hl)			;93f1
	add a,e			;93f2
	ld (hl),a			;93f3
	inc hl			;93f4
	ld a,(hl)			;93f5
	adc a,d			;93f6
	ld (hl),a			;93f7
	jr nc,L_9404		;93f8
	inc hl			;93fa
	ld a,(hl)			;93fb
	inc a			;93fc
	ld (hl),a			;93fd
	jr nc,L_9404		;93fe
	inc hl			;9400
	ld a,(hl)			;9401
	inc a			;9402
	ld (hl),a			;9403
L_9404:
	ret			;9404
L_9405:
	push ix		;9405
	push af			;9407
	push bc			;9408
	push de			;9409
	pop ix		;940a
	push hl			;940c
	pop bc			;940d
	ld hl,00000h		;940e
	ld de,00000h		;9411
	ld a,010h		;9414
L_9416:
	sla e		;9416
	rl d		;9418
	rl l		;941a
	rl h		;941c
	add ix,ix		;941e
	jr nc,L_9428		;9420
	ex de,hl			;9422
	add hl,bc			;9423
	ex de,hl			;9424
	jr nc,L_9428		;9425
	inc hl			;9427
L_9428:
	dec a			;9428
	jr nz,L_9416		;9429
	pop bc			;942b
	pop af			;942c
	pop ix		;942d
	ret			;942f
L_9430:
	ld hl,00000h		;9430
	exx			;9433
	ld b,010h		;9434
L_9436:
	exx			;9436
	sla e		;9437
	rl d		;9439
	adc hl,hl		;943b
	sbc hl,bc		;943d
	jr c,L_9444		;943f
	inc e			;9441
	jr L_9445		;9442
L_9444:
	add hl,bc			;9444
L_9445:
	exx			;9445
	djnz L_9436		;9446
	exx			;9448
	ret			;9449
L_944A:
	push hl			;944a
	ld hl,00000h		;944b
	exx			;944e
	ld b,010h		;944f
L_9451:
	exx			;9451
	sla e		;9452
	rl d		;9454
	adc hl,hl		;9456
	sbc hl,bc		;9458
	jr c,L_945F		;945a
	inc e			;945c
	jr L_9460		;945d
L_945F:
	add hl,bc			;945f
L_9460:
	exx			;9460
	djnz L_9451		;9461
	exx			;9463
	ld (0e088h),de		;9464
	pop de			;9468
	exx			;9469
	ld b,010h		;946a
L_946C:
	exx			;946c
	sla e		;946d
	rl d		;946f
	adc hl,hl		;9471
	sbc hl,bc		;9473
	jr c,L_947A		;9475
	inc e			;9477
	jr L_947B		;9478
L_947A:
	add hl,bc			;947a
L_947B:
	exx			;947b
	djnz L_946C		;947c
	exx			;947e
	ld (0e08ch),de		;947f
	ret			;9483
L_9484:
	call L_94AE		;9484
	push af			;9487
	ld l,c			;9488
	ld h,b			;9489
	call L_94A2		;948a
	ld c,l			;948d
	ld b,h			;948e
	ex de,hl			;948f
	call L_94A2		;9490
	ex de,hl			;9493
	call L_9430		;9494
	pop af			;9497
	jr c,L_94A1		;9498
	ld a,d			;949a
	cpl			;949b
	ld d,a			;949c
	ld a,e			;949d
	cpl			;949e
	ld e,a			;949f
	inc de			;94a0
L_94A1:
	ret			;94a1
L_94A2:
	ld a,h			;94a2
	or a			;94a3
	jp p,L_94AD		;94a4
	cpl			;94a7
	ld h,a			;94a8
	ld l,a			;94a9
	cpl			;94aa
	ld l,a			;94ab
	inc hl			;94ac
L_94AD:
	ret			;94ad
L_94AE:
	ld a,b			;94ae
	or a			;94af
	jp m,L_94BA		;94b0
	ld a,d			;94b3
	or a			;94b4
	jp p,L_94BF		;94b5
	jr L_94C0		;94b8
L_94BA:
	ld a,d			;94ba
	or a			;94bb
	jp p,L_94C0		;94bc
L_94BF:
	scf			;94bf
L_94C0:
	ret			;94c0
L_94C1:
	ld b,008h		;94c1
	ld h,000h		;94c3
L_94C5:
	add hl,hl			;94c5
	ld a,h			;94c6
	sub c			;94c7
	jr c,L_94CC		;94c8
	inc l			;94ca
	ld h,a			;94cb
L_94CC:
	djnz L_94C5		;94cc
	ret			;94ce
L_94CF:
	push de			;94cf
	ex de,hl			;94d0
	ld bc,00004h		;94d1
	call L_9430		;94d4
	ex de,hl			;94d7
	pop de			;94d8
	ret			;94d9
L_94DA:
	ex de,hl			;94da
	ld bc,00010h		;94db
	call L_9430		;94de
	ret			;94e1
L_94E2:
	add a,a			;94e2
	ld b,a			;94e3
	add a,a			;94e4
	add a,a			;94e5
	add a,b			;94e6
	ret			;94e7

; ----------------------------------------------------------------------
; DATOS resto_94E8: lo apuntan con el banco puesto p05:9343 (0x94E8), p05:9357
;   (0x94E8), p05:936A (0x94E8), p05:937C (0x94E8), p05:8F25 (0x959E),
;   p05:9392 (0x959E); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9343, p05:9357, p05:936A, p05:937C, p05:8F25,
;   p05:9392 (207 bytes)
;   0x94e8..0x95b7  (207 bytes)
DATA_resto_94E8:
	defb 000h,001h,000h,001h,001h,001h,002h,001h,002h,001h,003h,001h,004h,001h,004h,001h	; 94e8  ................
	defb 005h,001h,006h,001h,006h,001h,007h,001h,008h,001h,008h,001h,009h,001h,00ah,001h	; 94f8  ................
	defb 00bh,001h,00bh,001h,00ch,001h,00dh,001h,00dh,001h,00eh,001h,00eh,001h,00fh,001h	; 9508  ................
	defb 010h,001h,010h,001h,011h,001h,012h,001h,012h,001h,013h,001h,014h,001h,014h,001h	; 9518  ................
	defb 015h,001h,015h,001h,016h,001h,016h,001h,017h,001h,018h,001h,018h,001h,019h,001h	; 9528  ................
	defb 019h,001h,01ah,002h,01ah,002h,01bh,002h,01bh,002h,01ch,002h,01ch,002h,01dh,002h	; 9538  ................
	defb 01dh,002h,01eh,002h,01eh,002h,01fh,002h,01fh,002h,01fh,002h,020h,002h,020h,002h	; 9548  ............ . .
	defb 021h,002h,021h,002h,021h,002h,022h,002h,022h,002h,022h,002h,023h,002h,023h,002h	; 9558  !.!.!.".".".#.#.
	defb 023h,002h,024h,002h,024h,002h,024h,002h,025h,002h,025h,002h,025h,002h,025h,002h	; 9568  #.$.$.$.%.%.%.%.
	defb 026h,002h,026h,002h,026h,002h,026h,002h,026h,002h,026h,002h,027h,002h,027h,002h	; 9578  &.&.&.&.&.&.'.'.
	defb 027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h	; 9588  '.'.'.'.'.'.'.'.
	defb 027h,002h,027h,002h,028h,002h,000h,000h,000h,01fh,000h,03bh,000h,05ah,000h,078h	; 9598  '.'.(........Z.x
	defb 000h,097h,000h,0b5h,000h,0d4h,000h,0f3h,001h,011h,001h,030h,001h,04eh,0c9h	; 95a8  ...........0.N.

; ======================================================================
; CODIGO 0x95b7..0x95bd  (6 bytes)
; ======================================================================


L_95B7:
	ld a,(0e005h)		;95b7
	call L_8078		;95ba

; ----------------------------------------------------------------------
; DATOS saltos_95BD: tabla de 8 palabras del despachador (call 0x408D en
;   0x95BA); lo leen el despachador (16 bytes)
;   0x95bd..0x95cd  (16 bytes)
DATA_saltos_95BD:
	defb 0ebh,095h	; 95bd
	defb 0f9h,095h	; 95bf
	defb 0cdh,095h	; 95c1
	defb 005h,096h	; 95c3
	defb 0ffh,095h	; 95c5
	defb 0dch,095h	; 95c7
	defb 005h,096h	; 95c9
	defb 00bh,096h	; 95cb

; ======================================================================
; CODIGO 0x95cd..0x9680  (179 bytes)
; ======================================================================


L_95CD:
	call L_9617		;95cd
	call L_9674		;95d0
	jp c,L_97E4		;95d3
	call L_977E		;95d6
	jp L_9915		;95d9
L_95DC:
	call L_961E		;95dc
	call L_9674		;95df
	jp c,L_97E4		;95e2
	call L_977E		;95e5
	jp L_9915		;95e8
L_95EB:
	ld b,010h		;95eb
	ld hl,0e090h		;95ed
L_95F0:
	ld a,0f4h		;95f0
	ld (hl),a			;95f2
	inc hl			;95f3
	djnz L_95F0		;95f4
	jp L_9905		;95f6
L_95F9:
	call L_9DDA		;95f9
	jp L_9905		;95fc
L_95FF:
	call L_97BD		;95ff
	jp L_9905		;9602
L_9605:
	call L_9E37		;9605
	jp L_9905		;9608
L_960B:
	call L_9794		;960b
	scf			;960e
	ret			;960f
L_9610:
	call L_8D07		;9610
	call L_9628		;9613
	ret			;9616
L_9617:
	ld a,(0e07ah)		;9617
	cp 008h		;961a
	jr z,L_9624		;961c
L_961E:
	ld a,(0e07ah)		;961e
	cp 010h		;9621
	ret nz			;9623
L_9624:
	call L_9E30		;9624
	ret			;9627
L_9628:
	ld de,0e090h		;9628
	ld hl,0e34fh		;962b
	ld b,004h		;962e
	call L_966B		;9630
	ld de,0e094h		;9633
	ld hl,0e356h		;9636
	ld b,002h		;9639
	call L_966B		;963b
	ld de,0e096h		;963e
	ld hl,0e35bh		;9641
	ld b,002h		;9644
	call L_966B		;9646
	ld de,0e098h		;9649
	ld hl,0e3afh		;964c
	ld b,004h		;964f
	call L_966B		;9651
	ld de,0e09ch		;9654
	ld hl,0e3b6h		;9657
	ld b,002h		;965a
	call L_966B		;965c
	ld de,0e09eh		;965f
	ld hl,0e3bbh		;9662
	ld b,002h		;9665
	call L_966B		;9667
	ret			;966a
L_966B:
	ld a,(de)			;966b
	add a,010h		;966c
	ld (hl),a			;966e
	inc hl			;966f
	inc de			;9670
	djnz L_966B		;9671
	ret			;9673
L_9674:
	call L_968A		;9674
	call L_99AC		;9677
	jr c,L_9674		;967a
	ld a,b			;967c
	call L_8078		;967d

; ----------------------------------------------------------------------
; DATOS saltos_9680: tabla de 5 palabras del despachador (call 0x408D en
;   0x967D); lo leen el despachador (10 bytes)
;   0x9680..0x968a  (10 bytes)
DATA_saltos_9680:
	defb 01bh,09ah	; 9680
	defb 0eah,099h	; 9682
	defb 0f8h,099h	; 9684
	defb 00ah,09ah	; 9686
	defb 0e5h,099h	; 9688

; ======================================================================
; CODIGO 0x968a..0x96d2  (72 bytes)
; ======================================================================


L_968A:
	call L_9610		;968a
	call L_99D7		;968d
	call L_96AD		;9690
	call 0009ch		;9693   ; BIOS CHSNS - Tests the status of the keyboard buffer
	jr z,L_968A		;9696
	call 0009fh		;9698   ; BIOS CHGET - One character input (waiting)
	ld (0e058h),a		;969b
	ret			;969e
L_969F:
	ld a,0f4h		;969f
	ld b,004h		;96a1
L_96A3:
	ld (hl),a			;96a3
	inc hl			;96a4
	djnz L_96A3		;96a5
	ret			;96a7
L_96A8:
	inc hl			;96a8
	ld a,0f4h		;96a9
	ld (hl),a			;96ab
	ret			;96ac
L_96AD:
	call L_9AC3		;96ad
	jr z,L_96D1		;96b0
	ld hl,0e07ah		;96b2
	ld a,(hl)			;96b5
	ld c,a			;96b6
	add a,a			;96b7
	ld hl,096d2h		;96b8
	call L_806E		;96bb
	ld e,(hl)			;96be
	inc hl			;96bf
	ld d,(hl)			;96c0
	ld b,004h		;96c1
	call L_96F2		;96c3
	ld a,(0e00dh)		;96c6
	bit 2,a		;96c9
	jr nz,L_96CF		;96cb
	ld b,00fh		;96cd
L_96CF:
	ld a,b			;96cf
	ld (de),a			;96d0
L_96D1:
	ret			;96d1

; ----------------------------------------------------------------------
; DATOS resto_96D2: lo apuntan con el banco puesto p05:96B8 (0x96D2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:96B8 (32 bytes)
;   0x96d2..0x96f2  (32 bytes)
DATA_resto_96D2:
	defb 04fh,0e3h,050h,0e3h,051h,0e3h,052h,0e3h,056h,0e3h,057h,0e3h,05bh,0e3h,05ch,0e3h	; 96d2  O.P.Q.R.V.W.[.\.
	defb 0afh,0e3h,0b0h,0e3h,0b1h,0e3h,0b2h,0e3h,0b6h,0e3h,0b7h,0e3h,0bbh,0e3h,0bch,0e3h	; 96e2  ................

; ======================================================================
; CODIGO 0x96f2..0x9707  (21 bytes)
; ======================================================================


L_96F2:
	ld hl,0e090h		;96f2
	ld a,(0e07ah)		;96f5
	call L_806E		;96f8
	ld b,(hl)			;96fb
	ld a,b			;96fc
	add a,010h		;96fd
	ld b,a			;96ff
	ret			;9700
L_9701:
	ld a,(0e005h)		;9701
	call L_8078		;9704

; ----------------------------------------------------------------------
; DATOS saltos_9707: tabla de 8 palabras del despachador (call 0x408D en
;   0x9704); lo leen el despachador (16 bytes)
;   0x9707..0x9717  (16 bytes)
DATA_saltos_9707:
	defb 017h,097h	; 9707
	defb 04dh,097h	; 9709
	defb 029h,097h	; 970b
	defb 05fh,097h	; 970d
	defb 053h,097h	; 970f
	defb 03bh,097h	; 9711
	defb 05fh,097h	; 9713
	defb 065h,097h	; 9715

; ======================================================================
; CODIGO 0x9717..0x9785  (110 bytes)
; ======================================================================


L_9717:
	ld b,010h		;9717
	ld hl,0e090h		;9719
L_971C:
	ld a,0d4h		;971c
	ld (hl),a			;971e
	inc hl			;971f
	djnz L_971C		;9720
	xor a			;9722
	ld (0e004h),a		;9723
	jp L_9905		;9726
L_9729:
	call L_976D		;9729
	call L_9ACC		;972c
	call L_9984		;972f
	jp c,L_97E4		;9732
	call L_977E		;9735
	jp L_9915		;9738
L_973B:
	call L_9774		;973b
	call L_9AE0		;973e
	call L_9984		;9741
	jp c,L_97E4		;9744
	call L_977E		;9747
	jp L_9915		;974a
L_974D:
	call L_9FE8		;974d
	jp L_9905		;9750
L_9753:
	call L_9ACC		;9753
	call 0a092h		;9756
	call L_97BD		;9759
	jp L_9905		;975c
L_975F:
	call 0a270h		;975f
	jp L_9905		;9762
L_9765:
	call L_9AE0		;9765
	call L_9794		;9768
	scf			;976b
	ret			;976c
L_976D:
	ld a,(0e07ah)		;976d
	cp 008h		;9770
	jr z,L_977A		;9772
L_9774:
	ld a,(0e07ah)		;9774
	cp 010h		;9777
	ret nz			;9779
L_977A:
	call 0a23bh		;977a
	ret			;977d
L_977E:
	call L_97C6		;977e
	ld a,b			;9781
	call L_8078		;9782

; ----------------------------------------------------------------------
; DATOS saltos_9785: tabla de 7 palabras del despachador (call 0x408D en
;   0x9782); lo leen el despachador (14 bytes)
;   0x9785..0x9793  (14 bytes)
DATA_saltos_9785:
	defb 00ch,098h	; 9785
	defb 02ch,098h	; 9787
	defb 04ah,098h	; 9789
	defb 01ch,098h	; 978b
	defb 03bh,098h	; 978d
	defb 059h,098h	; 978f
	defb 093h,097h	; 9791

; ======================================================================
; CODIGO 0x9793..0x9978  (485 bytes)
; ======================================================================


L_9793:
	ret			;9793
L_9794:
	ld b,004h		;9794
	ld de,0e098h		;9796
	ld hl,0e062h		;9799
	call L_97B6		;979c
	ld b,002h		;979f
	ld de,0e09ch		;97a1
	ld hl,0e066h		;97a4
	call L_97B6		;97a7
	ld b,002h		;97aa
	ld de,0e09eh		;97ac
	ld hl,0e068h		;97af
	call L_97B6		;97b2
	ret			;97b5
L_97B6:
	ld a,(de)			;97b6
	ld (hl),a			;97b7
	inc hl			;97b8
	inc de			;97b9
	djnz L_97B6		;97ba
	ret			;97bc
L_97BD:
	ld a,008h		;97bd
	ld (0e078h),a		;97bf
	ld (0e07ah),a		;97c2
	ret			;97c5
L_97C6:
	ld b,000h		;97c6
	ld a,(0e07ah)		;97c8
	cp 004h		;97cb
	ret z			;97cd
	inc b			;97ce
	cp 006h		;97cf
	ret z			;97d1
	inc b			;97d2
	cp 008h		;97d3
	ret z			;97d5
	inc b			;97d6
	cp 00ch		;97d7
	ret z			;97d9
	inc b			;97da
	cp 00eh		;97db
	ret z			;97dd
	inc b			;97de
	cp 010h		;97df
	ret z			;97e1
	inc b			;97e2
	ret			;97e3
L_97E4:
	call L_97ED		;97e4
	jp c,L_9915		;97e7
	jp L_9905		;97ea
L_97ED:
	ld a,(0e005h)		;97ed
	cp 002h		;97f0
	jr nz,L_9800		;97f2
	call L_980C		;97f4
	ret c			;97f7
	call L_982C		;97f8
	ret c			;97fb
	call L_984A		;97fc
	ret			;97ff
L_9800:
	call L_981C		;9800
	ret c			;9803
	call L_983B		;9804
	ret c			;9807
	call L_9859		;9808
	ret			;980b
L_980C:
	ld a,000h		;980c
	ld (0e07bh),a		;980e
	ld ix,0e090h		;9811
	ld hl,0e010h		;9815
	call L_9868		;9818
	ret			;981b
L_981C:
	ld a,008h		;981c
	ld (0e07bh),a		;981e
	ld ix,0e098h		;9821
	ld hl,0e012h		;9825
	call L_9868		;9828
	ret			;982b
L_982C:
	ld a,004h		;982c
	ld (0e07bh),a		;982e
	ld hl,0e094h		;9831
	ld de,0e014h		;9834
	call L_9879		;9837
	ret			;983a
L_983B:
	ld a,00ch		;983b
	ld (0e07bh),a		;983d
	ld hl,0e09ch		;9840
	ld de,0e015h		;9843
	call L_9879		;9846
	ret			;9849
L_984A:
	ld a,006h		;984a
	ld (0e07bh),a		;984c
	ld hl,0e096h		;984f
	ld de,0e016h		;9852
	call L_9884		;9855
	ret			;9858
L_9859:
	ld a,00eh		;9859
	ld (0e07bh),a		;985b
	ld hl,0e09eh		;985e
	ld de,0e017h		;9861
	call L_9884		;9864
	ret			;9867
L_9868:
	push hl			;9868
	call L_993B		;9869
	pop hl			;986c
	ld de,(0e088h)		;986d
	ld (hl),e			;9871
	inc hl			;9872
	ld (hl),d			;9873
	dec hl			;9874
	call L_988C		;9875
	ret			;9878
L_9879:
	call L_996F		;9879
	ld (de),a			;987c
	ld (0e04eh),a		;987d
	call L_98A6		;9880
	ret			;9883
L_9884:
	call L_996F		;9884
	ld (de),a			;9887
	call L_98B1		;9888
	ret			;988b
L_988C:
	call L_8F4A		;988c
	xor a			;988f
	ld a,(0e005h)		;9890
	cp 002h		;9893
	jr z,L_989A		;9895
	call L_989B		;9897
L_989A:
	ret			;989a
L_989B:
	ld de,(0e010h)		;989b
	ld hl,(0e012h)		;989f
	rst 20h			;98a2
	jr c,L_98DD		;98a3
	ret			;98a5
L_98A6:
	cp 001h		;98a6
	jr c,L_98AF		;98a8
	ld b,a			;98aa
	ld a,00ch		;98ab
	cp b			;98ad
	ret nc			;98ae
L_98AF:
	jr L_98E5		;98af
L_98B1:
	cp 001h		;98b1
	jr c,L_98D9		;98b3
	ld b,a			;98b5
	ld hl,09978h		;98b6
	ld a,(0e04eh)		;98b9
	cp 002h		;98bc
	jr z,L_98C8		;98be
	dec a			;98c0
	ld c,a			;98c1
	call L_806E		;98c2
	ld a,(hl)			;98c5
	cp b			;98c6
	ret nc			;98c7
L_98C8:
	ld a,(0e041h)		;98c8
	and a			;98cb
	jr z,L_98D5		;98cc
	ld a,01dh		;98ce
	cp b			;98d0
	jr c,L_98D9		;98d1
	xor a			;98d3
	ret			;98d4
L_98D5:
	ld a,01ch		;98d5
	cp b			;98d7
	ret nc			;98d8
L_98D9:
	call L_98ED		;98d9
	ret			;98dc
L_98DD:
	ld a,(0e07bh)		;98dd
	ld hl,0e07ah		;98e0
	ld (hl),a			;98e3
	ret			;98e4
L_98E5:
	ld a,(0e07bh)		;98e5
	ld hl,0e07ah		;98e8
	ld (hl),a			;98eb
	ret			;98ec
L_98ED:
	ld a,(0e07bh)		;98ed
	ld hl,0e07ah		;98f0
	ld (hl),a			;98f3
	ret			;98f4
L_98F5:
	and a			;98f5
	ret z			;98f6
	inc d			;98f7
	srl a		;98f8
	jr nc,L_98F5		;98fa
	ret			;98fc
L_98FD:
	ret			;98fd
L_98FE:
	ld a,(hl)			;98fe
	call L_94E2		;98ff
	inc hl			;9902
	add a,(hl)			;9903
	ret			;9904
L_9905:
	call L_9924		;9905
	ld hl,0e005h		;9908
	inc (hl)			;990b
	ret			;990c
L_990D:
	call L_992B		;990d
	ld hl,0e006h		;9910
	inc (hl)			;9913
	ret			;9914
L_9915:
	call L_992B		;9915
	xor a			;9918
	ret			;9919
L_991A:
	call L_9924		;991a
	ld hl,0e005h		;991d
	ld a,001h		;9920
	ld (hl),a			;9922
	ret			;9923
L_9924:
	xor a			;9924
	ld (0e006h),a		;9925
	ld (0e004h),a		;9928
L_992B:
	ret			;992b
L_992C:
	ld a,b			;992c
	ld b,000h		;992d
	ld de,0e062h		;992f
	call L_8073		;9932
	ld hl,0e084h		;9935
	ldir		;9938
	ret			;993a
L_993B:
	ld a,(ix+000h)		;993b
	ld b,000h		;993e
	ld c,a			;9940
	ld de,003e8h		;9941
	call L_93DB		;9944
	push hl			;9947
	ld a,(ix+001h)		;9948
	ld b,000h		;994b
	ld c,a			;994d
	ld de,00064h		;994e
	call L_93DB		;9951
	pop de			;9954
	add hl,de			;9955
	push hl			;9956
	ld a,(ix+002h)		;9957
	ld b,000h		;995a
	ld c,a			;995c
	ld de,0000ah		;995d
	call L_93DB		;9960
	pop de			;9963
	add hl,de			;9964
	ld a,(ix+003h)		;9965
	call L_806E		;9968
	ld (0e088h),hl		;996b
	ret			;996e
L_996F:
	push de			;996f
	ld a,(hl)			;9970
	call L_94E2		;9971
	inc hl			;9974
	add a,(hl)			;9975
	pop de			;9976
	ret			;9977

; ----------------------------------------------------------------------
; DATOS resto_9978: lo apuntan con el banco puesto p05:98B6 (0x9978); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:98B6 (12 bytes)
;   0x9978..0x9984  (12 bytes)
DATA_resto_9978:
	defb 01fh,01dh,01fh,01eh,01fh,01eh,01fh,01fh,01eh,01fh,01eh,01fh	; 9978  ............

; ======================================================================
; CODIGO 0x9984..0x9990  (12 bytes)
; ======================================================================


L_9984:
	call L_999A		;9984
	call L_99AC		;9987
	jr c,L_9984		;998a
	ld a,b			;998c
	call L_8078		;998d

; ----------------------------------------------------------------------
; DATOS saltos_9990: tabla de 5 palabras del despachador (call 0x408D en
;   0x998D); lo leen el despachador (10 bytes)
;   0x9990..0x999a  (10 bytes)
DATA_saltos_9990:
	defb 01bh,09ah	; 9990
	defb 0eah,099h	; 9992
	defb 0f8h,099h	; 9994
	defb 00ah,09ah	; 9996
	defb 0e5h,099h	; 9998

; ======================================================================
; CODIGO 0x999a..0x9aa3  (265 bytes)
; ======================================================================


L_999A:
	call L_99D7		;999a
	call L_9A6F		;999d
	call 0009ch		;99a0   ; BIOS CHSNS - Tests the status of the keyboard buffer
	jr z,L_999A		;99a3
	call 0009fh		;99a5   ; BIOS CHGET - One character input (waiting)
	ld (0e058h),a		;99a8
	ret			;99ab
L_99AC:
	ld b,000h		;99ac
	cp 008h		;99ae
	jp z,L_99CA		;99b0
	inc b			;99b3
	cp 01ch		;99b4
	jp z,L_99CA		;99b6
	inc b			;99b9
	cp 01dh		;99ba
	jp z,L_99CA		;99bc
	inc b			;99bf
	cp 00dh		;99c0
	jp z,L_99CA		;99c2
	inc b			;99c5
	call L_99CC		;99c6
	ret c			;99c9
L_99CA:
	ld a,b			;99ca
	ret			;99cb
L_99CC:
	cp 040h		;99cc
	jr nc,L_99D5		;99ce
	cp 030h		;99d0
	jr c,L_99D5		;99d2
	ret			;99d4
L_99D5:
	scf			;99d5
	ret			;99d6
L_99D7:
	ld hl,0e007h		;99d7
	ld a,(hl)			;99da
	inc a			;99db
	ld (hl),a			;99dc
	and 00fh		;99dd
	ret nz			;99df
	ld hl,0e00dh		;99e0
	inc (hl)			;99e3
	ret			;99e4
L_99E5:
	call L_9A1D		;99e5
	jr L_9A18		;99e8
L_99EA:
	ld a,(0e078h)		;99ea
	ld b,a			;99ed
	ld hl,0e07ah		;99ee
	ld a,(hl)			;99f1
	cp b			;99f2
	jr z,L_99F6		;99f3
	inc (hl)			;99f5
L_99F6:
	jr L_9A18		;99f6
L_99F8:
	call L_9A51		;99f8
	ld a,b			;99fb
	ld hl,0e07ah		;99fc
	ld b,(hl)			;99ff
	cp b			;9a00
	jr z,L_9A08		;9a01
	jr nc,L_9A08		;9a03
	ld a,(hl)			;9a05
	dec a			;9a06
	ld (hl),a			;9a07
L_9A08:
	jr L_9A18		;9a08
L_9A0A:
	call L_9A5D		;9a0a
	ld a,(0e078h)		;9a0d
	cp b			;9a10
	jr z,L_9A16		;9a11
	jp L_9A18		;9a13
L_9A16:
	scf			;9a16
	ret			;9a17
L_9A18:
	scf			;9a18
	ccf			;9a19
	ret			;9a1a
L_9A1B:
	jr L_9A18		;9a1b
L_9A1D:
	call L_9A69		;9a1d
	jr nc,L_9A28		;9a20
	ld a,(0e07ah)		;9a22
	cp 008h		;9a25
	ret z			;9a27
L_9A28:
	ld a,(0e07ah)		;9a28
	ld hl,0e090h		;9a2b
	call L_806E		;9a2e
	ld a,(0e058h)		;9a31
	sub 030h		;9a34
	ld (hl),a			;9a36
	call L_9A3B		;9a37
	ret			;9a3a
L_9A3B:
	ld hl,0e078h		;9a3b
	ld b,(hl)			;9a3e
	ld a,(0e07ah)		;9a3f
	cp b			;9a42
	jr c,L_9A4C		;9a43
	call L_9A5D		;9a45
	ld a,(hl)			;9a48
	cp b			;9a49
	ret nc			;9a4a
	inc (hl)			;9a4b
L_9A4C:
	ld hl,0e07ah		;9a4c
	inc (hl)			;9a4f
	ret			;9a50
L_9A51:
	ld b,000h		;9a51
	ld a,(0e005h)		;9a53
	cp 002h		;9a56
	jr z,L_9A5C		;9a58
	ld b,008h		;9a5a
L_9A5C:
	ret			;9a5c
L_9A5D:
	ld b,008h		;9a5d
	ld a,(0e005h)		;9a5f
	cp 002h		;9a62
	jr z,L_9A68		;9a64
	ld b,010h		;9a66
L_9A68:
	ret			;9a68
L_9A69:
	ld a,(0e005h)		;9a69
	cp 005h		;9a6c
	ret			;9a6e
L_9A6F:
	call L_9AC3		;9a6f
	jr z,L_9AA2		;9a72
	ld hl,0e07ah		;9a74
	ld a,(hl)			;9a77
	ld c,a			;9a78
	add a,a			;9a79
	ld hl,09aa3h		;9a7a
	call L_806E		;9a7d
	ld e,(hl)			;9a80
	inc hl			;9a81
	ld d,(hl)			;9a82
	ld a,c			;9a83
	call L_9B1D		;9a84
	ld c,a			;9a87
	ld a,(0e00dh)		;9a88
	bit 6,a		;9a8b
	jr nz,L_9A96		;9a8d
	ex de,hl			;9a8f
	ld c,0ffh		;9a90
	call L_9B34		;9a92
	ret			;9a95
L_9A96:
	and 01fh		;9a96
	ret nz			;9a98
	call L_9B25		;9a99
	ld a,c			;9a9c
	add a,030h		;9a9d
	call L_86FC		;9a9f
L_9AA2:
	ret			;9aa2

; ----------------------------------------------------------------------
; DATOS resto_9AA3: lo apuntan con el banco puesto p05:9A7A (0x9AA3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:9A7A (32 bytes)
;   0x9aa3..0x9ac3  (32 bytes)
DATA_resto_9AA3:
	defb 020h,030h,020h,038h,020h,040h,020h,048h,020h,068h,020h,070h,020h,090h,020h,098h	; 9aa3   0 8 @ H h p . .
	defb 038h,040h,038h,048h,038h,050h,038h,058h,038h,078h,038h,080h,038h,0a0h,038h,0a8h	; 9ab3  8@8H8P8X8x8.8.8.

; ======================================================================
; CODIGO 0x9ac3..0x9dc2  (767 bytes)
; ======================================================================


L_9AC3:
	call L_9A5D		;9ac3
	ld hl,0e07ah		;9ac6
	ld a,(hl)			;9ac9
	cp b			;9aca
	ret			;9acb
L_9ACC:
	xor a			;9acc
	ld de,03020h		;9acd
	call L_9AF5		;9ad0
	ld de,06820h		;9ad3
	call L_9AFB		;9ad6
	ld de,09020h		;9ad9
	call L_9B01		;9adc
	ret			;9adf
L_9AE0:
	ld a,008h		;9ae0
	ld de,04038h		;9ae2
	call L_9AF5		;9ae5
	ld de,07838h		;9ae8
	call L_9AFB		;9aeb
	ld de,0a038h		;9aee
	call L_9B01		;9af1
	ret			;9af4
L_9AF5:
	ld b,004h		;9af5
	call L_9B07		;9af7
	ret			;9afa
L_9AFB:
	ld b,002h		;9afb
	call L_9B07		;9afd
	ret			;9b00
L_9B01:
	ld b,002h		;9b01
	call L_9B07		;9b03
	ret			;9b06
L_9B07:
	push af			;9b07
	call L_9B25		;9b08
	call L_9B1D		;9b0b
	add a,030h		;9b0e
	call L_86FC		;9b10
	ld a,008h		;9b13
	add a,d			;9b15
	ld d,a			;9b16
	inc hl			;9b17
	pop af			;9b18
	inc a			;9b19
	djnz L_9B07		;9b1a
	ret			;9b1c
L_9B1D:
	ld hl,0e090h		;9b1d
	call L_806E		;9b20
	ld a,(hl)			;9b23
	ret			;9b24
L_9B25:
	push af			;9b25
	push bc			;9b26
	push hl			;9b27
	push de			;9b28
	ex de,hl			;9b29
	call L_9B32		;9b2a
	pop de			;9b2d
	pop hl			;9b2e
	pop bc			;9b2f
	pop af			;9b30
	ret			;9b31
L_9B32:
	ld c,055h		;9b32
L_9B34:
	ld d,000h		;9b34
	ld a,c			;9b36
	ld bc,00808h		;9b37
	call L_83C8		;9b3a
	ret			;9b3d
L_9B3E:
	call L_9B55		;9b3e
	ret c			;9b41
	call L_9B63		;9b42
	call L_9BDA		;9b45
	call L_9BF3		;9b48
	call L_9C0E		;9b4b
	call L_9C6D		;9b4e
	call 0a3a4h		;9b51
	ret			;9b54
L_9B55:
	and a			;9b55
	jr z,L_9B61		;9b56
	cp 080h		;9b58
	jr z,L_9B6C		;9b5a
	cp 010h		;9b5c
	jr z,L_9B9F		;9b5e
	ret			;9b60
L_9B61:
	scf			;9b61
	ret			;9b62
L_9B63:
	ld a,(0e281h)		;9b63
	cp 05ch		;9b66
	jp z,L_9CCB		;9b68
	ret			;9b6b
L_9B6C:
	ld a,(0e052h)		;9b6c
	cp 082h		;9b6f
	jr z,L_9B8B		;9b71
	inc a			;9b73
	ld (0e052h),a		;9b74
	call L_9C58		;9b77
	jr nc,L_9B7F		;9b7a
	call L_9B8D		;9b7c
L_9B7F:
	call L_9B94		;9b7f
	ld hl,0e281h		;9b82
	ld a,(hl)			;9b85
	inc a			;9b86
	call L_9BD0		;9b87
	ret			;9b8a
L_9B8B:
	scf			;9b8b
	ret			;9b8c
L_9B8D:
	ld hl,0e054h		;9b8d
	ld a,(hl)			;9b90
	inc a			;9b91
	ld (hl),a			;9b92
	ret			;9b93
L_9B94:
	ld hl,0e03fh		;9b94
	inc (hl)			;9b97
	call L_9265		;9b98
	call L_9179		;9b9b
	ret			;9b9e
L_9B9F:
	ld a,(0e052h)		;9b9f
	cp 0c4h		;9ba2
	jr z,L_9B8B		;9ba4
	dec a			;9ba6
	ld (0e052h),a		;9ba7
	call L_9C3F		;9baa
	jr nc,L_9BB2		;9bad
	call L_9BBE		;9baf
L_9BB2:
	call L_9BC5		;9bb2
	ld hl,0e281h		;9bb5
	ld a,(hl)			;9bb8
	dec a			;9bb9
	call L_9BD0		;9bba
	ret			;9bbd
L_9BBE:
	ld hl,0e054h		;9bbe
	ld a,(hl)			;9bc1
	dec a			;9bc2
	ld (hl),a			;9bc3
	ret			;9bc4
L_9BC5:
	ld hl,0e03fh		;9bc5
	dec (hl)			;9bc8
	call L_9287		;9bc9
	call L_91C4		;9bcc
	ret			;9bcf
L_9BD0:
	ld b,006h		;9bd0
L_9BD2:
	ld (hl),a			;9bd2
	ld de,00004h		;9bd3
	add hl,de			;9bd6
	djnz L_9BD2		;9bd7
	ret			;9bd9
L_9BDA:
	ld hl,0e04ch		;9bda
	ld a,(0e054h)		;9bdd
	bit 7,a		;9be0
	jr z,L_9BE6		;9be2
	neg		;9be4
L_9BE6:
	push hl			;9be6
	ld l,a			;9be7
	ld c,00ah		;9be8
	call L_94C1		;9bea
	ex de,hl			;9bed
	pop hl			;9bee
	ld (hl),d			;9bef
	inc hl			;9bf0
	ld (hl),e			;9bf1
	ret			;9bf2
L_9BF3:
	ld de,0e048h		;9bf3
	ld hl,0e04dh		;9bf6
	ld a,(hl)			;9bf9
	and a			;9bfa
	jr nz,L_9C06		;9bfb
	dec hl			;9bfd
	ld a,(hl)			;9bfe
	cp 001h		;9bff
	jr z,L_9C0A		;9c01
	and a			;9c03
	jr z,L_9C0A		;9c04
L_9C06:
	call 0a0d3h		;9c06
	ret			;9c09
L_9C0A:
	call L_9C30		;9c0a
	ret			;9c0d
L_9C0E:
	ld ix,0e04ch		;9c0e
	ld de,0b848h		;9c12
	call L_9C30		;9c15
	ld a,(ix+001h)		;9c18
	add a,030h		;9c1b
	call L_86FC		;9c1d
	ld a,008h		;9c20
	add a,d			;9c22
	ld d,a			;9c23
	call L_9C30		;9c24
	ld a,(ix+000h)		;9c27
	add a,030h		;9c2a
	call L_86FC		;9c2c
	ret			;9c2f
L_9C30:
	push de			;9c30
	ex de,hl			;9c31
	ld c,055h		;9c32
	ld d,000h		;9c34
	ld a,c			;9c36
	ld bc,00808h		;9c37
	call L_83C8		;9c3a
	pop de			;9c3d
	ret			;9c3e
L_9C3F:
	ld hl,0e06ah		;9c3f
	ld c,004h		;9c42
	call L_9C48		;9c44
	ret			;9c47
L_9C48:
	ld a,(hl)			;9c48
	dec a			;9c49
	ld b,a			;9c4a
	neg		;9c4b
	cp c			;9c4d
	jr z,L_9C54		;9c4e
	ld a,b			;9c50
	ld (hl),a			;9c51
	xor a			;9c52
	ret			;9c53
L_9C54:
	xor a			;9c54
	ld (hl),a			;9c55
	scf			;9c56
	ret			;9c57
L_9C58:
	ld hl,0e06ah		;9c58
	ld c,004h		;9c5b
	call L_9C61		;9c5d
	ret			;9c60
L_9C61:
	ld a,(hl)			;9c61
	inc a			;9c62
	cp c			;9c63
	jr z,L_9C69		;9c64
	ld (hl),a			;9c66
	xor a			;9c67
	ret			;9c68
L_9C69:
	xor a			;9c69
	ld (hl),a			;9c6a
	scf			;9c6b
	ret			;9c6c
L_9C6D:
	ld de,0b048h		;9c6d
	call L_9C30		;9c70
	ld a,(0e054h)		;9c73
	cp 020h		;9c76
	jr z,L_9C83		;9c78
	ld b,03ch		;9c7a
	ld a,(0e052h)		;9c7c
	sla a		;9c7f
	jr c,L_9C85		;9c81
L_9C83:
	ld b,03bh		;9c83
L_9C85:
	ld a,b			;9c85
	call L_86FC		;9c86
	ret			;9c89
L_9C8A:
	call L_9C94		;9c8a
	call L_9C9E		;9c8d
	call L_9CA7		;9c90
	ret			;9c93
L_9C94:
	xor a			;9c94
	ld de,03820h		;9c95
	ld b,004h		;9c98
	call L_9CB0		;9c9a
	ret			;9c9d
L_9C9E:
	ld de,07020h		;9c9e
	ld b,002h		;9ca1
	call L_9CB0		;9ca3
	ret			;9ca6
L_9CA7:
	ld de,09820h		;9ca7
	ld b,002h		;9caa
	call L_9CB0		;9cac
	ret			;9caf
L_9CB0:
	push af			;9cb0
	call L_9CC3		;9cb1
	add a,030h		;9cb4
	call L_86FC		;9cb6
	ld a,008h		;9cb9
	add a,d			;9cbb
	ld d,a			;9cbc
	inc hl			;9cbd
	pop af			;9cbe
	inc a			;9cbf
	djnz L_9CB0		;9cc0
	ret			;9cc2
L_9CC3:
	ld hl,0e062h		;9cc3
	call L_806E		;9cc6
	ld a,(hl)			;9cc9
	ret			;9cca
L_9CCB:
	call L_9CDB		;9ccb
	call L_9CE7		;9cce
	call L_9D0F		;9cd1
	call L_92A9		;9cd4
	call L_9055		;9cd7
	ret			;9cda
L_9CDB:
	ld hl,0e033h		;9cdb
	ld de,0e02dh		;9cde
	ld bc,00006h		;9ce1
	ldir		;9ce4
	ret			;9ce6
L_9CE7:
	ld b,003h		;9ce7
	ld ix,0e02dh		;9ce9
	ld iy,09043h		;9ced
L_9CF1:
	ld l,(ix+000h)		;9cf1
	ld h,(ix+001h)		;9cf4
	ld e,(iy+000h)		;9cf7
	ld d,(iy+001h)		;9cfa
	xor a			;9cfd
	add hl,de			;9cfe
	ld (ix+000h),l		;9cff
	ld (ix+001h),h		;9d02
	ld de,00002h		;9d05
	add ix,de		;9d08
	add iy,de		;9d0a
	djnz L_9CF1		;9d0c
	ret			;9d0e
L_9D0F:
	ld hl,0003ch		;9d0f
	ld (0e03fh),hl		;9d12
	ret			;9d15
L_9D16:
	call L_9B55		;9d16
	ret c			;9d19
	call L_9B63		;9d1a
	call L_9D55		;9d1d
	ret			;9d20
L_9D21:
	call L_9D2B		;9d21
	call L_9D35		;9d24
	call L_9D3E		;9d27
	ret			;9d2a
L_9D2B:
	xor a			;9d2b
	ld de,0e34fh		;9d2c
	ld b,004h		;9d2f
	call L_9D47		;9d31
	ret			;9d34
L_9D35:
	ld de,0e356h		;9d35
	ld b,002h		;9d38
	call L_9D47		;9d3a
	ret			;9d3d
L_9D3E:
	ld de,0e35bh		;9d3e
	ld b,002h		;9d41
	call L_9D47		;9d43
	ret			;9d46
L_9D47:
	push af			;9d47
	call L_9CC3		;9d48
	add a,010h		;9d4b
	ld (de),a			;9d4d
	inc hl			;9d4e
	inc de			;9d4f
	pop af			;9d50
	inc a			;9d51
	djnz L_9D47		;9d52
	ret			;9d54
L_9D55:
	call L_9D89		;9d55
	call L_9D5C		;9d58
	ret			;9d5b
L_9D5C:
	ld a,(0e075h)		;9d5c
	call L_9D81		;9d5f
	ld de,0e36ah		;9d62
	call L_9DCC		;9d65
	ld a,(0e074h)		;9d68
	call L_9D81		;9d6b
	ld de,0e38ah		;9d6e
	call L_9DCC		;9d71
	ld a,(0e073h)		;9d74
	call L_9D81		;9d77
	ld de,0e3aah		;9d7a
	call L_9DCC		;9d7d
	ret			;9d80
L_9D81:
	ld hl,09dc2h		;9d81
	call 0a421h		;9d84
	ex de,hl			;9d87
	ret			;9d88
L_9D89:
	ld a,(0e05ah)		;9d89
	ld hl,0e075h		;9d8c
	call L_9DA5		;9d8f
	ld a,(0e05ch)		;9d92
	ld hl,0e074h		;9d95
	call L_9DA5		;9d98
	ld a,(0e05eh)		;9d9b
	ld hl,0e073h		;9d9e
	call L_9DA5		;9da1
	ret			;9da4
L_9DA5:
	ld b,000h		;9da5
	cp 0a0h		;9da7
	jr nc,L_9DC0		;9da9
	inc b			;9dab
	cp 090h		;9dac
	jr nc,L_9DC0		;9dae
	inc b			;9db0
	cp 080h		;9db1
	jr nc,L_9DC0		;9db3
	inc b			;9db5
	cp 070h		;9db6
	jr nc,L_9DC0		;9db8
	inc b			;9dba
	cp 000h		;9dbb
	jr L_9DC0		;9dbd
L_9DBF:
	ret			;9dbf
L_9DC0:
	ld (hl),b			;9dc0
	ret			;9dc1

; ----------------------------------------------------------------------
; DATOS resto_9DC2: lo apuntan con el banco puesto p05:9D81 (0x9DC2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:9D81 (10 bytes)
;   0x9dc2..0x9dcc  (10 bytes)
DATA_resto_9DC2:
	defb 054h,09fh,05ah,09fh,05eh,09fh,066h,09fh,06dh,09fh	; 9dc2  T.Z.^.f.m.

; ======================================================================
; CODIGO 0x9dcc..0x9e3e  (114 bytes)
; ======================================================================


L_9DCC:
	ex de,hl			;9dcc
	ld c,0ffh		;9dcd
	push de			;9dcf
	push hl			;9dd0
	call L_9F72		;9dd1
	pop hl			;9dd4
	pop de			;9dd5
	call L_80DC		;9dd6
	ret			;9dd9
L_9DDA:
	ld de,09e50h		;9dda
	call L_80D0		;9ddd
	ret			;9de0
L_9DE1:
	ld de,09edch		;9de1
	call L_80D0		;9de4
	call L_9F97		;9de7
	call L_9F7F		;9dea
	call L_8CDB		;9ded
	ret			;9df0
L_9DF1:
	ld de,09f0ah		;9df1
	call L_80D0		;9df4
	ld de,09f29h		;9df7
	call L_80D0		;9dfa
	ret			;9dfd
L_9DFE:
	ld ix,0e05ah		;9dfe
	ld h,(ix+000h)		;9e02
	ld d,(ix+002h)		;9e05
	ld b,(ix+004h)		;9e08
	ld l,01bh		;9e0b
	ld e,01ch		;9e0d
	ld c,01dh		;9e0f
	call 0a33dh		;9e11
	ld a,(0e070h)		;9e14
	ld hl,0e441h		;9e17
	ld (hl),a			;9e1a
	ld a,(0e071h)		;9e1b
	ld hl,0e461h		;9e1e
	ld (hl),a			;9e21
	ld a,(0e072h)		;9e22
	ld hl,0e481h		;9e25
	ld (hl),a			;9e28
	ld de,09ef9h		;9e29
	call L_80D0		;9e2c
	ret			;9e2f
L_9E30:
	ld de,09e3eh		;9e30
	call L_80D0		;9e33
	ret			;9e36
L_9E37:
	ld de,09e47h		;9e37
	call L_80D0		;9e3a
	ret			;9e3d

; ----------------------------------------------------------------------
; DATOS resto_9E3E: lo apuntan con el banco puesto p05:9E30 (0x9E3E), p05:9E37
;   (0x9E47), p05:9DDA (0x9E50), p05:9DE1 (0x9EDC), p05:9E29 (0x9EF9),
;   p05:9DF1 (0x9F0A); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9E30, p05:9E37, p05:9DDA, p05:9DE1, p05:9E29,
;   p05:9DF1 (308 bytes)
;   0x9e3e..0x9f72  (308 bytes)
DATA_resto_9E3E:
	defb 0f6h,0e3h,02fh,02bh,01fh,032h,025h,034h,080h,0f6h,0e3h,004h,004h,004h,004h,004h	; 9e3e  ../+.2%4........
	defb 004h,080h,022h,0e3h,0a0h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h	; 9e4e  ..".............
	defb 0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a3h	; 9e5e  ................
	defb 081h,042h,0e3h,0a2h,022h,029h,032h,034h,028h,024h,021h,039h,004h,004h,039h,004h	; 9e6e  .B..")24($!9..9.
	defb 004h,004h,004h,004h,004h,02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,081h	; 9e7e  .....-....$.....
	defb 062h,0e3h,0a2h,081h,07dh,0e3h,0a5h,081h,082h,0e3h,0a2h,081h,09dh,0e3h,0a5h,081h	; 9e8e  b...}...........
	defb 0a2h,0e3h,0a2h,023h,028h,025h,023h,02bh,004h,024h,021h,039h,004h,039h,004h,004h	; 9e9e  ...#(%#+.$!9.9..
	defb 004h,004h,004h,004h,02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,081h,0c2h	; 9eae  ....-....$......
	defb 0e3h,0a1h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h	; 9ebe  ................
	defb 0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a4h,080h,002h,0e4h	; 9ece  ................
	defb 01fh,011h,015h,004h,004h,004h,004h,004h,004h,010h,004h,004h,004h,004h,004h,004h	; 9ede  ................
	defb 01eh,011h,015h,004h,004h,004h,004h,01eh,013h,010h,080h,0efh,0e3h,030h,035h,033h	; 9eee  .............053
	defb 028h,004h,033h,030h,021h,023h,025h,004h,02bh,025h,039h,080h,042h,0e3h,0a2h,023h	; 9efe  (.30!#%.+%9.B..#
	defb 028h,025h,023h,02bh,004h,024h,021h,039h,004h,039h,004h,004h,004h,004h,004h,004h	; 9f0e  (%#+.$!9.9......
	defb 02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,080h,065h,0e3h,030h,028h,039h	; 9f1e  -....$.....e.0(9
	defb 01fh,081h,085h,0e3h,033h,025h,02eh,01fh,081h,0a3h,0e3h,004h,004h,029h,02eh,034h	; 9f2e  ....3%.......).4
	defb 01fh,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; 9f3e  ................
	defb 004h,004h,004h,004h,004h,080h,037h,02fh,032h,033h,034h,080h,022h,021h,024h,080h	; 9f4e  ......7/234."!$.
	defb 023h,021h,035h,034h,029h,02fh,02eh,080h,02eh,02fh,032h,02dh,021h,02ch,080h,027h	; 9f5e  #!54)/.../2-!,.'
	defb 02fh,02fh,024h,080h	; 9f6e

; ======================================================================
; CODIGO 0x9f72..0x9fff  (141 bytes)
; ======================================================================


L_9F72:
	ld b,005h		;9f72
	ld de,00003h		;9f74
	add hl,de			;9f77
	ld a,004h		;9f78
L_9F7A:
	ld (hl),a			;9f7a
	inc hl			;9f7b
	djnz L_9F7A		;9f7c
	ret			;9f7e
L_9F7F:
	ld b,00ch		;9f7f
	ld hl,00a18h		;9f81
L_9F84:
	push bc			;9f84
	ld bc,000d0h		;9f85
	ld a,0f0h		;9f88
	push hl			;9f8a
	call 00056h		;9f8b   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;9f8e
	pop bc			;9f8f
	ld de,00100h		;9f90
	add hl,de			;9f93
	djnz L_9F84		;9f94
	ret			;9f96
L_9F97:
	ld hl,00a18h		;9f97
	ld b,01ah		;9f9a
	ld a,0ffh		;9f9c
	call L_920C		;9f9e
	ld hl,01018h		;9fa1
	ld b,01ah		;9fa4
	ld a,0cch		;9fa6
	call L_920C		;9fa8
	ld hl,01618h		;9fab
	ld b,01ah		;9fae
	ld a,0ffh		;9fb0
	call L_920C		;9fb2
	ld hl,00919h		;9fb5
	ld b,01ah		;9fb8
	ld a,0ffh		;9fba
	call L_920C		;9fbc
	ld hl,01619h		;9fbf
	ld b,01ah		;9fc2
	ld a,0ffh		;9fc4
	call L_920C		;9fc6
	ld hl,00a18h		;9fc9
	ld b,00ch		;9fcc
	ld a,0c0h		;9fce
	call L_9220		;9fd0
	ld hl,00a58h		;9fd3
	ld b,00ch		;9fd6
	ld a,010h		;9fd8
	call L_9220		;9fda
	ld hl,00ae0h		;9fdd
	ld b,00ch		;9fe0
	ld a,003h		;9fe2
	call L_9220		;9fe4
	ret			;9fe7
L_9FE8:
	call 0a066h		;9fe8
	ret			;9feb
L_9FEC:
	call 0a006h		;9fec
	call 0a0dah		;9fef
	call L_8D97		;9ff2
	ret			;9ff5
L_9FF6:
	call 0a0f6h		;9ff6
	call 0a122h		;9ff9
	call 0a034h		;9ffc

; ----------------------------------------------------------------------
; DATOS partida_9FFF: los 1 primeros bytes de una instruccion de 3 (CD 57 A1)
;   que sigue en el banco 6: el trazador de un solo banco no puede verla
;   entera (tools/bancos.py); lo leen p05:9FFF (1 bytes)
;   0x9fff..0xa000  (1 bytes)
DATA_partida_9FFF:
	defb 0cdh	; 9fff
