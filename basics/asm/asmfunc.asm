DEFAULT REL

extern printf ; forward declaration of printf

SECTION .data
	msg db 'Hello from asmfunc!', 10, 0

SECTION .text

; oeffentliche Funktionen deklarieren
	global asmfunc

; Funktionen implementieren
asmfunc:
	push rbp			; neuer Stackframe erzeugen
	mov rbp, rsp

	mov rdi, msg
	call printf

	; set return value to 0
	mov rax, 0

	mov rsp, rbp	; alter Stackframe restaurieren
	pop rbp
	ret				; zurueck zum Aufrufer
