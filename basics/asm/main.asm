extern asmfunc ; externe Funktionen deklarieren

SECTION .data
	; no data

SECTION .text

%ifidn __OUTPUT_FORMAT__, macho64
; oeffentliche Functionen deklarieren
global _main

; Funktionen implementieren
_main:
%else
; oeffentliche Functionen deklarieren
global main

; Funktionen implementieren
main:
%endif
	push rbp	; neuer Stackframe erzeugen
	mov rbp, rsp

	; Diese Datei kann als Vorlage für die
	; Entwicklung von Assembler-Programmen
	; verwendet werden. Hierzu muss die nächste
	; Zeile nur durch den gewünschten Code
	; ersetzt werden.
	call asmfunc

	pop rbp     ; alter Stackframe restaurieren	

	; Programm verlassen & signalisieren,
	; dass bei bei der Ausführung kein Fehler
	; aufgetreten ist.
	mov rax, 0
	ret
