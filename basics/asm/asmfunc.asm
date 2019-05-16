%ifidn __OUTPUT_FORMAT__, macho64
extern _printf ; forward declaration of printf
%else
extern printf ; forward declaration of printf
%endif

SECTION .data
	msg db 'Hello from asmfunc!',10,0 

SECTION .text

; oeffentliche Funktionen deklarieren
	global asmfunc

; Funktionen implementieren
asmfunc: 
	push rbp			; neuer Stackframe erzeugen
	mov rbp, rsp

	mov rdi, msg
%ifidn __OUTPUT_FORMAT__, macho64
	call _printf
%else
	call printf
%endif

	; set return value to 0
	mov rax, 0
	
	mov rsp, rbp	; alter Stackframe restaurieren
	pop rbp 
	ret				; zurueck zum Aufrufer
