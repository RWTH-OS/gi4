extern printf ; externe Funktionen deklarieren

SECTION .data
	num_steps dd 1000000
	half dq 0.5  ; declare quad word (double precision)
	four dq 4.0
	sum dq 0.0
	msg db "PI = %lf", 10, 13, 0

SECTION .bss
	step resq 1

SECTION .text

; oeffentliche Functionen deklarieren
	global main

; Funktionen implementieren
main:
	push ebp	; neuer Stackframe erzeugen
	mov ebp, esp

	push ebx
	push ecx

	xor ecx, ecx	; ecx = i = 0

	; calculate step = 1 / num_steps
	fld1            ; st0 = 1.0
	fild dword [num_steps]
	fdivp st1, st0
	fstp qword [step]
L1:
	cmp ecx, [num_steps]	; Abbruchbedingung überprüfen
	jge L2

	; Berechne (i+0.5f)*step
	fld qword [half]
	push ecx
	fild dword [esp]
	add esp, 4
	faddp st1, st0    ; st1 = i + 0.5, pop st0
	fmul qword [step]

	; Quadriere das Zwischenergebnis
        ; und es erhöhe um eins
	fmul st0, st0
	fld1              ; st0 = 1.0
	faddp st1, st0

	; teile 4 durch das Zwischenergebnis
	fdivr qword [four]

	; Aufsummieren
	fadd qword [sum]
	fstp qword [sum]

	inc ecx
	jmp L1
L2:

	fld qword [sum]
	fmul qword [step]
	sub esp, 8
	fstp qword [esp]
	push msg
	call printf
	add esp, 12

	pop ecx
	pop ebx

	mov esp, ebp	; alter Stackframe restaurieren
	pop ebp

	; Programm verlassen & signalisieren,
	; dass bei bei der Ausführung kein Fehler
	; aufgetreten ist.
	mov ebx, 0
	mov eax, 1
	int 0x80
