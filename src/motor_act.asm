/*
 * motor_act.asm
 *
 *  Created: 28/05/2023 13:50:46
 *   Author: ismai
 */ 

.org 0x250
	
.macro CA3			;call a subroutine with three arguments in a1:a0 b0
	ldi			a0, low(@1)		;low byte impulse duration
	ldi			a1, high(@1)	;high byte impulse duration
	ldi			b0, @2			;impulse number
	rcall		@0
.endmacro
;===================================================================
motor_act:	

	mov			c3, motor_reg
	_ANDI		c3, 0b00000011			;select 2 first bits

	open:	
		_CPI		c3, wantToOpen		
		_BRNE		close
		rcall		open_display
		CA3			_s360, open_impulse, nbr_impulse	; opening (CW 180, high-speed)

		_LDI		c3, is_open		;we just opened			
		rjmp		exit

	close:	
		_CPI		c3, wantToClose
		_BRNE		exit
		rcall		close_display
		CA3			_s360, close_impulse, nbr_impulse	;closing (CCW 180, high-speed)

		_LDI		c3, is_closed		;we just closed	

	exit:
		MOVMSK		motor_reg,c3,0b00000011		;mov 2 first bits of c3 to motor_reg	
		rcall		LCD_clear
		ret
	
; _s360, in a1:a0, a2 out void, mod a2,w===========================
_s360:	

	ls3601:
		rcall		servoreg_pulse
		dec			b0
		brne		ls3601
		ret

; servoreg_pulse, in a1,a0, out servo port, mod a3,a2
; purpose generates pulse of length a1,a0
	servoreg_pulse:
		WAIT_US		20000
		MOV2		a3,a2, a1,a0
		P1			PORTB,SERVO1		; pin=1

	lpssp01:	
		SUBI2		a3,a2,0x1
		brne		lpssp01
		P0			PORTB,SERVO1		; pin=0
		ret