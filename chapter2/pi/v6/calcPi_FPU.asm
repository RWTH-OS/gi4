DEFAULT REL

SECTION .data
	half dq 0.5  ; declare quad word (double precision)

SECTION .text

extern step, sum, num_steps, four

global calcPi_FPU

calcPi_FPU:
	push rbp	; neuer Stackframe erzeugen
	mov rbp, rsp

	push rbx
	push rcx

	xor rcx, rcx	; rcx = i = 0

L1:
	cmp rcx, [num_steps]	; Abbruchbedingung überprüfen
	jge L2

	; Berechne (i+0.5f)*step
	fld qword [half]
	push rcx
	fild dword [rsp]
	add rsp, 4
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

	inc rcx
	jmp L1
L2:

	pop rcx
	pop rbx

	mov rsp, rbp	; alter Stackframe restaurieren
	pop rbp

	ret
