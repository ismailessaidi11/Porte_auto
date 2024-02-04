/*
 * my_definitions.asm
 *
 *  Created: 21/05/2023 19:10:48
 *   Author: ismai
 */ 
 
 .equ   door_ctrl = 0xfd			;open/close door command
 .equ	mode_crtl = 0xfa			;switch mode command
 .equ   reset_ctrl = 0xf3			;reset command
 .equ   threshold = 300				;distance treshold
 .equ   T1 = 1778   				;bit period RC5
 .equ	close_impulse = 2400		;angle = 0°
 .equ	open_impulse = 500			;angle = 180°
 .equ	nbr_impulse = 0x4B			;number of impulses in motor_act
 .def	motor_reg =	r29
 .equ	mode = 0x04					;manual node in motor_reg
 .equ	wantToOpen = 0x00			;open code for motor_reg
 .equ	is_open = 0x02				;is_open code for motor_reg 
 .equ	is_closed = 0x01			;is_closed code for motor_reg
 .equ	wantToClose = 0x03			;close code for motor_reg
