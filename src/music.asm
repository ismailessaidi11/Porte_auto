/*
 * music.asm
 *
 *  Created: 29/05/2023 14:11:13
 *   Author: ismai
 */ 



welcome_music:
	clr			c1
	ldi			zl, low(2*keys-1)	; load table base into z
	ldi			zh, high(2*keys-1)
	_LDI		c2,0x03
	rjmp		music
mode_sound:
	clr			c1
	ldi			zl, low(2*keys+2)	; load table base into z
	ldi			zh, high(2*keys+2)
	_LDI		c2,0x02
	rjmp		music
music:
	inc			zl		; add offset to table base
	lpm			; load program memory, r0 <- (z)
	mov			a0,r0		; load oscillation period
	ldi			b0,40		; load duration (40*2.5ms = 100ms)
	rcall		sound
	inc			c1
	cp			c1,c2
	brlo		music

	ret
	
keys:
	.db			do2,fa2,la2,re3,la3,0


