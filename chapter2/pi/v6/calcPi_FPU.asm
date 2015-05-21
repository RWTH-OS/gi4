SECTION .data
	half dq 0.5  ; declare quad word (double precision)

SECTION .text

extern step, sum, num_steps,four

global calcPi_FPU

calcPi_FPU:
	push ebp	; neuer Stackframe erzeugen
	mov ebp, esp

	push ebx
	push ecx

	xor ecx, ecx	; ecx = i = 0

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
	
	pop ecx
	pop ebx

	mov esp, ebp	; alter Stackframe restaurieren
	pop ebp	

	ret
