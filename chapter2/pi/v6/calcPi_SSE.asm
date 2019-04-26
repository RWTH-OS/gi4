SECTION .text

extern step, sum,num_steps,four,two,one,ofs

global calcPi_SSE
global hasSSE2

; Mit cpuid kann �berpr�ft werden, welche "Features" der Prozessor unterst�tzt.
; Bevor man Instruktionserweiterungen verwendet, sollte hiermit �berpr�ft werden,
; ob diese vorhanden sind.
; Streng genommen muss vorher �berpr�ft werden, ob die Instruktion "cpuid" vorhanden
; ist. Sie existiert erst seit 1993!
hasSSE2:
		push rbp
		mov rbp, rsp

		; cpuid �berschreibt rax, rbx, rcx, rdx => rbx, rcx sichern
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
		movsd xmm1, [rel step]		; initialisiere xmm1 mit step
		shufpd xmm1, xmm1, 0x0
		movapd xmm2, [rel ofs]		; initialisiere xmm2 mit (0.5, 1.5)

L1:
		cmp rcx, [rel num_steps]		; Abbruchbedingung �berpr�fen
		jge L2
		; Berechne (i+0.5f)*step
		movapd 	xmm4, xmm1
		mulpd 	xmm4, xmm2
		; Quadriere das Zwischenergebniss
		; und erh�he um eins
		mulpd xmm4, xmm4
		addpd xmm4, [rel one]
		; teile 4 durch das Zwischenergebnis
		movapd	xmm3, [rel four]
		divpd 	xmm3, xmm4
		; Summiere die ermittelten Rechtecksh�hen auf
		addpd xmm0, xmm3
		; Laufz�hler erh�hen und
		; zum Schleifenanfang springen
		addpd xmm2, [rel two]
		add rcx, 2
		jmp L1
L2:
		xorpd xmm3,xmm3   ; xmm3 mit 0 initialisieren
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		; 1. Element von xmm0 durch das 2. ersetzen
		shufpd xmm0, xmm0, 0x1
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		movsd [rel sum], xmm3 ; Ergebnis zur�ckkopieren

		pop rcx
		pop rbx

		; rbp restaurieren
		pop rbp
		ret 
