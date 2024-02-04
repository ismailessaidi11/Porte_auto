/*
 * IR.asm
 *
 *  Created: 29/05/2023 14:11:13
 *   Author: ismai
 */ 
 read_IR:	
	P2C			PINE, IR	;move Pin to Carry
	ROL2		b1, b0		;roll carry into 2-byte reg
	WAIT_US		(T1-4)		;wait bit period - compensation
	DJNZ		b2, read_IR	;Decrement and jump if not zero
	ret


 IR_action:

   	com			b0						;car on échantillonne à T1/4

	decode_crtl:
		cpi			b0, reset_ctrl		
		_BREQ		reset
		cpi			b0, mode_crtl		
		breq		mode_act
		cpi			b0, door_ctrl		
		breq		decode_act
		rjmp		exitIR

	mode_act:
		_EORI		motor_reg, mode		;toggle mode (manual/auto)
		rcall		mode_sound			;sound of changing modes

		display_decode:
			cpi			motor_reg, mode			
			brsh		PC+3					;same or higher means manual mode
			rcall		automatic_display
			rjmp		PC+2
			rcall		manual_display
		ret

	decode_act:
		cpi			motor_reg, is_open + mode			;is_open + 0x04 
		brne		PC+2
		ldi			motor_reg, wantToClose + mode		;wantToClose + 0x04

		cpi			motor_reg, is_closed + mode			;is_closed + 0x04
		brne		PC+2
		ldi			motor_reg, wantToOpen + mode		;wantToOpen + 0x04
  	
	rcall		motor_act
   	ret
	 
	exitIR:
  		ret
