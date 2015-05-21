SECTION .data
	; no data

SECTION .text

; declare main as public
	global main

maximum:
	push ebp		; save old ebp
	mov ebp, esp		; create new ebp 

	sub esp, 4		; create local var j
	mov eax, [ebp+8]	; load 42 in eax
	mov [ebp-4], eax	; mov 42 to j
	mov eax, [ebp+12]	; load 2 in eax 
	cmp eax, [ebp-4]	; compare 2 with j
	jl  change		; jump below to change, 
	mov [ebp-4], eax	; if not then move eax to j 

change: 
	mov eax, [ebp-4]	; mov j to eax 

        
	add esp, 4		; destroy local var j
	pop ebp			; restore ebp
	ret			; jump back to addr before function was called

; entry point
main:
	push ebp		; create new stack frame
	mov ebp, esp

	push 2
	push 42
	call maximum
	add esp, 8

	mov esp, ebp		; restore old stack frame
	pop ebp	

	; leave program and forward maximum's result
	; to the shell
	mov ebx, eax
	mov eax, 1
	int 0x80
