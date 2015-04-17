extern printf ; externe Funktion printf deklarieren

SECTION .data
	msg db 'Hello from asmfunc!',10,0 

SECTION .text

; oeffentliche Funktionen deklarieren
	global asmfunc

; Funktionen implementieren
asmfunc : 
	push ebp		; neuer Stackframe erzeugen
	mov ebp, esp

	push msg
	call printf
	add esp, 4

	; Rückgabewert auf 0 setzen
	mov eax, 0
	
	mov esp, ebp		; alter Stackframe restaurieren
	pop ebp 
	ret			; Ruecksprung zum Aufrufer
