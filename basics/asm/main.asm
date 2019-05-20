DEFAULT REL

extern asmfunc ; externe Funktionen deklarieren

SECTION .data
	; no data

SECTION .text

; oeffentliche Functionen deklarieren
global main

; Funktionen implementieren
main:
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
