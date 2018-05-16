#include <p16f628a.inc>
	__config _MCLRE_ON & _LVP_OFF & _BODEN_OFF & _CP_OFF & _WDT_OFF & _HS_OSC
	
	#define bank0 BCF STATUS,RP0
	#define bank1 BSF STATUS,RP0
	
	#define LED PORTA,RA1
	
	CBLOCK 0x20
		conter0,conter1
	ENDC
	
	org 0x0000
	goto inicio
	org 0x0004
	retfie
	
	inicio:
		bank1
		BCF TRISA,RA1 ;; definido como output
		bank0
		dnv:BSF LED
		call delay
		BCF LED
		call delay
		goto dnv
	delay:
		movlw .255
		movwf conter0
		movwf conter1
		
	aux:
		decfsz conter0
		goto aux
		decfsz conter1
		goto aux
		return
	END