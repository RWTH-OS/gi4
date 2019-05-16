; externe Funktion printf deklarieren
;
; ein _ muss bei macOS vor dem Namen
%ifidn __OUTPUT_FORMAT__, macho64
extern _printf
%else
extern printf ; externe Funktion printf deklarieren
%endif

SECTION .data
	msg db 'Hello from asmfunc!',10,0 

SECTION .text

; oeffentliche Funktionen deklarieren
	global asmfunc

; Funktionen implementieren
%ifidn __OUTPUT_FORMAT__, macho64
global _asmfunc
_asmfunc:
%else
asmfunc :
%endif
	push rbp		; neuer Stackframe erzeugen
	mov rbp, rsp

	mov rdi, msg

; ein _ muss bei macOS vor dem Namen
%ifidn __OUTPUT_FORMAT__, macho64
	call _printf
%else
	call printf
%endif

	; Rückgabewert auf 0 setzen
	mov eax, 0
	
	mov rsp, rbp		; alter Stackframe restaurieren
	pop rbp 
	ret			; Ruecksprung zum Aufrufer
