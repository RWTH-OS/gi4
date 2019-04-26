DEFAULT REL

SECTION .text

extern step, sum, num_steps, four, two, one, ofs

global calcPi_SSE
global hasSSE2

; Mit cpuid kann ueberprueft werden, welche "Features" der Prozessor unterstuetzt.
; Bevor man Instruktionserweiterungen verwendet, sollte hiermit ueberprueft werden,
; ob diese vorhanden sind.
; Streng genommen muss vorher ueberprueft werden, ob die Instruktion "cpuid" vorhanden
; ist. Sie existiert erst seit 1993!
hasSSE2:
		push rbp
		mov rbp, rsp

		; cpuid ueberschreibt rax, rbx, rcx, rdx => rbx, rcx sichern
		push rbx
		push rcx

		; Beherrscht der Prozessor SSE2?
		mov rax, 1
		cpuid
		and rdx, 5000000h
		cmp rdx, 5000000h
		jne not_supported
		mov rax, 1
		jmp done
not_supported:
		mov rax, 0
done:
		mov rdx, 0

		pop rcx
		pop rbx

		; rbp restaurieren
		pop rbp
		ret

calcPi_SSE:
		push rbp
		mov rbp, rsp
	
		push rbx
		push rcx

		xor rcx, rcx       		; rcx = i = 0
		xorpd xmm0, xmm0   		; xmm0 stellt sum dar
		movsd xmm1, [step]		; initialisiere xmm1 mit step
		shufpd xmm1, xmm1, 0x0
		movapd xmm2, [ofs]		; initialisiere xmm2 mit (0.5, 1.5)

L1:
		cmp rcx, [num_steps]		; Abbruchbedingung ueberpruefen
		jge L2
		; Berechne (i+0.5f)*step
		movapd 	xmm4, xmm1
		mulpd 	xmm4, xmm2
		; Quadriere das Zwischenergebniss
		; und erhoehe um eins
		mulpd xmm4, xmm4
		addpd xmm4, [one]
		; teile 4 durch das Zwischenergebnis
		movapd	xmm3, [four]
		divpd 	xmm3, xmm4
		; Summiere die ermittelten Rechteckshoehen auf
		addpd xmm0, xmm3
		; Laufzaehler erhoehen und
		; zum Schleifenanfang springen
		addpd xmm2, [two]
		add rcx, 2
		jmp L1
L2:
		xorpd xmm3, xmm3   ; xmm3 mit 0 initialisieren
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		; 1. Element von xmm0 durch das 2. ersetzen
		shufpd xmm0, xmm0, 0x1
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		movsd [sum], xmm3 ; Ergebnis zurueckkopieren

		pop rcx
		pop rbx

		; rbp restaurieren
		pop rbp
		ret 
