DEFAULT REL

SECTION .text
	extern ofs, one, two, four, step
	global calcPi_SSE_thread

calcPi_SSE_thread:
	push rbp
	mov rbp, rsp

	; rdx = &sum
	; rsi = end
	; rdi = start

	mov rcx, rdi       ; int rcx = i = start
	xorpd xmm0, xmm0   ; xmm0 represents sum

	; initialize xmm1 with step
	movsd xmm1, [step]
	shufpd xmm1, xmm1, 0x0

	; intialize xmm2 with the start vector (0.5+start, 1.5+start)
	xorps xmm2, xmm2           ; set xmm2[0-1] to 0
	cvtsi2ss xmm2, rdi         ; load the integer "start" as float into xmm2[0]
	shufpd xmm2, xmm2, 0x0     ; scatter the value of start over the whole regsiter xmm2
                                   ; => xmm2[0] = xmm2[1] = start
	addpd xmm2, [ofs]          ; add the vector (0.5, 1.5)
L1:
	cmp rcx, rsi
	jge L2
	; x4 = (i+0.5)*step;
	movapd xmm4, xmm1
	mulpd xmm4, xmm2

	; x4 = x4*x4 + 1.0
	mulpd xmm4, xmm4
	addpd xmm4, [one]

	; x3 = 4.0 / x4
	movapd xmm3, [four]
	divpd xmm3, xmm4

	; sum += x3
	addpd xmm0, xmm3
	addpd xmm2, [two]
	add rcx, 2
	jmp L1
L2:
	; sum = xmm0[0] + xmm0[1]
	xorpd xmm3, xmm3
	addsd xmm3, xmm0
	shufpd xmm0, xmm0, 0x1
	addsd xmm3, xmm0

	; copy result to the memory
	movsd [rdx], xmm3

	pop rbp
	ret
