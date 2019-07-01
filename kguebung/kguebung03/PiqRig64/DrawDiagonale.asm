;---------------------------------------------------------------------------------------------
; File: DrawDiagonale.asm
;
; Demo application for the exercise course "Grundgebiete der Informatik 4"
;
; Copyright (c) 2006-2013 Chair for Operating Systems, RWTH Aachen University
; Copyright (c) 2014-2015 Institute for Automation of Complex Power Systems,
;                         E.ON Energy Research Center, RWTH Aachen University
;
; All rights reserved.
;---------------------------------------------------------------------------------------------

DIAG_RED equ 0
DIAG_GREEN equ 0
DIAG_BLUE equ 0

;; Zeichne Diagonale
global DrawDiagonale

DrawDiagonale:
	push rbp
	mov rbp, rsp

	;
	; rette Register
	;
	push rbx

	;
	; Diese Schleife soll nun in Assembler implementiert werden:
	;
	; bei i=0 => bitmap[Startadr.] bis bitmap[Startadr.+2] wird auf 0 gesetzt
	; for(long i=0; i<height; i++) i=Zeile und Spalte, da diagonal
	; {
	;	i. Zeile u. i. Spalte waere offset = i*width + i,
	;	aber das ist nur fuer quadratische Bilder die Diagnole!
	;	fuer rechteckige Bilder, also i.Allg., muss das Verhaeltnis von
	;	Breite zu Hoehe (=width/height) beruecksichtigt werden!
	;	offset = i*width + i*width/height;
	;	offset *= 4;
	;	bitmap[offset +0] = DIAG_RED;
	;	bitmap[offset +1] = DIAG_GREEN;
	;	bitmap[offset +2] = DIAG_BLUE;
	; }

;;
;; STUDENTENCODE HIER EINFUEGEN
;;

	;
	; restauriere Register
	;
	pop rbx

	pop rbp
	ret ; return
