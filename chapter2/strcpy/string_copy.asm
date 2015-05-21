SECTION .text
  global string_copy

string_copy: 
  push ebp
  mov ebp,esp
  xor ecx,ecx
  xor edx,edx	

	;aufrunf in main >> string_copy(string,"Hallo Welt");
	; stack >> 
	;		* auf hallo welt >> ebp+12
	;		* auf string	 >> ebp+ 8
	;		RA		 >> ebp+ 4
	;///////////////////////////////////////////////////

	mov edi, [ebp+12] ;// neue werte
	mov esi, [ebp+8]  ;// alte werte
	
L1:	
	mov dl, [edi+ecx]
	mov [esi+ecx],dl	
	cmp dl,0
	je ende
	inc ecx
	jmp L1

ende:
  pop ebp
  ret
