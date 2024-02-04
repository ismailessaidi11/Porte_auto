/*
 * display_subroutines.asm
 *
 *  Created: 29/05/2023 10:44:43
 *   Author: manon
 */
.org	0x400

welcome_display:
	push		a1				
    rcall		LCD_clear
    PRINTF		LCD
	.db   		"WELCOME",0
    ldi			a1,0					;a1: counter
	loop1:
		WAIT_MS		175
		rcall		LCD_display_right	;right-moving display
		subi		a1,-1
		cpi			a1,17				;end of screen
		brne		loop1
    rcall		LCD_clear
    pop			a1
    ret

;==============================================

manual_display:
    push		a1
    rcall		LCD_clear
    PRINTF		LCD
	.db   		"MANUAL MODE",0
    ldi			a1,0					;a1: counter
	loop2:
		WAIT_MS		150
		rcall		LCD_display_right	;right-moving display
		subi		a1,-1
		cpi			a1,17				;end of screen
		brne		loop2
    rcall		LCD_clear
    pop			a1
    ret

;=============================================

automatic_display:
    push		a1
    rcall		LCD_clear
    PRINTF		LCD
	.db   		"AUTO MODE",0
    ldi			a1,0					;a1: counter
	loop3:
		WAIT_MS		150
		rcall		LCD_display_right	;right-moving display
		subi		a1,-1
		cpi			a1,17				;end of screen
		brne		loop3
    rcall		LCD_clear
    pop			a1
    ret

;==============================================

open_display:
	rcall		LCD_clear
    PRINTF		LCD
	.db			"OPEN ",0
    ret

;===============================================

close_display:
    rcall		LCD_clear
    PRINTF		LCD
	.db			"CLOSE",0
    ret
