; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 07 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x8094  (148 bytes)
; ======================================================================


L_8000:
	di			;8000
	jp L_803A		;8001
L_8004:
	call 0013eh		;8004   ; BIOS RDVDP - Reads VDP status register
	di			;8007
	call L_9CA5		;8008
	ld hl,0e404h		;800b
	bit 0,(hl)		;800e
	jr nz,L_801F		;8010
	inc (hl)			;8012
	ei			;8013
	call L_86E2		;8014
	call L_806E		;8017
	ld a,000h		;801a
	ld (0e404h),a		;801c
L_801F:
	call 0013eh		;801f   ; BIOS RDVDP - Reads VDP status register
	ei			;8022
	ret			;8023
L_8024:
	add a,l			;8024
	ld l,a			;8025
	ret nc			;8026
	inc h			;8027
	ret			;8028
L_8029:
	add a,e			;8029
	ld e,a			;802a
	ret nc			;802b
	inc d			;802c
	ret			;802d
L_802E:
	pop hl			;802e
	add a,a			;802f
	add a,l			;8030
	ld l,a			;8031
	jr nc,L_8035		;8032
	inc h			;8034
L_8035:
	ld e,(hl)			;8035
	inc hl			;8036
	ld d,(hl)			;8037
	ex de,hl			;8038
	jp (hl)			;8039
L_803A:
	ld a,0c3h		;803a
	ld (0fd9ah),a		;803c
	ld hl,L_8004		;803f
	ld (0fd9bh),hl		;8042
	ld hl,0e200h		;8045
	ld de,0e201h		;8048
	ld bc,006ffh		;804b
	ld (hl),000h		;804e
	ldir		;8050
	ld a,001h		;8052
	ld (0e404h),a		;8054
	call L_86B0		;8057
	xor a			;805a
	ld (0e404h),a		;805b
	call 0013eh		;805e   ; BIOS RDVDP - Reads VDP status register
	ei			;8061
L_8062:
	ld a,(0e40eh)		;8062
	and a			;8065
	jr z,L_8062		;8066
	ld a,0c9h		;8068
	ld (0fd9ah),a		;806a
	ret			;806d
L_806E:
	ld a,006h		;806e
	call 00141h		;8070   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;8073
	jr nz,L_8088		;8075
	ld a,003h		;8077
	call 00141h		;8079   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;807c
	jr c,L_8088		;807d
	ld hl,00100h		;807f
	ld (0e400h),hl		;8082
	jp L_80DB		;8085
L_8088:
	ld hl,0e402h		;8088
	inc (hl)			;808b
	ld bc,(0e400h)		;808c
	ld a,c			;8090
	call L_802E		;8091

; ----------------------------------------------------------------------
; DATOS saltos_8094: tabla de 8 palabras del despachador (call 0x408D en
;   0x8091); lo leen el despachador (16 bytes)
;   0x8094..0x80a4  (16 bytes)
DATA_saltos_8094:
	defb 0a4h,080h	; 8094
	defb 0f1h,080h	; 8096
	defb 033h,081h	; 8098
	defb 0c6h,081h	; 809a
	defb 0e4h,081h	; 809c
	defb 039h,082h	; 809e
	defb 039h,083h	; 80a0
	defb 067h,083h	; 80a2

; ======================================================================
; CODIGO 0x80a4..0x8139  (149 bytes)
; ======================================================================


L_80A4:
	dec b			;80a4
	jr z,L_80C3		;80a5
	dec b			;80a7
	jr z,L_80E3		;80a8
	ld a,00dh		;80aa
	call L_9B3C		;80ac
	call L_85D5		;80af
	call L_8823		;80b2
	call L_9082		;80b5
	call L_908B		;80b8
	call L_9094		;80bb
	call L_909A		;80be
	jr L_80EC		;80c1
L_80C3:
	call L_90A6		;80c3
	ld a,(0e405h)		;80c6
	and 010h		;80c9
	ret z			;80cb
	ld a,(0e412h)		;80cc
	cp 003h		;80cf
	jr z,L_80DB		;80d1
	ld a,004h		;80d3
	call L_9B3C		;80d5
	jp L_81BD		;80d8
L_80DB:
	ld a,001h		;80db
	call L_9B3C		;80dd
	jp L_80EC		;80e0
L_80E3:
	ld a,001h		;80e3
	ld (0e40eh),a		;80e5
	ret			;80e8
L_80E9:
	ld (0e403h),a		;80e9
L_80EC:
	ld hl,0e401h		;80ec
	inc (hl)			;80ef
	ret			;80f0
L_80F1:
	dec b			;80f1
	jr z,L_8103		;80f2
	dec b			;80f4
	jr z,L_811E		;80f5
	call L_85D5		;80f7
	xor a			;80fa
	ld (0e460h),a		;80fb
	call L_9100		;80fe
	jr L_80EC		;8101
L_8103:
	call L_9136		;8103
	ld a,(0e405h)		;8106
	and 010h		;8109
	ret z			;810b
	ld a,004h		;810c
	call L_9B3C		;810e
	call L_9230		;8111
	xor a			;8114
	ld (0e40ch),a		;8115
	ld (0e41fh),a		;8118
	jp L_80EC		;811b
L_811E:
	ld a,(0e200h)		;811e
	and a			;8121
	ret nz			;8122
	ld a,(0e412h)		;8123
	dec a			;8126
	ld a,00bh		;8127
	jr z,L_812D		;8129
	ld a,00ch		;812b
L_812D:
	call L_9B3C		;812d
	jp L_81BD		;8130
L_8133:
	ld a,(0e401h)		;8133
	call L_802E		;8136

; ----------------------------------------------------------------------
; DATOS saltos_8139: tabla de 4 palabras del despachador (call 0x408D en
;   0x8136); lo leen el despachador (8 bytes)
;   0x8139..0x8141  (8 bytes)
DATA_saltos_8139:
	defb 041h,081h	; 8139
	defb 09ah,081h	; 813b
	defb 0a2h,081h	; 813d
	defb 0b2h,081h	; 813f

; ======================================================================
; CODIGO 0x8141..0x8176  (53 bytes)
; ======================================================================


L_8141:
	call L_85D5		;8141
	call L_8154		;8144
	ld a,090h		;8147
	ld (0e419h),a		;8149
	ld a,05ah		;814c
	ld (0e403h),a		;814e
	jp L_80EC		;8151
L_8154:
	ld a,(0e412h)		;8154
	dec a			;8157
	jr nz,$+39		;8158
	ld de,08186h		;815a
	call L_8626		;815d
	ld hl,0e40ch		;8160
	ld a,(hl)			;8163
	add a,a			;8164
	add a,(hl)			;8165
	ld hl,08176h		;8166
	call L_8024		;8169
	ld de,03909h		;816c
	ld bc,00003h		;816f
	call 0005ch		;8172   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;8175

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8176..0x817f  (9 bytes)
DATA_8176:
	defb 011h,033h,034h,012h,02eh,024h,013h,032h,024h	; 8176  .34..$.2$

; ======================================================================
; CODIGO 0x817f..0x8186  (7 bytes)
; ======================================================================


L_817F:
	ld de,08192h		;817f
	call L_8626		;8182
	ret			;8185

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8186..0x819a  (20 bytes)
DATA_8186:
	defb 00dh,039h,033h,025h,034h,000h,033h,034h,021h,032h,034h,0ffh,00dh,039h,033h,034h	; 8186  .93%4.34!24..934
	defb 021h,032h,034h,0ffh	; 8196

; ======================================================================
; CODIGO 0x819a..0x81d8  (62 bytes)
; ======================================================================


L_819A:
	ld hl,0e403h		;819a
	dec (hl)			;819d
	ret nz			;819e
	jp L_80EC		;819f
L_81A2:
	call L_84A5		;81a2
	call L_898C		;81a5
	ld hl,0e40ah		;81a8
	ld (hl),001h		;81ab
	ld a,030h		;81ad
	jp L_80E9		;81af
L_81B2:
	call L_866C		;81b2
	ld hl,0e403h		;81b5
	dec (hl)			;81b8
	ret nz			;81b9
	ld (0e403h),a		;81ba
L_81BD:
	ld hl,0e400h		;81bd
	inc (hl)			;81c0
	xor a			;81c1
	ld (0e401h),a		;81c2
	ret			;81c5
L_81C6:
	call L_89D3		;81c6
	ld a,(0e409h)		;81c9
	and a			;81cc
	jp nz,L_81BD		;81cd
	ld a,(0e40ah)		;81d0
	and a			;81d3
	ret nz			;81d4
	jp L_81BD		;81d5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x81d8..0x81e4  (12 bytes)
DATA_81D8:
	defb 03eh,001h,0cdh,03ch,09bh,021h,000h,000h,022h,000h,0e4h,0c9h	; 81d8  >..<.!.."...

; ======================================================================
; CODIGO 0x81e4..0x827e  (154 bytes)
; ======================================================================


L_81E4:
	call L_822D		;81e4
	ld a,(0e409h)		;81e7
	and a			;81ea
	call nz,L_9277		;81eb
	xor a			;81ee
	ld (0e409h),a		;81ef
	ld a,(0e40ah)		;81f2
	and a			;81f5
	jp z,L_8214		;81f6
	xor a			;81f9
	ld (0e409h),a		;81fa
	ld hl,0e41fh		;81fd
	ld a,(hl)			;8200
	ld (hl),000h		;8201
	and a			;8203
	jr z,L_820D		;8204
	ld hl,00006h		;8206
	ld (0e400h),hl		;8209
	ret			;820c
L_820D:
	ld hl,00202h		;820d
	ld (0e400h),hl		;8210
	ret			;8213
L_8214:
	ld a,(0e412h)		;8214
	dec a			;8217
	jp z,L_81BD		;8218
	ld a,(0e41eh)		;821b
	and a			;821e
	jp nz,L_81BD		;821f
	inc a			;8222
	ld (0e41eh),a		;8223
	ld hl,00007h		;8226
	ld (0e400h),hl		;8229
	ret			;822c
L_822D:
	ld hl,03b00h		;822d
	ld bc,00080h		;8230
	ld a,0e0h		;8233
	call 00056h		;8235   ; BIOS FILVRM - Fills VRAM with value
	ret			;8238
L_8239:
	ld a,(0e412h)		;8239
	dec a			;823c
	jp z,L_82CC		;823d
	dec b			;8240
	jr z,$+112		;8241
	dec b			;8243
	jr z,$+126		;8244
	ld hl,0e2f7h		;8246
	ld a,(hl)			;8249
	and a			;824a
	ret z			;824b
	ld (hl),000h		;824c
	ld a,011h		;824e
	call L_9B3C		;8250
	call L_85D5		;8253
	ld de,08294h		;8256
	call L_8626		;8259
	ld de,0827eh		;825c
	call L_8626		;825f
	ld hl,03971h		;8262
	ld de,0e410h		;8265
	call L_8586		;8268
	ld hl,0396dh		;826b
	ld de,0e411h		;826e
	call L_8586		;8271
	xor a			;8274
	ld (0e41eh),a		;8275
	ld (0e403h),a		;8278
	jp L_80EC		;827b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x827e..0x82b1  (51 bytes)
DATA_827E:
	defb 06ah,039h,074h,084h,0feh,074h,039h,072h,084h,0feh,08ah,039h,075h,085h,08ch,0feh	; 827e  j9t..t9r...9u...
	defb 093h,039h,08ch,073h,085h,0ffh,00ch,039h,027h,021h,02dh,025h,000h,033h,025h,034h	; 828e  .9.s...9'!-%.3%4
	defb 0a1h,0ffh,049h,03ah,030h,035h,033h,028h,000h,033h,030h,021h,023h,025h,000h,02bh	; 829e  ..I:053(.30!#%.+
	defb 025h,039h,0ffh	; 82ae

; ======================================================================
; CODIGO 0x82b1..0x8399  (232 bytes)
; ======================================================================


L_82B1:
	call L_831B		;82b1
	ld a,(0e200h)		;82b4
	and a			;82b7
	ret nz			;82b8
	ld de,082a0h		;82b9
	call L_8626		;82bc
	jp L_80EC		;82bf
L_82C2:
	ld a,008h		;82c2
	call 00141h		;82c4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;82c7
	jr c,L_831B		;82c8
	jr L_8308		;82ca
L_82CC:
	dec b			;82cc
	jr z,L_82EF		;82cd
	dec b			;82cf
	jr z,L_8300		;82d0
	ld hl,0e2f7h		;82d2
	ld a,(hl)			;82d5
	and a			;82d6
	ret z			;82d7
	ld (hl),000h		;82d8
	ld a,010h		;82da
	call L_9B3C		;82dc
	call L_83D2		;82df
	call L_83A5		;82e2
	xor a			;82e5
	ld (0e41eh),a		;82e6
	ld (0e403h),a		;82e9
	jp L_80EC		;82ec
L_82EF:
	call L_831B		;82ef
	ld a,(0e200h)		;82f2
	and a			;82f5
	ret nz			;82f6
	ld de,082a0h		;82f7
	call L_8626		;82fa
	jp L_80EC		;82fd
L_8300:
	ld a,008h		;8300
	call 00141h		;8302   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;8305
	jr c,L_831B		;8306
L_8308:
	ld a,001h		;8308
	call L_9B3C		;830a
	xor a			;830d
	ld (0e41eh),a		;830e
	call L_85D5		;8311
	ld hl,00000h		;8314
	ld (0e400h),hl		;8317
	ret			;831a
L_831B:
	ld a,(0e41dh)		;831b
	and a			;831e
	ld de,0881ch		;831f
	jr z,L_832D		;8322
	dec a			;8324
	ld de,08808h		;8325
	jr z,L_832D		;8328
	ld de,08812h		;832a
L_832D:
	ld hl,0e40dh		;832d
	dec (hl)			;8330
	bit 3,(hl)		;8331
	jp z,L_8626		;8333
	jp L_863D		;8336
L_8339:
	dec b			;8339
	jr z,L_8356		;833a
	ld hl,0e2f7h		;833c
	ld a,(hl)			;833f
	and a			;8340
	ret z			;8341
	ld (hl),000h		;8342
	ld a,012h		;8344
	call L_9B3C		;8346
	call L_83D2		;8349
	call L_83A5		;834c
	xor a			;834f
	ld (0e403h),a		;8350
	jp L_80EC		;8353
L_8356:
	ld a,(0e200h)		;8356
	and a			;8359
	ret nz			;835a
	ld a,00bh		;835b
	call L_9B3C		;835d
	ld hl,00002h		;8360
	ld (0e400h),hl		;8363
	ret			;8366
L_8367:
	dec b			;8367
	jr z,L_8388		;8368
	ld hl,0e2f7h		;836a
	ld a,(hl)			;836d
	and a			;836e
	ret z			;836f
	ld (hl),000h		;8370
	ld a,013h		;8372
	call L_9B3C		;8374
	call L_85D5		;8377
	ld de,08399h		;837a
	call L_8626		;837d
	ld a,05ah		;8380
	ld (0e403h),a		;8382
	jp L_80EC		;8385
L_8388:
	ld a,(0e200h)		;8388
	and a			;838b
	ret nz			;838c
	ld a,00ch		;838d
	call L_9B3C		;838f
	ld hl,00002h		;8392
	ld (0e400h),hl		;8395
	ret			;8398

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8399..0x83a5  (12 bytes)
DATA_8399:
	defb 00ch,039h,028h,021h,02ch,026h,000h,034h,029h,02dh,025h,0ffh	; 8399  .9(!,&.4)-%.

; ======================================================================
; CODIGO 0x83a5..0x83c6  (33 bytes)
; ======================================================================


L_83A5:
	ld a,(0e40ch)		;83a5
	add a,a			;83a8
	ld b,a			;83a9
	ld hl,083c6h		;83aa
	ld c,000h		;83ad
L_83AF:
	push bc			;83af
	ld e,(hl)			;83b0
	inc hl			;83b1
	ld d,(hl)			;83b2
	inc hl			;83b3
	push hl			;83b4
	ex de,hl			;83b5
	ld a,c			;83b6
	ld de,0e580h		;83b7
	call L_8029		;83ba
	call L_8593		;83bd
	pop hl			;83c0
	pop bc			;83c1
	inc c			;83c2
	djnz L_83AF		;83c3
	ret			;83c5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x83c6..0x83d2  (12 bytes)
DATA_83C6:
	defb 06dh,039h,0cdh,039h,071h,039h,0d1h,039h,075h,039h,0d5h,039h	; 83c6  m9.9q9.9u9.9

; ======================================================================
; CODIGO 0x83d2..0x83f5  (35 bytes)
; ======================================================================


L_83D2:
	call L_85D5		;83d2
	ld hl,083f5h		;83d5
	ld de,038e8h		;83d8
	ld bc,00a10h		;83db
L_83DE:
	push bc			;83de
	push hl			;83df
	push de			;83e0
	ld b,000h		;83e1
	call 0005ch		;83e3   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop de			;83e6
	ld a,020h		;83e7
	call L_8029		;83e9
	pop hl			;83ec
	pop bc			;83ed
	ld a,c			;83ee
	call L_8024		;83ef
	djnz L_83DE		;83f2
	ret			;83f4

; ----------------------------------------------------------------------
; DATOS sin identificar  0x83f5..0x8495  (160 bytes)
DATA_83F5:
	defb 094h,095h,095h,096h,095h,095h,095h,096h,095h,095h,095h,096h,095h,095h,095h,097h	; 83f5  ................
	defb 098h,0a0h,043h,098h,000h,072h,000h,098h,000h,074h,000h,098h,000h,076h,000h,098h	; 8405  ..C..r...t...v..
	defb 098h,040h,0a0h,098h,000h,073h,000h,098h,000h,075h,000h,098h,000h,077h,000h,098h	; 8415  .@...s...u...w..
	defb 099h,095h,095h,09ah,095h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09ch	; 8425  ................
	defb 098h,072h,084h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8435  .r..............
	defb 098h,073h,085h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8445  .s..............
	defb 099h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09ch	; 8455  ................
	defb 098h,074h,084h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8465  .t..............
	defb 098h,075h,085h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8475  .u..............
	defb 09dh,095h,095h,09eh,095h,095h,095h,09eh,095h,095h,095h,09eh,095h,095h,095h,09fh	; 8485  ................

; ======================================================================
; CODIGO 0x8495..0x84c6  (49 bytes)
; ======================================================================


L_8495:
	ld hl,0e500h		;8495
	ld de,0e501h		;8498
	ld bc,0002fh		;849b
	ld (hl),0e0h		;849e
	ldir		;84a0
	jp L_866C		;84a2
L_84A5:
	call L_84B1		;84a5
	call L_8551		;84a8
	call L_8562		;84ab
	jp L_856F		;84ae
L_84B1:
	ld hl,03800h		;84b1
	ld a,(0e412h)		;84b4
	dec a			;84b7
	ld de,084c6h		;84b8
	jr z,L_84C0		;84bb
	ld de,08506h		;84bd
L_84C0:
	ld bc,00040h		;84c0
	jp L_85EE		;84c3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x84c6..0x8551  (139 bytes)
DATA_84C6:
	defb 000h,000h,000h,088h,070h,08eh,090h,000h,000h,000h,074h,084h,000h,000h,000h,000h	; 84c6  ....p.....t.....
	defb 000h,072h,084h,000h,000h,000h,000h,088h,070h,08eh,090h,000h,000h,000h,000h,000h	; 84d6  .r......p.......
	defb 000h,000h,000h,089h,0a2h,08fh,091h,08ch,000h,000h,075h,085h,08ch,000h,000h,000h	; 84e6  ..........u.....
	defb 000h,073h,085h,08ch,000h,000h,000h,089h,0a2h,08fh,091h,08ch,000h,000h,000h,000h	; 84f6  .s..............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,074h,084h,000h,000h,000h,000h	; 8506  ..........t.....
	defb 000h,072h,084h,000h,000h,000h,000h,08ah,092h,08eh,090h,000h,000h,000h,000h,000h	; 8516  .r..............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,075h,085h,08ch,000h,000h,000h	; 8526  ..........u.....
	defb 000h,073h,085h,08ch,000h,000h,000h,08bh,093h,08fh,091h,08ch,000h,000h,000h,000h	; 8536  .s..............
	defb 021h,010h,0e4h,018h,003h,021h,011h,0e4h,086h,027h,077h	; 8546  !....!...'w

; ======================================================================
; CODIGO 0x8551..0x85ad  (92 bytes)
; ======================================================================


L_8551:
	ld hl,03814h		;8551
	ld de,0e410h		;8554
	call L_8586		;8557
	ld hl,0380dh		;855a
	ld de,0e411h		;855d
	jr L_8586		;8560
L_8562:
	ld a,(0e412h)		;8562
	dec a			;8565
	ret z			;8566
	ld hl,0381ch		;8567
	ld de,0e419h		;856a
	jr L_8586		;856d
L_856F:
	ld a,(0e412h)		;856f
	dec a			;8572
	ret nz			;8573
	ld hl,0381ch		;8574
	ld de,0e417h		;8577
	call L_8593		;857a
	ld hl,03808h		;857d
	ld de,0e41bh		;8580
	jp L_8593		;8583
L_8586:
	ld a,(de)			;8586
	rra			;8587
	rra			;8588
	rra			;8589
	rra			;858a
	and 00fh		;858b
	push de			;858d
	call L_8596		;858e
	pop de			;8591
	inc hl			;8592
L_8593:
	ld a,(de)			;8593
	and 00fh		;8594
L_8596:
	push hl			;8596
	ld de,085adh		;8597
	call L_9079		;859a
	pop hl			;859d
	ld a,e			;859e
	call 0004dh		;859f   ; BIOS WRTVRM - Writes data in VRAM
	push hl			;85a2
	ld bc,00020h		;85a3
	add hl,bc			;85a6
	ld a,d			;85a7
	call 0004dh		;85a8   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;85ab
	ret			;85ac

; ----------------------------------------------------------------------
; DATOS sin identificar  0x85ad..0x85c1  (20 bytes)
DATA_85AD:
	defb 070h,071h,072h,073h,074h,075h,076h,077h,078h,079h,07ah,07bh,07ch,07dh,07eh,07fh	; 85ad  pqrstuvwxyz{|}~.
	defb 080h,081h,082h,083h	; 85bd

; ======================================================================
; CODIGO 0x85c1..0x85f2  (49 bytes)
; ======================================================================


L_85C1:
	ld a,l			;85c1
	rra			;85c2
	rra			;85c3
	rra			;85c4
	rra			;85c5
	rr h		;85c6
	rra			;85c8
	rr h		;85c9
	rra			;85cb
	rr h		;85cc
	ld l,h			;85ce
	and 003h		;85cf
	add a,0e6h		;85d1
	ld h,a			;85d3
	ret			;85d4
L_85D5:
	call L_8495		;85d5
	ld hl,03800h		;85d8
	ld bc,00300h		;85db
	xor a			;85de
	jp 00056h		;85df   ; BIOS FILVRM - Fills VRAM with value
L_85E2:
	ex af,af'			;85e2
	call 00053h		;85e3   ; BIOS SETWRT - Enables VDP to write
	exx			;85e6
	ld a,(00007h)		;85e7
	ld c,a			;85ea
	exx			;85eb
	ex af,af'			;85ec
	ret			;85ed
L_85EE:
	ex de,hl			;85ee
	jp 0005ch		;85ef   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS sin identificar  0x85f2..0x8605  (19 bytes)
DATA_85F2:
	defb 0d9h,006h,003h,0d9h,0c5h,0d5h,0cdh,0eeh,085h,011h,000h,008h,019h,0d1h,0c1h,0d9h	; 85f2  ................
	defb 010h,0f1h,0c9h	; 8602

; ======================================================================
; CODIGO 0x8605..0x86d5  (208 bytes)
; ======================================================================


L_8605:
	ld d,003h		;8605
L_8607:
	push bc			;8607
	push de			;8608
	call 00056h		;8609   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;860c
	add hl,de			;860f
	pop de			;8610
	pop bc			;8611
	dec d			;8612
	jr nz,L_8607		;8613
	ret			;8615
L_8616:
	ld b,003h		;8616
L_8618:
	push bc			;8618
	push de			;8619
	call L_8647		;861a
	ld de,00800h		;861d
	add hl,de			;8620
	pop de			;8621
	pop bc			;8622
	djnz L_8618		;8623
	ret			;8625
L_8626:
	ld c,0ffh		;8626
L_8628:
	ex de,hl			;8628
	ld e,(hl)			;8629
	inc hl			;862a
	ld d,(hl)			;862b
	ex de,hl			;862c
	inc de			;862d
L_862E:
	ld a,(de)			;862e
	inc de			;862f
	ld b,a			;8630
	inc b			;8631
	ret z			;8632
	inc b			;8633
	jr z,L_8628		;8634
	and c			;8636
	call 0004dh		;8637   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;863a
	jr L_862E		;863b
L_863D:
	ld c,000h		;863d
	jr L_8628		;863f
L_8641:
	ex de,hl			;8641
	ld e,(hl)			;8642
	inc hl			;8643
	ld d,(hl)			;8644
	ex de,hl			;8645
	inc de			;8646
L_8647:
	call L_85E2		;8647
L_864A:
	ld a,(de)			;864a
	and a			;864b
	ret z			;864c
	inc de			;864d
	ld b,a			;864e
	and 07fh		;864f
	cp b			;8651
	jr z,L_8662		;8652
	and a			;8654
	jr z,L_8641		;8655
	ld b,a			;8657
L_8658:
	ld a,(de)			;8658
	inc de			;8659
	exx			;865a
	out (c),a		;865b
	exx			;865d
	djnz L_8658		;865e
	jr L_864A		;8660
L_8662:
	ld a,(de)			;8662
	inc de			;8663
L_8664:
	exx			;8664
	out (c),a		;8665
	exx			;8667
	djnz L_8664		;8668
	jr L_864A		;866a
L_866C:
	ld hl,03b00h		;866c
	call 00053h		;866f   ; BIOS SETWRT - Enables VDP to write
	ld a,(00007h)		;8672
	ld c,a			;8675
	ld hl,0e40bh		;8676
	ld a,(hl)			;8679
	add a,068h		;867a
	and 078h		;867c
	ld (hl),a			;867e
	ld e,(hl)			;867f
	ld b,010h		;8680
	ld h,0e5h		;8682
L_8684:
	ld l,e			;8684
	ld a,(hl)			;8685
	inc hl			;8686
	dec a			;8687
	out (c),a		;8688
	ld a,(hl)			;868a
	inc hl			;868b
	out (c),a		;868c
	ld a,(hl)			;868e
	inc hl			;868f
	out (c),a		;8690
	ld a,(hl)			;8692
	inc hl			;8693
	out (c),a		;8694
	ld a,(hl)			;8696
	inc hl			;8697
	dec a			;8698
	out (c),a		;8699
	ld a,(hl)			;869b
	inc hl			;869c
	out (c),a		;869d
	ld a,(hl)			;869f
	inc hl			;86a0
	out (c),a		;86a1
	ld a,(hl)			;86a3
	inc hl			;86a4
	out (c),a		;86a5
	ld a,e			;86a7
	add a,048h		;86a8
	and 078h		;86aa
	ld e,a			;86ac
	djnz L_8684		;86ad
	ret			;86af
L_86B0:
	ld a,0bfh		;86b0
	call 0a3bdh		;86b2
	ld a,001h		;86b5
	call L_9B3C		;86b7
	ld hl,00000h		;86ba
	ld bc,04000h		;86bd
	xor a			;86c0
	call 00056h		;86c1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,086d5h		;86c4
	ld d,008h		;86c7
	ld c,000h		;86c9
L_86CB:
	ld b,(hl)			;86cb
	call 00047h		;86cc   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;86cf
	inc c			;86d0
	dec d			;86d1
	jr nz,L_86CB		;86d2
	ret			;86d4

; ----------------------------------------------------------------------
; DATOS sin identificar  0x86d5..0x86e2  (13 bytes)
DATA_86D5:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e0h,00eh,007h,0c3h,047h,000h	; 86d5  .....v.....G.

; ======================================================================
; CODIGO 0x86e2..0x876e  (140 bytes)
; ======================================================================


L_86E2:
	ld e,08fh		;86e2
	call L_8702		;86e4
	call L_8712		;86e7
	ld hl,0e406h		;86ea
	call L_86FB		;86ed
	ld e,0cfh		;86f0
	call L_8702		;86f2
	call L_873A		;86f5
	ld hl,0e408h		;86f8
L_86FB:
	ld c,(hl)			;86fb
	ld (hl),a			;86fc
	xor c			;86fd
	and (hl)			;86fe
	dec hl			;86ff
	ld (hl),a			;8700
	ret			;8701
L_8702:
	ld a,00fh		;8702
	call 00093h		;8704   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;8707
	di			;8709
	call 00096h		;870a   ; BIOS RDPSG - Reads value from PSG-register
	ei			;870d
	cpl			;870e
	and 03fh		;870f
	ret			;8711
L_8712:
	push af			;8712
	ld a,007h		;8713
	call 00141h		;8715   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8718
	rrca			;8719
	and 020h		;871a
	ld e,a			;871c
	ld a,008h		;871d
	call 00141h		;871f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8722
	rrca			;8723
	rrca			;8724
	ld b,a			;8725
	and 004h		;8726
	or e			;8728
	ld c,a			;8729
	ld a,b			;872a
	rrca			;872b
	rrca			;872c
	ld b,a			;872d
	and 018h		;872e
	or c			;8730
	ld c,a			;8731
	ld a,b			;8732
	rrca			;8733
	and 003h		;8734
	or c			;8736
	pop bc			;8737
	or b			;8738
	ret			;8739
L_873A:
	push af			;873a
	ld a,003h		;873b
	call 00141h		;873d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8740
	ld c,a			;8741
	and 008h		;8742
	ld e,a			;8744
	ld a,c			;8745
	rrca			;8746
	rrca			;8747
	and 001h		;8748
	or e			;874a
	ld e,a			;874b
	ld a,c			;874c
	rlca			;874d
	and 002h		;874e
	or e			;8750
	ld e,a			;8751
	ld a,005h		;8752
	call 00141h		;8754   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8757
	rlca			;8758
	rlca			;8759
	and 004h		;875a
	or e			;875c
	ld e,a			;875d
	ld a,006h		;875e
	call 00141h		;8760   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8763
	rlca			;8764
	rlca			;8765
	rlca			;8766
	rlca			;8767
	and 030h		;8768
	or e			;876a
	pop bc			;876b
	or b			;876c
	ret			;876d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x876e..0x8823  (181 bytes)
DATA_876E:
	defb 0ebh,038h,027h,021h,02dh,025h,000h,033h,025h,02ch,025h,023h,034h,0feh,04eh,039h	; 876e  .8'!-%.3%,%#4.N9
	defb 034h,025h,02eh,02eh,029h,033h,0feh,08eh,039h,028h,02fh,023h,02bh,025h,039h,0feh	; 877e  4%..)3..9(/#+%9.
	defb 0ceh,039h,025h,02eh,024h,0feh,029h,03ah,030h,035h,033h,028h,000h,033h,030h,021h	; 878e  .9%.$.):053(.30!
	defb 023h,025h,000h,02bh,025h,039h,0ffh,06bh,038h,027h,021h,02dh,025h,000h,02dh,02fh	; 879e  #%.+%9.k8'!-%.-/
	defb 024h,029h,026h,039h,0feh,0c8h,038h,02ch,025h,02eh,027h,034h,028h,000h,000h,011h	; 87ae  $)&9..8,%.'4(...
	defb 000h,012h,000h,013h,000h,014h,0feh,008h,039h,033h,030h,025h,025h,024h,000h,000h	; 87be  ........930%%$..
	defb 000h,011h,000h,012h,000h,013h,000h,014h,000h,015h,0feh,048h,039h,034h,039h,030h	; 87ce  ...........H9490
	defb 025h,000h,000h,000h,000h,021h,000h,022h,000h,023h,0feh,088h,039h,022h,021h,032h	; 87de  %....!.".#..9"!2
	defb 000h,000h,000h,000h,000h,02eh,000h,039h,0feh,029h,03ah,030h,035h,033h,028h,000h	; 87ee  .......9.):053(.
	defb 033h,030h,021h,023h,025h,000h,02bh,025h,039h,0ffh,0adh,038h,011h,030h,000h,037h	; 87fe  30!#%.+%9..8.0.7
	defb 029h,02eh,0a1h,0ffh,0adh,038h,012h,030h,000h,037h,029h,02eh,0a1h,0ffh,0aeh,038h	; 880e  )....8.0.7)....8
	defb 024h,032h,021h,037h,0ffh	; 881e

; ======================================================================
; CODIGO 0x8823..0x885b  (56 bytes)
; ======================================================================


L_8823:
	call L_883A		;8823
	ld de,0885bh		;8826
	ld hl,02080h		;8829
	call L_8616		;882c
	ld a,0f0h		;882f
	ld hl,00080h		;8831
	ld bc,00158h		;8834
	jp L_8605		;8837
L_883A:
	ld hl,02000h		;883a
	ld bc,00080h		;883d
	xor a			;8840
	call L_8605		;8841
	ld hl,00000h		;8844
	ld de,00008h		;8847
	ld b,010h		;884a
L_884C:
	push bc			;884c
	ld bc,00008h		;884d
	push hl			;8850
	call L_8605		;8851
	pop hl			;8854
	add hl,de			;8855
	inc a			;8856
	pop bc			;8857
	djnz L_884C		;8858
	ret			;885a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x885b..0x898c  (305 bytes)
DATA_885B:
	defb 08bh,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,004h,018h,0cch,07eh	; 885b  ..."ccc"...8...~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 886b  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 887b  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 888b  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 889b  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,000h,00fh,01fh,004h,0ffh,089h,00fh,000h	; 88ab  <B....B<........
	defb 000h,0feh,0e0h,0e0h,0c0h,0c0h,080h,018h,000h,004h,000h,001h,07eh,004h,000h,0c1h	; 88bb  ............~...
	defb 01ch,036h,063h,063h,07fh,063h,063h,000h,07eh,063h,063h,07eh,063h,063h,07eh,000h	; 88cb  .6cc.cc.~cc~cc~.
	defb 03eh,063h,060h,060h,060h,063h,03eh,000h,07ch,066h,063h,063h,063h,066h,07ch,000h	; 88db  >c```c>.|fcccf|.
	defb 07fh,060h,060h,07eh,060h,060h,07fh,000h,07fh,060h,060h,07eh,060h,060h,060h,000h	; 88eb  .``~``...``~```.
	defb 03eh,063h,060h,067h,063h,063h,03fh,000h,063h,063h,063h,07fh,063h,063h,063h,000h	; 88fb  >c`gcc?.ccc.ccc.
	defb 03ch,005h,018h,083h,03ch,000h,01fh,004h,006h,08bh,066h,03ch,000h,063h,066h,06ch	; 890b  <...<.....f<.cfl
	defb 078h,07ch,06eh,067h,000h,006h,060h,093h,07fh,000h,063h,077h,07fh,07fh,06bh,063h	; 891b  x|ng..`...cw..kc
	defb 063h,000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,005h,063h,0a3h,03eh,000h	; 892b  c.cs{.ogc.>.c.>.
	defb 07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h,03dh,000h	; 893b  ~ccc~``.>cccof=.
	defb 07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h,03eh,000h	; 894b  ~ccb|fc.>c`>.c>.
	defb 07eh,006h,018h,001h,000h,006h,063h,082h,03eh,000h,004h,063h,0a3h,036h,01ch,008h	; 895b  ~.....c.>..c.6..
	defb 000h,063h,063h,06bh,06bh,07fh,077h,022h,000h,063h,076h,03ch,01ch,01eh,037h,063h	; 896b  .cckk.w".cv<..7c
	defb 000h,066h,066h,07eh,03ch,018h,018h,018h,000h,07fh,007h,00eh,01ch,038h,070h,07fh	; 897b  .ff~<........8p.
	defb 000h	; 898b

; ======================================================================
; CODIGO 0x898c..0x8a41  (181 bytes)
; ======================================================================


L_898C:
	call L_8495		;898c
	ld hl,03b00h		;898f
	ld de,0e500h		;8992
	ld bc,00080h		;8995
	call L_85EE		;8998
	ld a,(0e412h)		;899b
	dec a			;899e
	ld hl,095bch		;899f
	jr z,L_89A7		;89a2
	ld hl,0987ch		;89a4
L_89A7:
	ld de,0e640h		;89a7
	ld bc,002c0h		;89aa
	ldir		;89ad
	ld hl,03840h		;89af
	ld de,0e640h		;89b2
	ld bc,002c0h		;89b5
	call L_85EE		;89b8
	call L_89F6		;89bb
	call L_8A55		;89be
	call L_8CB9		;89c1
	call L_8C4D		;89c4
	call L_8BD7		;89c7
	call L_902C		;89ca
	call L_8C86		;89cd
	jp L_866C		;89d0
L_89D3:
	call L_866C		;89d3
	ld a,(0e412h)		;89d6
	dec a			;89d9
	call nz,L_931A		;89da
	call L_8AE1		;89dd
	call L_8B58		;89e0
	call L_8CF2		;89e3
	call L_8C62		;89e6
	call L_8BD7		;89e9
	call L_902C		;89ec
	call L_8C86		;89ef
	call L_935D		;89f2
	ret			;89f5
L_89F6:
	ld bc,00008h		;89f6
	ld de,0e421h		;89f9
	ld hl,08a41h		;89fc
	ld a,(0e412h)		;89ff
	dec a			;8a02
	jr z,L_8A08		;8a03
	ld hl,08a47h		;8a05
L_8A08:
	ldir		;8a08
	ld a,(0e413h)		;8a0a
	ld hl,08a51h		;8a0d
	call L_8024		;8a10
	ld a,(hl)			;8a13
	ld (0e422h),a		;8a14
	ld hl,0e427h		;8a17
	ld a,(0e413h)		;8a1a
	cp 002h		;8a1d
	ld a,001h		;8a1f
	jr c,L_8A24		;8a21
	inc a			;8a23
L_8A24:
	ld (hl),a			;8a24
	ld a,(0e415h)		;8a25
	or a			;8a28
	jp z,L_8AAF		;8a29
	dec a			;8a2c
	ld b,a			;8a2d
	ld a,(0e412h)		;8a2e
	and 002h		;8a31
	add a,b			;8a33
	ld hl,08a4dh		;8a34
	call L_8024		;8a37
	ld a,(hl)			;8a3a
	ld de,0e426h		;8a3b
	ld (de),a			;8a3e
	jr $+112		;8a3f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a41..0x8a55  (20 bytes)
DATA_8A41:
	defb 000h,000h,0e0h,000h,000h,0ffh,000h,000h,0b8h,000h,000h,0ffh,0a8h,050h,098h,060h	; 8a41  .............P.`
	defb 060h,060h,054h,058h	; 8a51

; ======================================================================
; CODIGO 0x8a55..0x8a9f  (74 bytes)
; ======================================================================


L_8A55:
	ld bc,00008h		;8a55
	ld de,0e431h		;8a58
	ld hl,08a9fh		;8a5b
	ld a,(0e412h)		;8a5e
	dec a			;8a61
	jr z,L_8A67		;8a62
	ld hl,08aa5h		;8a64
L_8A67:
	ldir		;8a67
	ld a,(0e413h)		;8a69
	ld hl,08a51h		;8a6c
	call L_8024		;8a6f
	ld a,(hl)			;8a72
	ld (0e432h),a		;8a73
	ld hl,0e437h		;8a76
	ld a,(0e413h)		;8a79
	cp 002h		;8a7c
	ld a,001h		;8a7e
	jr c,L_8A83		;8a80
	inc a			;8a82
L_8A83:
	ld (hl),a			;8a83
	ld a,(0e415h)		;8a84
	or a			;8a87
	jr z,$+60		;8a88
	dec a			;8a8a
	ld b,a			;8a8b
	ld a,(0e412h)		;8a8c
	and 002h		;8a8f
	add a,b			;8a91
	ld hl,08aabh		;8a92
	call L_8024		;8a95
	ld a,(hl)			;8a98
	ld de,0e436h		;8a99
	ld (de),a			;8a9c
	jr $+39		;8a9d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a9f..0x8aaf  (16 bytes)
DATA_8A9F:
	defb 000h,000h,010h,000h,000h,0ffh,000h,000h,038h,000h,000h,0ffh,048h,0a0h,058h,090h	; 8a9f  ........8...H.X.

; ======================================================================
; CODIGO 0x8aaf..0x8ad9  (42 bytes)
; ======================================================================


L_8AAF:
	ld a,(0e413h)		;8aaf
	add a,a			;8ab2
	ld e,a			;8ab3
	ld d,000h		;8ab4
	ld hl,08ad9h		;8ab6
	add hl,de			;8ab9
	ld a,(hl)			;8aba
	ld de,0e428h		;8abb
	ld (de),a			;8abe
	inc e			;8abf
	inc hl			;8ac0
	ld a,(hl)			;8ac1
	ld (de),a			;8ac2
	ret			;8ac3
L_8AC4:
	ld a,(0e413h)		;8ac4
	add a,a			;8ac7
	ld e,a			;8ac8
	ld d,000h		;8ac9
	ld hl,08ad9h		;8acb
	add hl,de			;8ace
	ld a,(hl)			;8acf
	ld de,0e438h		;8ad0
	ld (de),a			;8ad3
	inc e			;8ad4
	inc hl			;8ad5
	ld a,(hl)			;8ad6
	ld (de),a			;8ad7
	ret			;8ad8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8ad9..0x8ae1  (8 bytes)
DATA_8AD9:
	defb 004h,0ffh,008h,0ffh,00ch,010h,014h,010h	; 8ad9  ........

; ======================================================================
; CODIGO 0x8ae1..0x8aee  (13 bytes)
; ======================================================================


L_8AE1:
	call L_8B2C		;8ae1
	ld a,(0e42fh)		;8ae4
	and 003h		;8ae7
	ret z			;8ae9
	dec a			;8aea
	call L_802E		;8aeb

; ----------------------------------------------------------------------
; DATOS saltos_8AEE: tabla de 3 palabras del despachador (call 0x408D en
;   0x8AEB); lo leen el despachador (6 bytes)
;   0x8aee..0x8af4  (6 bytes)
DATA_saltos_8AEE:
	defb 0f4h,08ah	; 8aee
	defb 00eh,08bh	; 8af0
	defb 02bh,08bh	; 8af2

; ======================================================================
; CODIGO 0x8af4..0x8b65  (113 bytes)
; ======================================================================


L_8AF4:
	ld a,(0e413h)		;8af4
	ld hl,08bcfh		;8af7
	call L_8024		;8afa
	ld a,(hl)			;8afd
	ld d,a			;8afe
	ld h,d			;8aff
	dec h			;8b00
	ld l,000h		;8b01
	ld a,(0e422h)		;8b03
	cp d			;8b06
	jr c,L_8B28		;8b07
	ld de,0fc00h		;8b09
	jr L_8B24		;8b0c
L_8B0E:
	ld a,(0e413h)		;8b0e
	ld hl,08bd3h		;8b11
	call L_8024		;8b14
	ld a,(hl)			;8b17
	ld h,a			;8b18
	ld l,000h		;8b19
	ld a,(0e422h)		;8b1b
	cp h			;8b1e
	jr nc,L_8B28		;8b1f
	ld de,00400h		;8b21
L_8B24:
	ld hl,(0e421h)		;8b24
	add hl,de			;8b27
L_8B28:
	ld (0e421h),hl		;8b28
L_8B2B:
	ret			;8b2b
L_8B2C:
	ld a,(0e406h)		;8b2c
	and 003h		;8b2f
	ld b,a			;8b31
	ld c,000h		;8b32
	jr z,L_8B53		;8b34
	ld a,(0e405h)		;8b36
	and 003h		;8b39
	cp 003h		;8b3b
	ret z			;8b3d
	rra			;8b3e
	ld c,001h		;8b3f
	jr c,L_8B53		;8b41
	rra			;8b43
	ld c,002h		;8b44
	jr c,L_8B53		;8b46
	ld a,b			;8b48
	cp 003h		;8b49
	ret z			;8b4b
	rra			;8b4c
	ld c,001h		;8b4d
	jr c,L_8B53		;8b4f
	ld c,002h		;8b51
L_8B53:
	ld a,c			;8b53
	ld (0e42fh),a		;8b54
	ret			;8b57
L_8B58:
	call L_8BA3		;8b58
	ld a,(0e43fh)		;8b5b
	and 003h		;8b5e
	ret z			;8b60
	dec a			;8b61
	call L_802E		;8b62

; ----------------------------------------------------------------------
; DATOS saltos_8B65: tabla de 3 palabras del despachador (call 0x408D en
;   0x8B62); lo leen el despachador (6 bytes)
;   0x8b65..0x8b6b  (6 bytes)
DATA_saltos_8B65:
	defb 06bh,08bh	; 8b65
	defb 085h,08bh	; 8b67
	defb 02bh,08bh	; 8b69

; ======================================================================
; CODIGO 0x8b6b..0x8bcf  (100 bytes)
; ======================================================================


L_8B6B:
	ld a,(0e413h)		;8b6b
	ld hl,08bcfh		;8b6e
	call L_8024		;8b71
	ld a,(hl)			;8b74
	ld d,a			;8b75
	ld h,d			;8b76
	dec h			;8b77
	ld l,000h		;8b78
	ld a,(0e432h)		;8b7a
	cp d			;8b7d
	jr c,L_8B9F		;8b7e
	ld de,0fc00h		;8b80
	jr L_8B9B		;8b83
L_8B85:
	ld a,(0e413h)		;8b85
	ld hl,08bd3h		;8b88
	call L_8024		;8b8b
	ld a,(hl)			;8b8e
	ld h,a			;8b8f
	ld l,000h		;8b90
	ld a,(0e432h)		;8b92
	cp h			;8b95
	jr nc,L_8B9F		;8b96
	ld de,00400h		;8b98
L_8B9B:
	ld hl,(0e431h)		;8b9b
	add hl,de			;8b9e
L_8B9F:
	ld (0e431h),hl		;8b9f
	ret			;8ba2
L_8BA3:
	ld a,(0e408h)		;8ba3
	and 003h		;8ba6
	ld b,a			;8ba8
	ld c,000h		;8ba9
	jr z,L_8BCA		;8bab
	ld a,(0e407h)		;8bad
	and 003h		;8bb0
	cp 003h		;8bb2
	ret z			;8bb4
	rra			;8bb5
	ld c,001h		;8bb6
	jr c,L_8BCA		;8bb8
	rra			;8bba
	ld c,002h		;8bbb
	jr c,L_8BCA		;8bbd
	ld a,b			;8bbf
	cp 003h		;8bc0
	ret z			;8bc2
	rra			;8bc3
	ld c,001h		;8bc4
	jr c,L_8BCA		;8bc6
	ld c,002h		;8bc8
L_8BCA:
	ld a,c			;8bca
	ld (0e43fh),a		;8bcb
	ret			;8bce

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8bcf..0x8bd7  (8 bytes)
DATA_8BCF:
	defb 015h,019h,011h,019h,0ach,0a8h,098h,098h	; 8bcf  ........

; ======================================================================
; CODIGO 0x8bd7..0x8c5e  (135 bytes)
; ======================================================================


L_8BD7:
	ld de,0e422h		;8bd7
	ld hl,0e504h		;8bda
	ld c,00ah		;8bdd
	ld a,(0e423h)		;8bdf
	call L_8C17		;8be2
	ld a,(0e415h)		;8be5
	or a			;8be8
	jr z,L_8BF9		;8be9
	ld de,0e422h		;8beb
	ld hl,0e50ch		;8bee
	ld c,00ah		;8bf1
	ld a,(0e426h)		;8bf3
	call L_8C17		;8bf6
L_8BF9:
	ld de,0e432h		;8bf9
	ld hl,0e514h		;8bfc
	ld c,007h		;8bff
	ld a,(0e433h)		;8c01
	call L_8C17		;8c04
	ld a,(0e415h)		;8c07
	or a			;8c0a
	ret z			;8c0b
	ld de,0e432h		;8c0c
	ld hl,0e51ch		;8c0f
	ld c,007h		;8c12
	ld a,(0e436h)		;8c14
L_8C17:
	push af			;8c17
	ld a,(de)			;8c18
	ld b,a			;8c19
	ld (hl),a			;8c1a
	inc l			;8c1b
	pop af			;8c1c
	exx			;8c1d
	ld b,a			;8c1e
	exx			;8c1f
	ld (hl),a			;8c20
	inc e			;8c21
	inc e			;8c22
	inc e			;8c23
	inc e			;8c24
	inc e			;8c25
	inc e			;8c26
	inc l			;8c27
	ld a,(de)			;8c28
	ld (hl),a			;8c29
	inc l			;8c2a
	ld (hl),c			;8c2b
	inc l			;8c2c
	dec e			;8c2d
	ld a,(de)			;8c2e
	dec a			;8c2f
	jr nz,L_8C3C		;8c30
	ld a,0e0h		;8c32
	ld (hl),a			;8c34
	inc l			;8c35
	ld (hl),a			;8c36
	inc l			;8c37
	ld (hl),a			;8c38
	inc l			;8c39
	ld (hl),a			;8c3a
	ret			;8c3b
L_8C3C:
	ld a,b			;8c3c
	add a,010h		;8c3d
	ld (hl),a			;8c3f
	inc l			;8c40
	exx			;8c41
	ld a,b			;8c42
	exx			;8c43
	ld (hl),a			;8c44
	inc e			;8c45
	inc e			;8c46
	inc l			;8c47
	ld a,(de)			;8c48
	ld (hl),a			;8c49
	inc l			;8c4a
	ld (hl),c			;8c4b
	ret			;8c4c
L_8C4D:
	ld a,(0e416h)		;8c4d
	or a			;8c50
	ret z			;8c51
	ld hl,08c5eh		;8c52
	ld de,0e450h		;8c55
	ld bc,00004h		;8c58
	ldir		;8c5b
	ret			;8c5d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8c5e..0x8c62  (4 bytes)
DATA_8C5E:
	defb 000h,000h,018h,078h	; 8c5e

; ======================================================================
; CODIGO 0x8c62..0x8ce6  (132 bytes)
; ======================================================================


L_8C62:
	ld a,(0e416h)		;8c62
	or a			;8c65
	ret z			;8c66
	ld a,(0e450h)		;8c67
	or a			;8c6a
	ld hl,0e452h		;8c6b
	ld a,(hl)			;8c6e
	jr nz,L_8C77		;8c6f
	cp 088h		;8c71
	jr nc,L_8C7D		;8c73
	inc (hl)			;8c75
	ret			;8c76
L_8C77:
	cp 019h		;8c77
	jr c,L_8C7D		;8c79
	dec (hl)			;8c7b
	ret			;8c7c
L_8C7D:
	ld a,(0e450h)		;8c7d
	xor 001h		;8c80
	ld (0e450h),a		;8c82
	ret			;8c85
L_8C86:
	ld a,(0e416h)		;8c86
	or a			;8c89
	ret z			;8c8a
	ld hl,0e524h		;8c8b
	ld de,0e452h		;8c8e
	ld a,(de)			;8c91
	ld b,a			;8c92
	ld (hl),a			;8c93
	inc l			;8c94
	inc e			;8c95
	ld a,(de)			;8c96
	ld c,a			;8c97
	ld (hl),a			;8c98
	inc l			;8c99
	ld (hl),018h		;8c9a
	inc l			;8c9c
	ld (hl),00dh		;8c9d
	inc l			;8c9f
	ld a,b			;8ca0
	add a,010h		;8ca1
	ld (hl),a			;8ca3
	inc l			;8ca4
	ld (hl),c			;8ca5
	inc l			;8ca6
	ld (hl),01ch		;8ca7
	inc l			;8ca9
	ld (hl),00dh		;8caa
	inc l			;8cac
	add a,010h		;8cad
	ld (hl),a			;8caf
	inc l			;8cb0
	ld (hl),c			;8cb1
	inc l			;8cb2
	ld (hl),020h		;8cb3
	inc l			;8cb5
	ld (hl),00dh		;8cb6
	ret			;8cb8
L_8CB9:
	ld hl,0e448h		;8cb9
	ld (hl),000h		;8cbc
	ld hl,0e449h		;8cbe
	ld (hl),050h		;8cc1
	ld de,0e440h		;8cc3
	ld hl,08ce6h		;8cc6
	ld bc,00008h		;8cc9
	ldir		;8ccc
	ld hl,08ceeh		;8cce
	ld a,(0e41ah)		;8cd1
	or a			;8cd4
	jr nz,L_8CDA		;8cd5
	ld hl,08cf0h		;8cd7
L_8CDA:
	ld a,(0e412h)		;8cda
	dec a			;8cdd
	call L_8024		;8cde
	ld a,(hl)			;8ce1
	ld (0e443h),a		;8ce2
	ret			;8ce5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8ce6..0x8cf2  (12 bytes)
DATA_8CE6:
	defb 000h,060h,000h,000h,000h,000h,000h,000h,0dah,0b3h,015h,03dh	; 8ce6  .`.........=

; ======================================================================
; CODIGO 0x8cf2..0x8d5f  (109 bytes)
; ======================================================================


L_8CF2:
	ld a,(0e448h)		;8cf2
	dec a			;8cf5
	jr z,L_8D4C		;8cf6
	call L_8D63		;8cf8
	ld a,(0e443h)		;8cfb
	cp 078h		;8cfe
	ld a,(0e405h)		;8d00
	jr nc,L_8D08		;8d03
	ld a,(0e407h)		;8d05
L_8D08:
	and 010h		;8d08
	jr nz,L_8D16		;8d0a
	ld a,(0e412h)		;8d0c
	dec a			;8d0f
	ret z			;8d10
	ld hl,0e449h		;8d11
	dec (hl)			;8d14
	ret nz			;8d15
L_8D16:
	ld a,005h		;8d16
	call L_9B3C		;8d18
	ld hl,0e448h		;8d1b
	inc (hl)			;8d1e
	ld hl,08d5fh		;8d1f
	ld a,(0e443h)		;8d22
	cp 078h		;8d25
	jr c,L_8D2C		;8d27
	ld hl,08d61h		;8d29
L_8D2C:
	ld a,r		;8d2c
	and 001h		;8d2e
	or a			;8d30
	jr z,L_8D34		;8d31
	inc hl			;8d33
L_8D34:
	ld a,(hl)			;8d34
	ld (0e44ah),a		;8d35
L_8D38:
	call L_9040		;8d38
	push hl			;8d3b
	ld hl,(0e440h)		;8d3c
	add hl,de			;8d3f
	ld (0e440h),hl		;8d40
	pop de			;8d43
	ld hl,(0e442h)		;8d44
	add hl,de			;8d47
	ld (0e442h),hl		;8d48
	ret			;8d4b
L_8D4C:
	ld a,(0e414h)		;8d4c
	inc a			;8d4f
	ld b,a			;8d50
L_8D51:
	push bc			;8d51
	ld a,(0e44ah)		;8d52
	call L_8D38		;8d55
	call L_8D84		;8d58
	pop bc			;8d5b
	djnz L_8D51		;8d5c
	ret			;8d5e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d5f..0x8d63  (4 bytes)
DATA_8D5F:
	defb 002h,00eh,006h,00ah	; 8d5f

; ======================================================================
; CODIGO 0x8d63..0x8d80  (29 bytes)
; ======================================================================


L_8D63:
	ld a,(0e443h)		;8d63
	cp 078h		;8d66
	ld a,(0e422h)		;8d68
	jr nc,L_8D70		;8d6b
	ld a,(0e432h)		;8d6d
L_8D70:
	ld b,a			;8d70
	ld a,(0e413h)		;8d71
	ld hl,08d80h		;8d74
	call L_8024		;8d77
	ld a,(hl)			;8d7a
	add a,b			;8d7b
	ld (0e441h),a		;8d7c
	ret			;8d7f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d80..0x8d84  (4 bytes)
DATA_8D80:
	defb 000h,000h,00ch,008h	; 8d80

; ======================================================================
; CODIGO 0x8d84..0x8dd3  (79 bytes)
; ======================================================================


L_8D84:
	ld hl,0e44bh		;8d84
	ld (hl),000h		;8d87
	ex af,af'			;8d89
	xor a			;8d8a
	ex af,af'			;8d8b
	exx			;8d8c
	ld c,006h		;8d8d
	exx			;8d8f
	call L_8E44		;8d90
	ex af,af'			;8d93
	ld a,001h		;8d94
	ex af,af'			;8d96
	call L_8E44		;8d97
	ld a,(0e416h)		;8d9a
	or a			;8d9d
	ret z			;8d9e
	ex af,af'			;8d9f
	ld a,002h		;8da0
	ex af,af'			;8da2
	exx			;8da3
	ld c,00ah		;8da4
	exx			;8da6
	jp L_8E44		;8da7
L_8DAA:
	ld a,(0e44ah)		;8daa
	ld b,a			;8dad
	ld a,010h		;8dae
	sub b			;8db0
	and 00fh		;8db1
	ld (0e44ah),a		;8db3
	jr $+66		;8db6
L_8DB8:
	ld a,(0e44bh)		;8db8
	or a			;8dbb
	jr z,L_8DC3		;8dbc
	call L_8DFE		;8dbe
	jr nz,$+55		;8dc1
L_8DC3:
	ld d,000h		;8dc3
	ld a,(0e44ah)		;8dc5
	ld e,a			;8dc8
	ld hl,08dd3h		;8dc9
	add hl,de			;8dcc
	ld a,(hl)			;8dcd
	ld (0e44ah),a		;8dce
	jr $+39		;8dd1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8dd3..0x8de3  (16 bytes)
DATA_8DD3:
	defb 008h,007h,006h,005h,00ch,003h,002h,001h,000h,00fh,00eh,00dh,004h,00bh,00ah,009h	; 8dd3  ................

; ======================================================================
; CODIGO 0x8de3..0x8e24  (65 bytes)
; ======================================================================


L_8DE3:
	ld a,(0e44bh)		;8de3
	or a			;8de6
	jr z,L_8DEE		;8de7
	call L_8DFE		;8de9
	jr nz,L_8DF8		;8dec
L_8DEE:
	ld a,(0e44ah)		;8dee
	add a,008h		;8df1
	and 00fh		;8df3
	ld (0e44ah),a		;8df5
L_8DF8:
	exx			;8df8
	ld a,c			;8df9
	exx			;8dfa
	jp L_9B3C		;8dfb
L_8DFE:
	ld a,(0e44ch)		;8dfe
	or a			;8e01
	ld a,(0e42fh)		;8e02
	jr z,L_8E0A		;8e05
	ld a,(0e43fh)		;8e07
L_8E0A:
	and 003h		;8e0a
	ret z			;8e0c
	cp 003h		;8e0d
	ret z			;8e0f
	rra			;8e10
	ld hl,08e24h		;8e11
	jr c,L_8E19		;8e14
	ld hl,08e34h		;8e16
L_8E19:
	ld a,(0e44ah)		;8e19
	call L_8024		;8e1c
	ld a,(hl)			;8e1f
	ld (0e44ah),a		;8e20
	ret			;8e23

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8e24..0x8e44  (32 bytes)
DATA_8E24:
	defb 005h,005h,006h,007h,005h,001h,002h,003h,001h,002h,003h,003h,003h,005h,005h,006h	; 8e24  ................
	defb 009h,00ah,00bh,00bh,00bh,00dh,00dh,00eh,00fh,00dh,00dh,00eh,00eh,00ah,00bh,00bh	; 8e34  ................

; ======================================================================
; CODIGO 0x8e44..0x8e4a  (6 bytes)
; ======================================================================


L_8E44:
	ld a,(0e44ah)		;8e44
	call L_802E		;8e47

; ----------------------------------------------------------------------
; DATOS saltos_8E4A: tabla de 16 palabras del despachador (call 0x408D en
;   0x8E47); lo leen el despachador (32 bytes)
;   0x8e4a..0x8e6a  (32 bytes)
DATA_saltos_8E4A:
	defb 06ah,08eh	; 8e4a
	defb 07dh,08eh	; 8e4c
	defb 07dh,08eh	; 8e4e
	defb 07dh,08eh	; 8e50
	defb 0ach,08eh	; 8e52
	defb 0bfh,08eh	; 8e54
	defb 0bfh,08eh	; 8e56
	defb 0bfh,08eh	; 8e58
	defb 0eeh,08eh	; 8e5a
	defb 001h,08fh	; 8e5c
	defb 001h,08fh	; 8e5e
	defb 001h,08fh	; 8e60
	defb 030h,08fh	; 8e62
	defb 043h,08fh	; 8e64
	defb 043h,08fh	; 8e66
	defb 043h,08fh	; 8e68

; ======================================================================
; CODIGO 0x8e6a..0x9024  (442 bytes)
; ======================================================================


L_8E6A:
	ld a,(0e443h)		;8e6a
	add a,00bh		;8e6d
	ld h,a			;8e6f
	ld a,(0e441h)		;8e70
	add a,008h		;8e73
	ld l,a			;8e75
	call L_8F72		;8e76
	jp z,L_8DB8		;8e79
	ret			;8e7c
L_8E7D:
	ld a,(0e443h)		;8e7d
	add a,00bh		;8e80
	ld h,a			;8e82
	ld a,(0e441h)		;8e83
	add a,008h		;8e86
	ld l,a			;8e88
	push hl			;8e89
	call L_8F72		;8e8a
	pop hl			;8e8d
	jp z,L_8DB8		;8e8e
	ld a,l			;8e91
	sub 003h		;8e92
	ld l,a			;8e94
	ld a,h			;8e95
	sub 003h		;8e96
	ld h,a			;8e98
	push hl			;8e99
	call L_8F72		;8e9a
	pop hl			;8e9d
	jp z,L_8DAA		;8e9e
	ld a,h			;8ea1
	add a,003h		;8ea2
	ld h,a			;8ea4
	call L_8F72		;8ea5
	jp z,L_8DE3		;8ea8
	ret			;8eab
L_8EAC:
	ld a,(0e443h)		;8eac
	add a,008h		;8eaf
	ld h,a			;8eb1
	ld a,(0e441h)		;8eb2
	add a,005h		;8eb5
	ld l,a			;8eb7
	call L_8F72		;8eb8
	jp z,L_8DAA		;8ebb
	ret			;8ebe
L_8EBF:
	ld a,(0e443h)		;8ebf
	add a,008h		;8ec2
	ld h,a			;8ec4
	ld a,(0e441h)		;8ec5
	add a,005h		;8ec8
	ld l,a			;8eca
	push hl			;8ecb
	call L_8F72		;8ecc
	pop hl			;8ecf
	jp z,L_8DAA		;8ed0
	ld a,l			;8ed3
	add a,003h		;8ed4
	ld l,a			;8ed6
	ld a,h			;8ed7
	sub 003h		;8ed8
	ld h,a			;8eda
	push hl			;8edb
	call L_8F72		;8edc
	pop hl			;8edf
	jp z,L_8DB8		;8ee0
	ld a,l			;8ee3
	sub 003h		;8ee4
	ld l,a			;8ee6
	call L_8F72		;8ee7
	jp z,L_8DE3		;8eea
	ret			;8eed
L_8EEE:
	ld a,(0e443h)		;8eee
	add a,005h		;8ef1
	ld h,a			;8ef3
	ld a,(0e441h)		;8ef4
	add a,008h		;8ef7
	ld l,a			;8ef9
	call L_8F72		;8efa
	jp z,L_8DB8		;8efd
	ret			;8f00
L_8F01:
	ld a,(0e443h)		;8f01
	add a,005h		;8f04
	ld h,a			;8f06
	ld a,(0e441h)		;8f07
	add a,008h		;8f0a
	ld l,a			;8f0c
	push hl			;8f0d
	call L_8F72		;8f0e
	pop hl			;8f11
	jp z,L_8DB8		;8f12
	ld a,l			;8f15
	add a,003h		;8f16
	ld l,a			;8f18
	ld a,h			;8f19
	add a,003h		;8f1a
	ld h,a			;8f1c
	push hl			;8f1d
	call L_8F72		;8f1e
	pop hl			;8f21
	jp z,L_8DAA		;8f22
	ld a,h			;8f25
	sub 003h		;8f26
	ld h,a			;8f28
	call L_8F72		;8f29
	jp z,L_8DE3		;8f2c
	ret			;8f2f
L_8F30:
	ld a,(0e443h)		;8f30
	add a,008h		;8f33
	ld h,a			;8f35
	ld a,(0e441h)		;8f36
	add a,00bh		;8f39
	ld l,a			;8f3b
	call L_8F72		;8f3c
	jp z,L_8DAA		;8f3f
	ret			;8f42
L_8F43:
	ld a,(0e443h)		;8f43
	add a,008h		;8f46
	ld h,a			;8f48
	ld a,(0e441h)		;8f49
	add a,00bh		;8f4c
	ld l,a			;8f4e
	push hl			;8f4f
	call L_8F72		;8f50
	pop hl			;8f53
	jp z,L_8DAA		;8f54
	ld a,l			;8f57
	sub 003h		;8f58
	ld l,a			;8f5a
	ld a,h			;8f5b
	add a,003h		;8f5c
	ld h,a			;8f5e
	push hl			;8f5f
	call L_8F72		;8f60
	pop hl			;8f63
	jp z,L_8DB8		;8f64
	ld a,l			;8f67
	add a,003h		;8f68
	ld l,a			;8f6a
	call L_8F72		;8f6b
	jp z,L_8DE3		;8f6e
	ret			;8f71
L_8F72:
	ex af,af'			;8f72
	ld b,a			;8f73
	ex af,af'			;8f74
	dec b			;8f75
	jp nz,L_8FFE		;8f76
	xor a			;8f79
	ld b,a			;8f7a
	ld (0e44ch),a		;8f7b
	push hl			;8f7e
	ex de,hl			;8f7f
	ld hl,(0e422h)		;8f80
	call L_8FCA		;8f83
	pop de			;8f86
	dec b			;8f87
	ret z			;8f88
	ld b,000h		;8f89
	ld a,001h		;8f8b
	ld (0e44ch),a		;8f8d
	push de			;8f90
	ld hl,(0e432h)		;8f91
	call L_8FCA		;8f94
	pop de			;8f97
	dec b			;8f98
	ret z			;8f99
	ld a,(0e415h)		;8f9a
	or a			;8f9d
	jr nz,L_8FA2		;8f9e
	inc a			;8fa0
	ret			;8fa1
L_8FA2:
	xor a			;8fa2
	ld b,a			;8fa3
	ld (0e44ch),a		;8fa4
	push de			;8fa7
	ld a,(0e422h)		;8fa8
	ld l,a			;8fab
	ld a,(0e426h)		;8fac
	ld h,a			;8faf
	call L_8FCA		;8fb0
	pop de			;8fb3
	dec b			;8fb4
	ret z			;8fb5
	ld b,000h		;8fb6
	ld a,001h		;8fb8
	ld (0e44ch),a		;8fba
	ld a,(0e432h)		;8fbd
	ld l,a			;8fc0
	ld a,(0e436h)		;8fc1
	ld h,a			;8fc4
	call L_8FCA		;8fc5
	dec b			;8fc8
	ret			;8fc9
L_8FCA:
	exx			;8fca
	ld hl,09024h		;8fcb
	ld a,(0e413h)		;8fce
	add a,a			;8fd1
	call L_8024		;8fd2
	ld a,(hl)			;8fd5
	exx			;8fd6
	add a,l			;8fd7
	cp e			;8fd8
	ret nc			;8fd9
	ld l,a			;8fda
	exx			;8fdb
	inc hl			;8fdc
	ld a,(hl)			;8fdd
	exx			;8fde
	add a,l			;8fdf
	cp e			;8fe0
	ret c			;8fe1
	ld a,005h		;8fe2
	add a,h			;8fe4
	cp d			;8fe5
	ret nc			;8fe6
	add a,004h		;8fe7
	cp d			;8fe9
	ret c			;8fea
	ld a,001h		;8feb
	ld (0e44bh),a		;8fed
	exx			;8ff0
	ld a,(0e44ch)		;8ff1
	ld c,008h		;8ff4
	or a			;8ff6
	jr z,L_8FFB		;8ff7
	ld c,007h		;8ff9
L_8FFB:
	exx			;8ffb
	inc b			;8ffc
	ret			;8ffd
L_8FFE:
	djnz L_901B		;8ffe
	ld b,000h		;9000
	call L_9007		;9002
	dec b			;9005
	ret			;9006
L_9007:
	ld a,(0e452h)		;9007
	dec a			;900a
	cp l			;900b
	ret nc			;900c
	add a,030h		;900d
	cp l			;900f
	ret c			;9010
	ld a,07ch		;9011
	cp h			;9013
	ret nc			;9014
	add a,006h		;9015
	cp h			;9017
	ret c			;9018
	inc b			;9019
	ret			;901a
L_901B:
	call L_85C1		;901b
	ld a,(hl)			;901e
	sub 060h		;901f
	ret z			;9021
	dec a			;9022
	ret			;9023

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9024..0x902c  (8 bytes)
DATA_9024:
	defb 003h,008h,0ffh,010h,007h,018h,0ffh,020h	; 9024  .......

; ======================================================================
; CODIGO 0x902c..0x9051  (37 bytes)
; ======================================================================


L_902C:
	ld hl,0e500h		;902c
	ld de,0e441h		;902f
	ld a,(de)			;9032
	ld (hl),a			;9033
	inc l			;9034
	inc e			;9035
	inc e			;9036
	ld a,(de)			;9037
	ld (hl),a			;9038
	inc l			;9039
	ld (hl),000h		;903a
	inc l			;903c
	ld (hl),00fh		;903d
	ret			;903f
L_9040:
	push af			;9040
	ld de,09051h		;9041
	call L_9079		;9044
	pop af			;9047
	push de			;9048
	ld de,09059h		;9049
	call L_9079		;904c
	pop hl			;904f
	ret			;9050

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9051..0x9079  (40 bytes)
DATA_9051:
	defb 000h,001h,0ddh,000h,0b5h,000h,080h,000h,000h,000h,080h,0ffh,04bh,0ffh,023h,0ffh	; 9051  ............K.#.
	defb 000h,0ffh,023h,0ffh,04bh,0ffh,080h,0ffh,000h,000h,080h,000h,0b5h,000h,0ddh,000h	; 9061  ..#.K...........
	defb 000h,001h,0ddh,000h,0b5h,000h,080h,000h	; 9071  ........

; ======================================================================
; CODIGO 0x9079..0x90fa  (129 bytes)
; ======================================================================


L_9079:
	ld l,a			;9079
	ld h,000h		;907a
	add hl,hl			;907c
	add hl,de			;907d
	ld e,(hl)			;907e
	inc hl			;907f
	ld d,(hl)			;9080
	ret			;9081
L_9082:
	ld hl,02300h		;9082
	ld de,09386h		;9085
	jp L_8616		;9088
L_908B:
	ld hl,00300h		;908b
	ld de,0951dh		;908e
	jp L_8616		;9091
L_9094:
	ld de,09535h		;9094
	jp L_8641		;9097
L_909A:
	ld de,0876eh		;909a
	call L_8626		;909d
	ld a,001h		;90a0
	ld (0e412h),a		;90a2
	ret			;90a5
L_90A6:
	ld a,(0e405h)		;90a6
	and 003h		;90a9
	jr z,L_90D0		;90ab
	ld hl,0e412h		;90ad
	rra			;90b0
	jr nc,L_90C1		;90b1
	ld a,(hl)			;90b3
	dec a			;90b4
	jp z,L_90D0		;90b5
	dec (hl)			;90b8
	ld a,002h		;90b9
	call L_9B3C		;90bb
	jp L_90D0		;90be
L_90C1:
	ld a,(hl)			;90c1
	sub 003h		;90c2
	jp z,L_90D0		;90c4
	inc (hl)			;90c7
	ld a,002h		;90c8
	call L_9B3C		;90ca
	jp L_90D0		;90cd
L_90D0:
	xor a			;90d0
	ld hl,0394dh		;90d1
	call 0004dh		;90d4   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;90d7
	ld hl,0398dh		;90d8
	call 0004dh		;90db   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;90de
	ld hl,039cdh		;90df
	call 0004dh		;90e2   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0e412h)		;90e5
	dec a			;90e8
	ld hl,090fah		;90e9
	add a,a			;90ec
	call L_8024		;90ed
	ld e,(hl)			;90f0
	inc hl			;90f1
	ld d,(hl)			;90f2
	ex de,hl			;90f3
	ld a,08dh		;90f4
	call 0004dh		;90f6   ; BIOS WRTVRM - Writes data in VRAM
	ret			;90f9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x90fa..0x9100  (6 bytes)
DATA_90FA:
	defb 04dh,039h,08dh,039h,0cdh,039h	; 90fa

; ======================================================================
; CODIGO 0x9100..0x9126  (38 bytes)
; ======================================================================


L_9100:
	ld de,087a5h		;9100
	call L_8626		;9103
	ld hl,09126h		;9106
	ld de,0e500h		;9109
	ld bc,00010h		;910c
	ldir		;910f
	ld a,003h		;9111
	ld (0e462h),a		;9113
	ld a,004h		;9116
	ld (0e464h),a		;9118
	ld a,002h		;911b
	ld (0e466h),a		;911d
	ld a,001h		;9120
	ld (0e468h),a		;9122
	ret			;9125

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9126..0x9136  (16 bytes)
DATA_9126:
	defb 0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h	; 9126  ..$...$...$...$.

; ======================================================================
; CODIGO 0x9136..0x9204  (206 bytes)
; ======================================================================


L_9136:
	ld a,(0e405h)		;9136
	ld c,a			;9139
	and 00ch		;913a
	jr nz,L_9167		;913c
	ld a,c			;913e
	and 003h		;913f
	jp z,L_9199		;9141
	ld hl,0e460h		;9144
	rra			;9147
	jr nc,L_9158		;9148
	ld a,(hl)			;914a
	and a			;914b
	jp z,L_9199		;914c
	dec (hl)			;914f
	ld a,002h		;9150
	call L_9B3C		;9152
	jp L_9199		;9155
L_9158:
	ld a,(hl)			;9158
	cp 003h		;9159
	jp z,L_9199		;915b
	inc (hl)			;915e
	ld a,002h		;915f
	call L_9B3C		;9161
	jp L_9199		;9164
L_9167:
	ld c,a			;9167
	ld a,(0e460h)		;9168
	ld hl,09204h		;916b
	add a,a			;916e
	call L_8024		;916f
	ld e,(hl)			;9172
	inc hl			;9173
	ld d,(hl)			;9174
	ex de,hl			;9175
	bit 2,c		;9176
	jr z,L_9188		;9178
	ld a,(hl)			;917a
	and a			;917b
	jp z,L_9199		;917c
	dec (hl)			;917f
	ld a,003h		;9180
	call L_9B3C		;9182
	jp L_9199		;9185
L_9188:
	inc hl			;9188
	ld c,(hl)			;9189
	dec hl			;918a
	ld a,(hl)			;918b
	cp c			;918c
	jp z,L_9199		;918d
	inc (hl)			;9190
	ld a,003h		;9191
	call L_9B3C		;9193
	jp L_9199		;9196
L_9199:
	xor a			;9199
	ld hl,038cfh		;919a
	call 0004dh		;919d   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;91a0
	ld hl,0390fh		;91a1
	call 0004dh		;91a4   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;91a7
	ld hl,0394fh		;91a8
	call 0004dh		;91ab   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;91ae
	ld hl,0398fh		;91af
	call 0004dh		;91b2   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0e460h)		;91b5
	ld hl,0920ch		;91b8
	add a,a			;91bb
	call L_8024		;91bc
	ld e,(hl)			;91bf
	inc hl			;91c0
	ld d,(hl)			;91c1
	ex de,hl			;91c2
	ld a,08dh		;91c3
	call 0004dh		;91c5   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0e461h)		;91c8
	ld bc,0e500h		;91cb
	ld hl,09214h		;91ce
	call L_91F5		;91d1
	ld a,(0e463h)		;91d4
	ld bc,0e504h		;91d7
	ld hl,0921ch		;91da
	call L_91F5		;91dd
	ld a,(0e465h)		;91e0
	ld bc,0e508h		;91e3
	ld hl,09226h		;91e6
	call L_91F5		;91e9
	ld a,(0e467h)		;91ec
	ld bc,0e50ch		;91ef
	ld hl,0922ch		;91f2
L_91F5:
	push bc			;91f5
	add a,a			;91f6
	call L_8024		;91f7
	ld e,(hl)			;91fa
	inc hl			;91fb
	ld d,(hl)			;91fc
	pop hl			;91fd
	ld (hl),e			;91fe
	inc hl			;91ff
	ld (hl),d			;9200
	jp L_866C		;9201

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9204..0x9230  (44 bytes)
DATA_9204:
	defb 061h,0e4h,063h,0e4h,065h,0e4h,067h,0e4h,0cfh,038h,00fh,039h,04fh,039h,08fh,039h	; 9204  a.c.e.g..8.9O9.9
	defb 02fh,07fh,02fh,08fh,02fh,09fh,02fh,0afh,03fh,07fh,03fh,08fh,03fh,09fh,03fh,0afh	; 9214  /./././.?.?.?.?.
	defb 03fh,0bfh,04fh,07fh,04fh,08fh,04fh,09fh,05fh,07fh,05fh,08fh	; 9224  ?.O.O.O._._.

; ======================================================================
; CODIGO 0x9230..0x9386  (342 bytes)
; ======================================================================


L_9230:
	ld hl,0e461h		;9230
	ld a,(hl)			;9233
	ld (0e413h),a		;9234
	inc hl			;9237
	inc hl			;9238
	ld a,(hl)			;9239
	ld (0e414h),a		;923a
	inc hl			;923d
	inc hl			;923e
	ld a,(hl)			;923f
	ld (0e415h),a		;9240
	inc hl			;9243
	inc hl			;9244
	ld a,(hl)			;9245
	ld (0e416h),a		;9246
	xor a			;9249
	ld (0e410h),a		;924a
	ld (0e411h),a		;924d
	ld (0e417h),a		;9250
	ld (0e418h),a		;9253
	ld (0e41bh),a		;9256
	ld (0e41ch),a		;9259
	ld (0e419h),a		;925c
	ld (0e41dh),a		;925f
	ld (0e41eh),a		;9262
	inc a			;9265
	ld (0e41ah),a		;9266
	ld a,(0e412h)		;9269
	dec a			;926c
	ld c,00eh		;926d
	jr z,L_9273		;926f
	ld c,00fh		;9271
L_9273:
	ld a,c			;9273
	jp L_9B3C		;9274
L_9277:
	ld a,(0e412h)		;9277
	dec a			;927a
	jp nz,L_92F7		;927b
	ld a,(0e409h)		;927e
	dec a			;9281
	ld hl,0e410h		;9282
	ld de,0e417h		;9285
	jr z,L_9290		;9288
	ld hl,0e411h		;928a
	ld de,0e41bh		;928d
L_9290:
	ld a,(hl)			;9290
	cp 040h		;9291
	jr z,L_92A6		;9293
	and a			;9295
	ld c,015h		;9296
	jr z,L_92A2		;9298
	cp 015h		;929a
	ld c,015h		;929c
	jr z,L_92A2		;929e
	ld c,010h		;92a0
L_92A2:
	add a,c			;92a2
	daa			;92a3
	ld (hl),a			;92a4
	ret			;92a5
L_92A6:
	ld a,(0e41ah)		;92a6
	xor 001h		;92a9
	ld (0e41ah),a		;92ab
	xor a			;92ae
	ld (0e410h),a		;92af
	ld (0e411h),a		;92b2
	ld a,(de)			;92b5
	add a,001h		;92b6
	daa			;92b8
	ld (de),a			;92b9
	cp 006h		;92ba
	ret c			;92bc
	push de			;92bd
	ld hl,0e417h		;92be
	ld de,0e580h		;92c1
	ld a,(0e40ch)		;92c4
	add a,a			;92c7
	call L_8029		;92c8
	ldi		;92cb
	ld hl,0e41bh		;92cd
	ldi		;92d0
	xor a			;92d2
	ld (0e417h),a		;92d3
	ld (0e41bh),a		;92d6
	inc a			;92d9
	ld (0e41fh),a		;92da
	ld hl,0e40ch		;92dd
	inc (hl)			;92e0
	pop de			;92e1
	inc de			;92e2
	ld a,(de)			;92e3
	cp 001h		;92e4
	jp z,L_92EC		;92e6
	inc a			;92e9
	ld (de),a			;92ea
	ret			;92eb
L_92EC:
	ld a,(0e409h)		;92ec
	ld (0e41dh),a		;92ef
	xor a			;92f2
	ld (0e40ah),a		;92f3
	ret			;92f6
L_92F7:
	ld a,(0e409h)		;92f7
	dec a			;92fa
	ld hl,0e410h		;92fb
	ld de,0e417h		;92fe
	jr z,L_9309		;9301
	ld hl,0e411h		;9303
	ld de,0e41bh		;9306
L_9309:
	ld a,(hl)			;9309
	cp 099h		;930a
	ret z			;930c
	add a,001h		;930d
	daa			;930f
	ld (hl),a			;9310
	ld a,(0e41ah)		;9311
	xor 001h		;9314
	ld (0e41ah),a		;9316
	ret			;9319
L_931A:
	ld a,(0e402h)		;931a
	and 03fh		;931d
	ret nz			;931f
	ld a,(0e419h)		;9320
	sub 001h		;9323
	daa			;9325
	ld (0e419h),a		;9326
	push af			;9329
	cp 010h		;932a
	ld a,014h		;932c
	call z,L_9B3C		;932e
	pop af			;9331
	push af			;9332
	and a			;9333
	jr nz,L_933C		;9334
	ld a,01fh		;9336
	ld hl,0e28ah		;9338
	ld (hl),a			;933b
L_933C:
	pop af			;933c
	push af			;933d
	call L_8562		;933e
	pop af			;9341
	and a			;9342
	ret nz			;9343
	ld c,000h		;9344
	ld a,(0e410h)		;9346
	ld hl,0e411h		;9349
	cp (hl)			;934c
	jr z,L_9354		;934d
	ld c,001h		;934f
	jr nc,L_9354		;9351
	inc c			;9353
L_9354:
	ld a,c			;9354
	ld (0e41dh),a		;9355
	xor a			;9358
	ld (0e40ah),a		;9359
	ret			;935c
L_935D:
	ld a,(0e412h)		;935d
	dec a			;9360
	jp nz,L_937B		;9361
L_9364:
	ld a,(0e443h)		;9364
	cp 006h		;9367
	ld c,001h		;9369
	jr c,L_9371		;936b
	inc c			;936d
	cp 0ech		;936e
	ret c			;9370
L_9371:
	ld a,c			;9371
	ld (0e409h),a		;9372
	ld a,009h		;9375
	call L_9B3C		;9377
	ret			;937a
L_937B:
	ld a,(0e441h)		;937b
	cp 04ah		;937e
	ret c			;9380
	cp 076h		;9381
	ret nc			;9383
	jr L_9364		;9384

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9386..0x9b3c  (1974 bytes)
DATA_9386:
	defb 010h,07fh,0a0h,050h,0a7h,05ch,0b3h,02fh,069h,054h,056h,00ah,0e5h,03ah,0cdh,0f4h	; 9386  ...P.\./iTV..:..
	defb 096h,02ah,06ah,056h,054h,069h,02fh,0b3h,05ch,0a7h,050h,06ah,02ah,096h,0f4h,0cdh	; 9396  .*jVTi/.\.Pj*...
	defb 03ah,0e5h,00ah,006h,000h,082h,0a7h,050h,006h,000h,082h,0e5h,00ah,006h,000h,082h	; 93a6  :......P........
	defb 054h,056h,006h,000h,0a2h,02ah,06ah,035h,052h,085h,0c8h,017h,0a8h,049h,0abh,0ach	; 93b6  TV...*j5R....I..
	defb 04ah,0a1h,013h,0e8h,015h,092h,0d5h,0abh,049h,0a8h,017h,0c8h,085h,052h,035h,0d5h	; 93c6  J.......I....R5.
	defb 092h,015h,0e8h,013h,0a1h,04ah,0ach,006h,000h,082h,052h,035h,006h,000h,086h,04ah	; 93d6  .....J....R5...J
	defb 0ach,000h,000h,03eh,07fh,008h,063h,082h,07fh,03eh,004h,000h,002h,00ch,002h,01ch	; 93e6  ...>..c..>......
	defb 006h,00ch,002h,01eh,004h,000h,08ch,03eh,07fh,063h,063h,003h,00fh,03eh,078h,060h	; 93f6  .......>.cc..>x`
	defb 063h,07fh,07fh,004h,000h,08ch,03eh,07fh,063h,063h,003h,00eh,00eh,003h,063h,063h	; 9406  c.....>.cc....cc
	defb 07fh,03eh,004h,000h,08ch,006h,00eh,00eh,01eh,01eh,03eh,036h,07fh,07fh,006h,00fh	; 9416  .>........>6....
	defb 00fh,004h,000h,002h,07fh,002h,060h,088h,07eh,07fh,003h,003h,063h,063h,07fh,03eh	; 9426  ......`.~...cc.>
	defb 004h,000h,087h,03eh,07fh,063h,063h,060h,07eh,07fh,003h,063h,082h,07fh,03eh,004h	; 9436  ...>.cc`~..c..>.
	defb 000h,002h,07fh,002h,063h,083h,007h,00eh,01ch,005h,018h,004h,000h,082h,03eh,07fh	; 9446  ....c.........>.
	defb 003h,063h,002h,03eh,003h,063h,082h,07fh,03eh,004h,000h,082h,03eh,07fh,003h,063h	; 9456  .c.>.c..>...>..c
	defb 087h,07fh,03fh,003h,063h,063h,07fh,03eh,004h,000h,082h,07eh,07fh,003h,063h,082h	; 9466  ..?.cc.>...~..c.
	defb 07fh,07eh,005h,060h,004h,000h,08ch,03eh,07fh,063h,063h,060h,07eh,03fh,003h,063h	; 9476  .~.`...>.cc`~?.c
	defb 063h,07fh,03eh,004h,000h,087h,03eh,07fh,063h,063h,060h,06fh,06fh,003h,063h,082h	; 9486  c.>...>.cc`oo.c.
	defb 07fh,03eh,004h,000h,002h,07eh,00ah,018h,002h,000h,003h,03eh,006h,000h,08bh,020h	; 9496  .>...~.....>...
	defb 030h,038h,03ch,038h,030h,020h,000h,000h,063h,077h,003h,07fh,081h,06bh,006h,063h	; 94a6  08<80 ..cw...k.c
	defb 004h,000h,002h,07fh,003h,060h,002h,07eh,003h,060h,002h,07fh,004h,000h,002h,03ch	; 94b6  .....`.~.`.....<
	defb 008h,018h,002h,03ch,005h,000h,085h,01fh,018h,014h,012h,011h,003h,000h,081h,0ffh	; 94c6  ...<............
	defb 007h,000h,081h,0ffh,004h,010h,003h,000h,081h,0f0h,00fh,010h,081h,01fh,004h,010h	; 94d6  ................
	defb 084h,090h,050h,030h,0ffh,007h,010h,081h,0ffh,007h,010h,081h,0f0h,007h,010h,081h	; 94e6  ..P0............
	defb 01fh,004h,000h,003h,010h,081h,0ffh,004h,000h,003h,010h,081h,0f0h,004h,000h,089h	; 94f6  ................
	defb 080h,040h,020h,010h,008h,004h,002h,001h,000h,004h,018h,002h,000h,084h,018h,063h	; 9506  .@ ............c
	defb 07fh,07fh,003h,063h,002h,000h,000h,081h,0f5h,006h,075h,082h,040h,0fah,006h,0bah	; 9516  ...c......u.@...
	defb 081h,090h,040h,040h,030h,060h,07fh,0f0h,07fh,0f0h,07fh,0f0h,01bh,0f0h,000h,000h	; 9526  ..@@0`..........
	defb 018h,005h,000h,081h,003h,004h,007h,081h,003h,00ah,000h,086h,0c0h,060h,0a0h,0a0h	; 9536  .............`..
	defb 0e0h,0c0h,009h,000h,082h,003h,001h,004h,003h,082h,001h,003h,008h,000h,082h,0c0h	; 9546  ................
	defb 080h,004h,0c0h,082h,080h,0c0h,004h,000h,082h,003h,001h,00ch,003h,084h,001h,003h	; 9556  ................
	defb 0c0h,080h,00ch,0c0h,082h,080h,0c0h,008h,000h,082h,003h,001h,006h,003h,008h,000h	; 9566  ................
	defb 082h,0c0h,080h,006h,0c0h,00eh,003h,082h,001h,003h,00eh,0c0h,084h,080h,0c0h,003h	; 9576  ................
	defb 001h,00eh,003h,082h,0c0h,080h,00eh,0c0h,002h,007h,082h,000h,007h,00ch,005h,002h	; 9586  ................
	defb 0e0h,081h,000h,00dh,0e0h,010h,005h,010h,0e0h,00ch,005h,084h,007h,000h,007h,007h	; 9596  ................
	defb 00dh,0e0h,084h,000h,0e0h,0e0h,0ffh,00ah,080h,081h,0ffh,004h,000h,081h,0f0h,00ah	; 95a6  ................
	defb 010h,081h,0f0h,004h,000h,000h,000h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 95b6  .......aaaaaaaaa
	defb 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 95c6  aaaaaaaaaaaaaaaa
	defb 061h,061h,061h,061h,061h,000h,000h,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh	; 95d6  aaaaa..onononono
	defb 06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh	; 95e6  nononononononono
	defb 06eh,06fh,06eh,06fh,06eh,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 95f6  nonon..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9606  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9616  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9626  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9636  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9646  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9656  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9666  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9676  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9686  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9696  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96a6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96b6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96c6  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96d6  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96e6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96f6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9706  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9716  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9726  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9736  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9746  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9756  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9766  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9776  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9786  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9796  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97a6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97b6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97c6  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97d6  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97e6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97f6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9806  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9816  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9826  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9836  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9846  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 9856  jkjkj..aaaaaaaaa
	defb 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 9866  aaaaaaaaaaaaaaaa
	defb 061h,061h,061h,061h,061h,000h,000h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9876  aaaaa..`````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9886  ````````````````
	defb 060h,060h,060h,060h,060h,000h,000h,060h,066h,067h,066h,067h,066h,067h,066h,067h	; 9896  `````..`fgfgfgfg
	defb 066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h	; 98a6  fgfgfgfgfgfgfgfg
	defb 066h,067h,066h,067h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 98b6  fgfg`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 98c6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 98d6  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 98e6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 98f6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9906  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9916  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9926  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9936  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9946  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,060h,060h,060h,060h,064h,065h,064h,065h	; 9956  bcbc`..`````dede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9966  dededededededede
	defb 060h,060h,060h,060h,060h,000h,000h,069h,068h,069h,068h,069h,062h,063h,062h,063h	; 9976  `````..ihihibcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9986  bcbcbcbcbcbcbcbc
	defb 069h,068h,069h,068h,069h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9996  ihihi..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99a6  dededededededede
	defb 064h,065h,064h,065h,064h,000h,000h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99b6  deded..cbcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99c6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,062h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99d6  bcbcb..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99e6  dededededededede
	defb 064h,065h,064h,065h,064h,000h,000h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99f6  deded..cbcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a06  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,062h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a16  bcbcb..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a26  dededededededede
	defb 064h,065h,064h,065h,065h,000h,000h,060h,060h,060h,060h,060h,062h,063h,062h,063h	; 9a36  dedee..`````bcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a46  bcbcbcbcbcbcbcbc
	defb 060h,060h,060h,060h,060h,000h,000h,060h,066h,067h,066h,067h,064h,065h,064h,065h	; 9a56  `````..`fgfgdede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a66  dededededededede
	defb 067h,066h,067h,066h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a76  gfgf`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a86  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a96  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9aa6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9ab6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9ac6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9ad6  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9ae6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9af6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9b06  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9b16  bcbc`..`````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9b26  ````````````````
	defb 060h,060h,060h,060h,060h,000h	; 9b36

; ======================================================================
; CODIGO 0x9b3c..0x9beb  (175 bytes)
; ======================================================================


L_9B3C:
	di			;9b3c
	push ix		;9b3d
	push iy		;9b3f
	push hl			;9b41
	push de			;9b42
	push bc			;9b43
	push af			;9b44
	call L_9B52		;9b45
	pop af			;9b48
	pop bc			;9b49
	pop de			;9b4a
	pop hl			;9b4b
	pop iy		;9b4c
	pop ix		;9b4e
	ei			;9b50
	ret			;9b51
L_9B52:
	ld c,a			;9b52
	ld hl,0e2ddh		;9b53
	ld (hl),c			;9b56
	ld hl,09bf5h		;9b57
	ld a,c			;9b5a
	add a,c			;9b5b
	ld e,a			;9b5c
	ld d,000h		;9b5d
	add hl,de			;9b5f
	ld e,(hl)			;9b60
	inc hl			;9b61
	ld d,(hl)			;9b62
	ex de,hl			;9b63
	ld de,0e2deh		;9b64
	ld bc,0000ch		;9b67
	ldir		;9b6a
	ld ix,0e2e0h		;9b6c
	ld hl,0e2deh		;9b70
	bit 7,(hl)		;9b73
	jp z,L_9B84		;9b75
	inc hl			;9b78
	ld a,(hl)			;9b79
	ld hl,0e201h		;9b7a
	call L_9BCB		;9b7d
	inc ix		;9b80
	inc ix		;9b82
L_9B84:
	ld hl,0e2deh		;9b84
	bit 6,(hl)		;9b87
	jp z,L_9B98		;9b89
	inc hl			;9b8c
	ld a,(hl)			;9b8d
	ld hl,0e22dh		;9b8e
	call L_9BCB		;9b91
	inc ix		;9b94
	inc ix		;9b96
L_9B98:
	ld hl,0e2deh		;9b98
	bit 5,(hl)		;9b9b
	jp z,L_9BAC		;9b9d
	inc hl			;9ba0
	ld a,(hl)			;9ba1
	ld hl,0e259h		;9ba2
	call L_9BCB		;9ba5
	inc ix		;9ba8
	inc ix		;9baa
L_9BAC:
	ld hl,0e2deh		;9bac
	bit 4,(hl)		;9baf
	jp z,L_9BC0		;9bb1
	inc hl			;9bb4
	ld a,(hl)			;9bb5
	ld hl,0e285h		;9bb6
	call L_9BCB		;9bb9
	inc ix		;9bbc
	inc ix		;9bbe
L_9BC0:
	ld hl,0e2deh		;9bc0
	bit 3,(hl)		;9bc3
	ret z			;9bc5
	inc hl			;9bc6
	ld a,(hl)			;9bc7
	ld hl,0e2b1h		;9bc8
L_9BCB:
	ld b,(hl)			;9bcb
	cp b			;9bcc
	ret c			;9bcd
	ex de,hl			;9bce
	ld (de),a			;9bcf
	dec de			;9bd0
	ld hl,0e2ddh		;9bd1
	ld a,(hl)			;9bd4
	ld (de),a			;9bd5
	inc de			;9bd6
	inc de			;9bd7
	ld a,(ix+000h)		;9bd8
	ld (de),a			;9bdb
	inc de			;9bdc
	ld a,(ix+001h)		;9bdd
	ld (de),a			;9be0
	inc de			;9be1
	ld hl,09bebh		;9be2
	ld bc,0000ch		;9be5
	ldir		;9be8
	ret			;9bea

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9beb..0x9ca5  (186 bytes)
DATA_9BEB:
	defb 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,01fh,09ch,029h,09ch	; 9beb  ..............).
	defb 02dh,09ch,031h,09ch,035h,09ch,039h,09ch,03dh,09ch,041h,09ch,045h,09ch,049h,09ch	; 9bfb  -.1.5.9.=.A.E.I.
	defb 04dh,09ch,055h,09ch,05dh,09ch,065h,09ch,06fh,09ch,079h,09ch,083h,09ch,08dh,09ch	; 9c0b  M.U.].e.o.y.....
	defb 097h,09ch,0a1h,09ch,0f0h,080h,057h,0a4h,057h,0a4h,057h,0a4h,057h,0a4h,010h,040h	; 9c1b  ......W.W.W.W..@
	defb 02eh,0adh,010h,040h,047h,0adh,010h,040h,064h,0adh,010h,040h,0abh,0adh,010h,030h	; 9c2b  ...@G..@d..@...0
	defb 0eah,0adh,010h,040h,02dh,0aeh,010h,040h,060h,0aeh,010h,050h,093h,0aeh,010h,040h	; 9c3b  ...@-..@`..P...@
	defb 0a6h,0aeh,0e0h,020h,058h,0a4h,026h,0a5h,091h,0a5h,0e0h,020h,008h,0a6h,0a1h,0a6h	; 9c4b  ... X.&.... ....
	defb 08dh,0a7h,0e0h,020h,042h,0a8h,070h,0a8h,0a5h,0a8h,0f0h,070h,0d0h,0a8h,021h,0a9h	; 9c5b  ... B.p....p..!.
	defb 051h,0a9h,057h,0a4h,0f0h,070h,089h,0a9h,0c0h,0a9h,00ah,0aah,057h,0a4h,0f0h,070h	; 9c6b  Q.W..p......W..p
	defb 052h,0aah,099h,0aah,0e1h,0aah,057h,0a4h,0f0h,070h,029h,0abh,069h,0abh,097h,0abh	; 9c7b  R.....W..p).i...
	defb 057h,0a4h,0f0h,070h,0d8h,0abh,006h,0ach,034h,0ach,057h,0a4h,0f0h,070h,061h,0ach	; 9c8b  W..p....4.W..pa.
	defb 0a4h,0ach,0e1h,0ach,057h,0a4h,010h,060h,0dbh,0aeh	; 9c9b  ....W..`..

; ======================================================================
; CODIGO 0x9ca5..0x9d6f  (202 bytes)
; ======================================================================


L_9CA5:
	ld a,(0e2eeh)		;9ca5
	call 0a3bdh		;9ca8
	ld a,001h		;9cab
	ld (0e2efh),a		;9cad
	ld ix,0e200h		;9cb0
	call L_9CDF		;9cb4
	ld a,002h		;9cb7
	ld (0e2efh),a		;9cb9
	ld ix,0e22ch		;9cbc
	call L_9CDF		;9cc0
	ld a,004h		;9cc3
	ld (0e2efh),a		;9cc5
	ld ix,0e258h		;9cc8
	call L_9CDF		;9ccc
	ld a,008h		;9ccf
	ld (0e2efh),a		;9cd1
	ld ix,0e284h		;9cd4
	call L_9CDF		;9cd8
	call 0a291h		;9cdb
	ret			;9cde
L_9CDF:
	ld a,(ix+000h)		;9cdf
	or a			;9ce2
	call nz,L_9CE7		;9ce3
	ret			;9ce6
L_9CE7:
	dec (ix+004h)		;9ce7
	jp nz,L_9E6D		;9cea
	ld l,(ix+002h)		;9ced
	ld h,(ix+003h)		;9cf0
L_9CF3:
	ld a,(hl)			;9cf3
	cp 0ffh		;9cf4
	jp z,L_9FC1		;9cf6
	cp 0d0h		;9cf9
	jp c,L_9D05		;9cfb
	call 0a029h		;9cfe
	inc hl			;9d01
	jp L_9CF3		;9d02
L_9D05:
	bit 0,(ix+009h)		;9d05
	jp nz,L_9D1C		;9d09
	bit 1,(ix+009h)		;9d0c
	jp nz,L_9D7B		;9d10
	ld a,(ix+009h)		;9d13
	and 03ch		;9d16
	jp nz,L_9DED		;9d18
	ret			;9d1b
L_9D1C:
	ld a,(hl)			;9d1c
	and 00fh		;9d1d
	ld b,a			;9d1f
	ld a,(ix+014h)		;9d20
	jp z,L_9D2A		;9d23
	ld e,a			;9d26
L_9D27:
	add a,e			;9d27
	djnz L_9D27		;9d28
L_9D2A:
	ld (ix+004h),a		;9d2a
	ld a,(hl)			;9d2d
	and 0f0h		;9d2e
	rrca			;9d30
	rrca			;9d31
	rrca			;9d32
	rrca			;9d33
	call L_9FB9		;9d34
	bit 7,(ix+009h)		;9d37
	ret nz			;9d3b
	cp 00ch		;9d3c
	jp nc,L_9D6A		;9d3e
	ld hl,09d6fh		;9d41
	ld e,a			;9d44
	ld d,000h		;9d45
	add hl,de			;9d47
	ld l,(hl)			;9d48
	ld h,000h		;9d49
	ld a,(ix+016h)		;9d4b
	or a			;9d4e
	jp z,L_9D56		;9d4f
	ld b,a			;9d52
L_9D53:
	add hl,hl			;9d53
	djnz L_9D53		;9d54
L_9D56:
	ld (ix+010h),l		;9d56
	ld (ix+011h),h		;9d59
	ld e,(ix+015h)		;9d5c
	ld (ix+012h),e		;9d5f
	ld (ix+00dh),002h		;9d62
	call L_9E22		;9d66
	ret			;9d69
L_9D6A:
	ld (ix+00dh),000h		;9d6a
	ret			;9d6e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9d6f..0x9d7b  (12 bytes)
DATA_9D6F:
	defb 06ah,064h,05eh,059h,054h,04fh,04ah,046h,042h,03fh,03bh,038h	; 9d6f  jd^YTOJFB?.8

; ======================================================================
; CODIGO 0x9d7b..0x9ffe  (643 bytes)
; ======================================================================


L_9D7B:
	ld a,(ix+00dh)		;9d7b
	and 003h		;9d7e
	jp z,L_9DDE		;9d80
	cp 001h		;9d83
	jp z,L_9DC3		;9d85
	ld a,(hl)			;9d88
	bit 6,(ix+00eh)		;9d89
	jp nz,L_9DAD		;9d8d
	bit 5,(ix+00eh)		;9d90
	jp nz,L_9DB3		;9d94
	and 0f0h		;9d97
	ld b,a			;9d99
	xor (hl)			;9d9a
	ld d,a			;9d9b
	inc hl			;9d9c
	ld a,(hl)			;9d9d
	ld (ix+010h),a		;9d9e
	ld (ix+011h),d		;9da1
	ld a,b			;9da4
	rrca			;9da5
	rrca			;9da6
	rrca			;9da7
	rrca			;9da8
	ld b,a			;9da9
	jp L_9DC7		;9daa
L_9DAD:
	ld (ix+010h),a		;9dad
	jp L_9DD5		;9db0
L_9DB3:
	and 0f0h		;9db3
	rrca			;9db5
	rrca			;9db6
	rrca			;9db7
	rrca			;9db8
	ld b,a			;9db9
	ld a,(hl)			;9dba
	and 00fh		;9dbb
	ld (ix+011h),a		;9dbd
	jp L_9DC7		;9dc0
L_9DC3:
	ld a,(hl)			;9dc3
	and 00fh		;9dc4
	ld b,a			;9dc6
L_9DC7:
	bit 2,(ix+00dh)		;9dc7
	jp z,L_9DD0		;9dcb
	ld b,010h		;9dce
L_9DD0:
	inc b			;9dd0
	inc b			;9dd1
	ld (ix+012h),b		;9dd2
L_9DD5:
	ld e,(ix+012h)		;9dd5
	ld (ix+012h),e		;9dd8
	call L_9E22		;9ddb
L_9DDE:
	bit 7,(ix+009h)		;9dde
	ret nz			;9de2
	call L_9FB9		;9de3
	ld a,(ix+013h)		;9de6
	ld (ix+004h),a		;9de9
	ret			;9dec
L_9DED:
	set 7,(ix+009h)		;9ded
	call L_9D1C		;9df1
	ld hl,0a3dah		;9df4
	add a,a			;9df7
	ld e,a			;9df8
	ld d,000h		;9df9
	add hl,de			;9dfb
	ld e,(hl)			;9dfc
	inc hl			;9dfd
	ld d,(hl)			;9dfe
	ex de,hl			;9dff
	ld a,(hl)			;9e00
L_9E01:
	set 1,(ix+009h)		;9e01
	call L_9CF3		;9e05
	res 1,(ix+009h)		;9e08
	res 7,(ix+009h)		;9e0c
	ld a,(ix+013h)		;9e10
	ld (ix+019h),a		;9e13
	inc hl			;9e16
	ld (ix+017h),l		;9e17
	ld (ix+018h),h		;9e1a
	set 0,(ix+00eh)		;9e1d
	ret			;9e21
L_9E22:
	call L_9EB1		;9e22
	res 4,(ix+00eh)		;9e25
	ld a,(ix+00fh)		;9e29
	and 0d7h		;9e2c
	ld (ix+00fh),a		;9e2e
	xor a			;9e31
	ld (ix+01dh),a		;9e32
	ld (ix+01eh),a		;9e35
	ld (ix+01fh),a		;9e38
	ld (ix+020h),a		;9e3b
	set 2,(ix+00fh)		;9e3e
	ld a,(ix+012h)		;9e42
	bit 7,(ix+00eh)		;9e45
	jp z,L_9E53		;9e49
	ld e,(ix+015h)		;9e4c
	sub e			;9e4f
	call m,L_9E6B		;9e50
L_9E53:
	ld (ix+00ch),a		;9e53
	bit 2,(ix+00dh)		;9e56
	ret nz			;9e5a
	bit 1,(ix+00fh)		;9e5b
	ret z			;9e5f
	ld a,(ix+025h)		;9e60
	ld (ix+00ch),a		;9e63
	res 2,(ix+00fh)		;9e66
	ret			;9e6a
L_9E6B:
	xor a			;9e6b
	ret			;9e6c
L_9E6D:
	bit 0,(ix+00eh)		;9e6d
	jp nz,L_9E8D		;9e71
	bit 2,(ix+00eh)		;9e74
	call nz,L_9ECE		;9e78
	bit 0,(ix+00fh)		;9e7b
	call nz,L_9F23		;9e7f
	ld a,(0e2efh)		;9e82
	cp 004h		;9e85
	ret nz			;9e87
	xor a			;9e88
	ld (0e2f7h),a		;9e89
	ret			;9e8c
L_9E8D:
	dec (ix+019h)		;9e8d
	ret nz			;9e90
	ld l,(ix+017h)		;9e91
	ld h,(ix+018h)		;9e94
	ld a,(hl)			;9e97
	cp 0ffh		;9e98
	jp z,L_9EA5		;9e9a
	set 7,(ix+009h)		;9e9d
	call L_9E01		;9ea1
	ret			;9ea4
L_9EA5:
	res 0,(ix+00eh)		;9ea5
	xor a			;9ea9
	ld (ix+00ch),a		;9eaa
	ld (ix+00dh),a		;9ead
	ret			;9eb0
L_9EB1:
	ld e,(ix+010h)		;9eb1
	ld d,(ix+011h)		;9eb4
	bit 1,(ix+00eh)		;9eb7
	jp z,L_9EC7		;9ebb
	ld a,(ix+026h)		;9ebe
	add a,e			;9ec1
	ld e,a			;9ec2
	jp nc,L_9EC7		;9ec3
	inc d			;9ec6
L_9EC7:
	ld (ix+00ah),e		;9ec7
	ld (ix+00bh),d		;9eca
	ret			;9ecd
L_9ECE:
	inc (ix+01eh)		;9ece
	ld a,(ix+01eh)		;9ed1
	ld b,(ix+00eh)		;9ed4
	bit 4,b		;9ed7
	jp nz,L_9EF0		;9ed9
	bit 3,b		;9edc
	jp z,L_9EF0		;9ede
	cp (ix+01ah)		;9ee1
	ret nz			;9ee4
	ld (ix+01eh),000h		;9ee5
	set 4,(ix+00eh)		;9ee9
	jp L_9EF4		;9eed
L_9EF0:
	cp (ix+01bh)		;9ef0
	ret nz			;9ef3
L_9EF4:
	ld e,(ix+00ah)		;9ef4
	ld d,(ix+00bh)		;9ef7
	ld b,(ix+01ch)		;9efa
	ld a,(ix+01dh)		;9efd
	cpl			;9f00
	ld (ix+01dh),a		;9f01
	and a			;9f04
	ld a,e			;9f05
	jp nz,L_9F12		;9f06
	add a,b			;9f09
	ld e,a			;9f0a
	jp nc,L_9F18		;9f0b
	inc d			;9f0e
	jp L_9F18		;9f0f
L_9F12:
	sub b			;9f12
	ld e,a			;9f13
	jp nc,L_9F18		;9f14
	dec d			;9f17
L_9F18:
	ld (ix+00ah),e		;9f18
	ld (ix+00bh),d		;9f1b
	ld (ix+01eh),000h		;9f1e
	ret			;9f22
L_9F23:
	bit 2,(ix+00dh)		;9f23
	ret nz			;9f27
	call L_9F2F		;9f28
	ld (ix+00ch),e		;9f2b
	ret			;9f2e
L_9F2F:
	ld e,(ix+00ch)		;9f2f
	inc (ix+01fh)		;9f32
	ld b,(ix+01fh)		;9f35
	bit 5,(ix+00fh)		;9f38
	jp nz,L_9FAD		;9f3c
	bit 3,(ix+00fh)		;9f3f
	jp nz,L_9F74		;9f43
	bit 2,(ix+00fh)		;9f46
	jp nz,L_9F60		;9f4a
	ld a,e			;9f4d
	inc a			;9f4e
	ld e,a			;9f4f
	cp (ix+012h)		;9f50
	ret c			;9f53
	set 2,(ix+00fh)		;9f54
	ld e,(ix+012h)		;9f58
	ld (ix+01fh),000h		;9f5b
	ret			;9f5f
L_9F60:
	ld a,e			;9f60
	dec a			;9f61
	jp m,L_9F66		;9f62
	ld e,a			;9f65
L_9F66:
	ld a,b			;9f66
	cp (ix+021h)		;9f67
	ret c			;9f6a
	ld (ix+01fh),000h		;9f6b
	set 3,(ix+00fh)		;9f6f
	ret			;9f73
L_9F74:
	bit 4,(ix+00fh)		;9f74
	jp nz,L_9F97		;9f78
	ld a,b			;9f7b
	cp (ix+022h)		;9f7c
	ret nz			;9f7f
	ld a,e			;9f80
	dec a			;9f81
	ret m			;9f82
	ld e,a			;9f83
	inc (ix+020h)		;9f84
	ld a,(ix+020h)		;9f87
	cp (ix+023h)		;9f8a
	ld (ix+01fh),000h		;9f8d
	ret nz			;9f91
	set 5,(ix+00fh)		;9f92
	ret			;9f96
L_9F97:
	ld a,(ix+022h)		;9f97
	ld d,a			;9f9a
	ld a,e			;9f9b
	sub d			;9f9c
	ld e,000h		;9f9d
	jp m,L_9FA3		;9f9f
	ld e,a			;9fa2
L_9FA3:
	ld a,b			;9fa3
	cp (ix+023h)		;9fa4
	ret nz			;9fa7
	set 5,(ix+00fh)		;9fa8
	ret			;9fac
L_9FAD:
	ld a,(ix+004h)		;9fad
	cp (ix+024h)		;9fb0
	ret nc			;9fb3
	ld a,e			;9fb4
	dec a			;9fb5
	ret m			;9fb6
	ld e,a			;9fb7
	ret			;9fb8
L_9FB9:
	inc hl			;9fb9
	ld (ix+002h),l		;9fba
	ld (ix+003h),h		;9fbd
	ret			;9fc0
L_9FC1:
	xor a			;9fc1
	ld (ix+000h),a		;9fc2
	ld (ix+001h),a		;9fc5
	ld (ix+005h),a		;9fc8
	ld (ix+006h),a		;9fcb
	ld (ix+00ah),a		;9fce
	ld (ix+00bh),a		;9fd1
	ld (ix+00ch),a		;9fd4
	ld (ix+00dh),a		;9fd7
	ld (ix+00eh),a		;9fda
	ld (ix+00fh),a		;9fdd
	call L_9FFB		;9fe0
	ld hl,0e2f2h		;9fe3
	ld a,(0e2efh)		;9fe6
	cp 008h		;9fe9
	jp nz,L_9FF8		;9feb
	res 1,(hl)		;9fee
	bit 3,(hl)		;9ff0
	ret z			;9ff2
	res 3,(hl)		;9ff3
	set 2,(hl)		;9ff5
	ret			;9ff7
L_9FF8:
	res 3,(hl)		;9ff8
	ret			;9ffa
L_9FFB:
	ld hl,0e2f6h		;9ffb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9ffe..0xa000  (2 bytes)
DATA_9FFE:
	defb 03ah,0efh	; 9ffe
