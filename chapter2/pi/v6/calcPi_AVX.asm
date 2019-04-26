DEFAULT REL

SECTION .text

extern step, sum, num_steps, four, two, one, ofs

global calcPi_AVX
global hasAVX

; Mit cpuid kann überprüft werden, welche "Features" der Prozessor unterstützt.
; Bevor man Instruktionserweiterungen verwendet, sollte hiermit überprüft werden,
; ob diese vorhanden sind.
; Streng genommen muss vorher überprüft werden, ob die Instruktion "cpuid" vorhanden
; ist. Sie existiert erst seit 1993!
hasAVX:
		push rbp
		mov rbp, rsp

		; cpuid überschreibt rax, rbx, rcx, rdx => rbx, rcx sichern
		push rbx
		push rcx

		; Beherrscht der Prozessor beherrscht AVX?
		; Verwendet das OS XASVE und XRSTOR?
		mov rax, 1
		cpuid
		and rcx, 18000000h ; prüfe bit 27 (OS uses XSAVE/XRSTOR)
		cmp rcx, 18000000h ; und 28 (AVX supported by CPU)
		jne not_supported

		; Unterstützt das OS AVX?
		xor rcx, rcx
		xgetbv
		and rax, 110b
		cmp rax, 110b ; Werden die AVX-Registern bei einem Kontextwechsel gesichert?
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

calcPi_AVX:
		push rbp
		mov rbp, rsp
	
		push rbx
		push rcx

		xor rcx, rcx       		; rcx = i = 0
		vxorpd ymm0, ymm0, ymm0   	; ymm0 stellt sum dar
		vbroadcastsd ymm1, [step] 	; initialisiere ymm1 mit step
		vmovapd ymm2, [ofs]		; initialisiere ymm2 mit (0.5, 1.5, 2.5, 3.5)
		vmovapd ymm3, [four] 		; initialisiere ymm3 mit (4.0, 4.0, 4.0, 4.0)

L1:
		cmp rcx, [num_steps]		; Abbruchbedingung überprüfen
		jge L2
		; Berechne (i+0.5)*step
		vmulpd 	ymm4, ymm1, ymm2
		; Quadriere das Zwischenergebniss
		; und erhöhe um eins
		vmulpd ymm4, ymm4, ymm4
		vaddpd ymm4, ymm4, [one]
%if 1
		; teile 4 durch das Zwischenergebnis
		vdivpd 	ymm4, ymm3, ymm4
%else
		; vdivpd ist extrem langsam
		; Idee: Approximiere den Reziprokwert und
		; verfeinere die Loesung mit den Newton-Raphson Verfahren
		vmovapd ymm5, ymm4
		vmovapd ymm6, ymm4
		vcvtpd2ps xmm4, ymm5            ; Konvertiere in einfache Genauigkeit
		vrcpps    xmm4, xmm4		; Approximiere den Reziprokwert (Genauigkeit 2^-12)
		vcvtps2pd ymm4, xmm4		; Konvertiere nun wieder zurück
		; Newton-Raphson Verfahren anwenden, um eine genaueres Ergebnis zu haben
		; x1 = x0 * (2 - d * x0) = 2 * x0 - d * x0 * x0;
		vmulpd   ymm5, ymm4
		vmulpd   ymm5, ymm4
		vaddpd   ymm4, ymm4
		vsubpd   ymm4, ymm5
		; Die Genauigkeit ist nun 2^-23
		; => noch eine Iteration, um eine doppelte Genauigkeit (nach IEEE) 
		; zu erzielen.
		vmulpd   ymm6, ymm4
		vmulpd   ymm6, ymm4
		vaddpd   ymm4, ymm4
		vsubpd   ymm4, ymm6
		; mit 4 multiplizieren
		vmulpd   ymm4, ymm3
%endif 
		; Summiere die ermittelten Rechteckshöhen auf
		vaddpd ymm0, ymm0, ymm4
		; Laufzähler erhöhen und
		; zum Schleifenanfang springen
		vaddpd ymm2, ymm2, ymm3
		add rcx, 4
		jmp L1
L2:
		vperm2f128 ymm3, ymm0, ymm0, 0x1 ; tausche die niedrigen mit den höheren 128 Bits
		vaddpd ymm3, ymm3, ymm0  ; implizit werden die oberen mit den niedrigen 128 Bits addiert
		vhaddpd ymm3, ymm3, ymm3 ; die unteren beiden Zahlen addiert
		vmovsd [sum], xmm3 ; Ergebnis zurückkopieren

		pop rcx
		pop rbx

		; rbp restaurieren
		pop rbp
		ret 
