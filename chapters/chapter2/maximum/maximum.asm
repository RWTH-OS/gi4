SECTION .data
	; no data

SECTION .text

; declare main as public
global maximum

maximum:
	push rbp	; save old rbp
	mov rbp, rsp	; create new rbp

	mov rax, rdi	; load 1st argument
	cmp rdi, rsi	; compare both arguments
	jg  L1		; jump greater to L1
	mov rax, rsi    ; if not then move 2nd argument to rax
L1:

	pop rbp		; restore rbp
	ret		; jump back to addr before function was called
