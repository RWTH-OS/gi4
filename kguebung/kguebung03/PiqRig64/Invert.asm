;---------------------------------------------------------------------------------------------
; File: Invert.asm
;
; Demo application for the exercise course "Grundgebiete der Informatik 4"
;
; Copyright (c) 2006-2013 Chair for Operating Systems, RWTH Aachen University
; Copyright (c) 2014-2015 Institute for Automation of Complex Power Systems,
;                         E.ON Energy Research Center, RWTH Aachen University
;
; All rights reserved.
;---------------------------------------------------------------------------------------------

;; Invertiert ein Bild
global Invert

Invert:
	push rbp ; enter
	mov rbp, rsp ; enter

	;
	; rette Register
	;
	push rbx
	; andere Register muessen nicht gesichert werden

	;
	; Diese Schleife soll nun in Assembler implementiert werden:
	; for(long i=0; i<height*width*4; i++)
	;     bitmap[i] = ~(bitmap[i]);

	; Es wird zwar mit 3 Bytes (R, G und B) gearbeitet, aber
	; es gibt ein viertes unbenutztes Byte in jedem Pixel
	; (dort kann ein Alpha-Channel-Wert gespeichert werden,
	;  was wir hier nicht benutzen.) - deswegen die Vierer-Faktoren.
  ;

;;
;; STUDENTENCODE HIER EINFUEGEN
;;

	;
	; restauriere Register
	;
	pop rbx

	pop rbp
	ret ; return
