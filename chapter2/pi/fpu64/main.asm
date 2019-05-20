DEFAULT REL

extern printf ; externe Funktionen deklarieren

SECTION .data
	num_steps dq 1000000
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
	; Die 64bit ABI "empfiehlt" rbp nicht mehr für den Stackframe zu verwenden.
	; => Reduziert die Codegröße, mehr Allzweckregister
	; => Alles muss über rsp laufen
	;
	; Allerdings hilft der rbp beim Debuggen
	; => Wenn -- wie hier --  mit -g compiliert wird,
	;    sollte er wie üblich verwendet werden.
	push rbp	; neuer Stackframe erzeugen
	mov rbp, rsp

	; Die Register rbp, rsp, rbx, r12-r15 müssen nachdem
	; Verlassen der Funktion, die ursprüngliche Werte
	; beinhalten.
	; => rbx sichern
	push rbx

	xor rcx, rcx	; rcx = i = 0

	; calculate step = 1 / num_steps
	fld1            ; st0 = 1.0
	fild dword [num_steps]
	fdivp st1, st0
	fstp qword [step]
L1:
	cmp rcx, [num_steps]	; Abbruchbedingung überprüfen
	jge L2

	; Berechne (i+0.5f)*step
	fld qword [half]
	push rcx
	fild qword [rsp]
	add rsp, 8
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

	fld qword [sum]
	fmul qword [step]

	; Die ersten sechs Ganzzahlen oder Zeiger  werden über die Register
	; RDI, RSI, RDX, RCX, R8, and R9 übergeben.
	; => siehe auch fastcall unter 32bit
	;
	; Erst wenn mehr Argumente verwendet werden, wird auf den Stack zurückgegriffen.
	mov rdi,  msg

	; Für die Übergabe von Fließkommazahlen stehen xmm0 bis xmm7 zur Verfügung
        sub rsp, 8
        fstp qword [rsp]
        movsd xmm0, [rsp]
        add rsp, 8

	; Es muss garantiert werden, dass vor dem Funktionsaufruf
	; (hier call printf) der Stack auf einer 16Byte-Grenze endet.
	sub rsp, 8

	call printf

	; Rückgabewert von printf steht in rax

	; Puffer für das Alignment entfernen
	add rsp, 8

	; rbx restaurieren (s.o.)
	pop rbx

	; Die 64bit ABI "empfiehlt" rbp nicht mehr für den Stackframe zu verwenden.
	; => Reduziert die Codegröße, mehr Allzweckregister
	; => Alles muss über rsp laufen
	;
	; Allerdings hilft der RBP beim Debuggen
	; => Wenn -- wie hier --  mit -g compiliert wird,
	;    sollte er wie üblich verwendet werden.
	mov rsp, rbp	; alter Stackframe restaurieren
	pop rbp

	mov rax, 0
	ret
