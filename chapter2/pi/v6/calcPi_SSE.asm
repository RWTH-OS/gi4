SECTION .text

extern step, sum,num_steps,four,two,one,ofs

global calcPi_SSE
global hasSSE2

; Mit cpuid kann überprüft werden, welche "Features" der Prozessor unterstützt.
; Bevor man Instruktionserweiterungen verwendet, sollte hiermit überprüft werden,
; ob diese vorhanden sind.
; Streng genommen muss vorher überprüft werden, ob die Instruktion "cpuid" vorhanden
; ist. Sie existiert erst seit 1993!
hasSSE2:
		push ebp
		mov ebp, esp

		; cpuid überschreibt eax, ebx, ecx, edx => ebx, ecx sichern
		push ebx
		push ecx

		; Beherrscht der Prozessor SSE2?
		mov eax, 1
		cpuid
		and edx, 5000000h
		cmp edx, 5000000h
		jne not_supported
		mov eax, 1
		jmp done
not_supported:
		mov eax, 0
done:
		mov edx, 0

		pop ecx
		pop ebx

		; ebp restaurieren
		pop ebp
		ret

calcPi_SSE:
		push ebp
		mov ebp, esp
	
		push ebx
		push ecx

		xor ecx, ecx       		; ecx = i = 0
		xorpd xmm0, xmm0   		; xmm0 stellt sum dar
		movsd xmm1, [step]		; initialisiere xmm1 mit step
		shufpd xmm1, xmm1, 0x0
		movapd xmm2, [ofs]		; initialisiere xmm2 mit (0.5, 1.5)

L1:
		cmp ecx, [num_steps]		; Abbruchbedingung überprüfen
		jge L2
		; Berechne (i+0.5f)*step
		movapd 	xmm4, xmm1
		mulpd 	xmm4, xmm2
		; Quadriere das Zwischenergebniss
		; und erhöhe um eins
		mulpd xmm4, xmm4
		addpd xmm4, [one]
		; teile 4 durch das Zwischenergebnis
		movapd	xmm3, [four]
		divpd 	xmm3, xmm4
		; Summiere die ermittelten Rechteckshöhen auf
		addpd xmm0, xmm3
		; Laufzähler erhöhen und
		; zum Schleifenanfang springen
		addpd xmm2, [two]
		add ecx, 2
		jmp L1
L2:
		xorpd xmm3,xmm3   ; xmm3 mit 0 initialisieren
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		; 1. Element von xmm0 durch das 2. ersetzen
		shufpd xmm0, xmm0, 0x1
		; 1. Element von xmm0 zu xmm3 addieren
		addsd xmm3, xmm0
		movsd [sum], xmm3 ; Ergebnis zurückkopieren

		pop ecx
		pop ebx

		; ebp restaurieren
		pop ebp
		ret 
