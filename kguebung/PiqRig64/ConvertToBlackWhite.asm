;---------------------------------------------------------------------------------------------
; File: ConvertToBlackWhite.asm
;
; Demo application for the exercise course "Grundgebiete der Informatik 4"
;
; Copyright (c) 2006-2013 Chair for Operating Systems, RWTH Aachen University
; Copyright (c) 2014-2015 Institute for Automation of Complex Power Systems,
     ;                    E.ON Energy Research Center, RWTH Aachen University
;
; All rights reserved.
;---------------------------------------------------------------------------------------------

;; Konvertiere Bild in eine Schwarzweiss-Darstellung
global ConvertToBlackWhite

ConvertToBlackWhite:
	push rbp
	mov rbp, rsp

	sub rsp, 8 ; statt der lokalen Variable waere auch ein Register moeglich

	;
	; rette Register
	;
	push rbx

	;
	; Diese Schleife soll nun in Assembler implementiert werden:
	; for(long i=0; i<4*width*height; i+=4)
	; {
	;   Y = Grauwert des Pixels
	;	  bitmap[i] = bitmap[i+1] = bitmap[i+2] = (BYTE) Y;
	; }
	;   Grauwert = Luminanz des YCbCr Systems (auch YUV genannt)
	; 	Konvertierung RGB nach YUV nach CCIR601 (fuer Videos):
	;    Y = ( 0.257 * R + 0.504 * G + 0.098 * B + 16  ; 16 < Y < 235
	;    Y = ( (  66 * R +   129 * G +    25 * B + 128) >> 8) +  16 ; (Festkomma)
	;    Transformation nach JFIF (JPEG), hier besser, da ganzer Farbraum genutzt
	;    Y = 0.299 * R + 0.587 * G + 0.114 * B        ; 0 <= Y <= 255
	;    Y =(   76 * R +   150 * G +    29 * B)  >> 8 ; (Festkomma)
	;	Festkomma statt float ist schneller, moeglich ist Nutzung von
	;    "menschenlesbaren" Festkommazahlen wie x*0.299 = x*299/1000
	;
	;    Lieber sind dem Rechner allerdings Festkommazahlen auf binaer-Basis
	;    x*0.299 = x * (0.299*256) / 256 = x * 76 / 256
	;    da x / 256 = x >> 8
	; also definieren wir uns:

	R2Y equ 76
	G2Y equ 150
	B2Y equ 29

;;
;; STUDENTENCODE HIER EINFUEGEN
;;

	;
	; restauriere Register
	;
	pop rbx

	add rsp, 8 ; lokale Variable wegraeumen
	pop rbp
	ret ; return

; eof
