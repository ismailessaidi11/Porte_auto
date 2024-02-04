/*
 * main_prog.asm
 *
 *  Created: 28/05/2023 13:50:24
 *   Author: ismai
 */ 
;=================MACROS & DEFINITIONS==================
 .include "macros.asm"
 .include "definitions.asm"
 .include "my_definitions.asm"

;================INTERRUPT VECTOR TABLE===================
.cseg
 .org 0
	jmp reset

.org INT7addr
    jmp ext_int7

.org ADCCaddr
	jmp	ADCCaddr_sra

;=================INTERRUPT ROUTINES===========================
.org 0x45
ext_int7:
    in			_sreg, SREG
	CLR2		b1,b0		;clear 2-byte register
	ldi			b2,14		;load bit counter 
	WAIT_US		(T1/4)		;wait a quarter period
    rcall		read_IR
	rcall		IR_action
    out			SREG, _sreg
    reti
	
ADCCaddr_sra:
    in			_sreg, SREG
	ldi			r23,0x01			;sémaphore
    out			SREG, _sreg
	reti

;========================INITIALISATION====================

reset:
	LDSP		RAMEND
	OUTI		DDRB, 0xFF
	OUTI		DDRE, 0x7F

	;init CAD
	OUTI		ADCSR, (1<<ADEN)+(1<<ADIE)+6		
	OUTI		ADMUX, (1<<MUX1)+(1<<MUX0)

	;init moteur
    P0			PORTB,SERVO1   			 
    LDI2		a1,a0,close_impulse
	ldi			motor_reg, wantToClose				;init moteur to wantToClose

	;welcome/reset
	rcall		LCD_init				;init LCD
	rcall		welcome_music
	rcall		welcome_display			
	rcall		motor_act				;close motor

	;interrupt setup for IR
    OUTI		EIMSK,(1<<INT7)  		;enable int7
    OUTI		EICRB, 0x00  			;INT7 level 0
	sei

	rjmp		main
;================================================================
.include "lcd.asm"
.include "printf.asm"
.include "sound.asm"	
.include "display.asm"
.include "motor_act.asm"
.include "music.asm"
.include "IR.asm"
.include "distance.asm"
;=========================MAIN CODE==============================
main:
	cpi			motor_reg, mode			
	brsh		PC+2					;same or higher means manual mode
   	rcall		read_dist
   	rjmp		main




