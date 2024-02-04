/*
 * distance.asm
 *
 *  Created: 29/05/2023 14:18:28
 *   Author: ismai
 */ 

 .macro	CPI2	; compare 2byte register with constant
		clc
		cpi		@1, low(@2)
		ldi		w, high(@2)
		cpc		@0, w
		.endmacro

 read_dist:
 	clr 		r23
    sbi 		ADCSR, ADSC				;start converting
    WB0 		r23,0					;wait for sémaphore (r23=1)
    in			b0,ADCL					;read lower byte
    in			b1,ADCH					;read higher byte
 	rcall		dist_action
 	ret

dist_action:
	CPI2		b1,b0, threshold	;carry=1 means far from door 
	C2B			motor_reg, 0		;carry to bit 0 of motor_reg
  	rcall		motor_act
	ret