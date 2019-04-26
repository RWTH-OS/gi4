SECTION .text
  global string_copy

string_copy: 
  push rbp
  mov rbp, rsp
  xor rcx, rcx
  xor rdx, rdx

  ; aufruf in main >> string_copy(string, "Hallo Welt");
  ; stack >>
  ;		RA	>> rbp+8
  ; rdi >> 1. Argument
  ; rsi >> 2. Argument
  ;///////////////////////////////////////////////////

L1:	
  mov dl, [rsi+rcx]
  mov [rdi+rcx], dl
  cmp dl, 0
  je ende
  inc rcx
  jmp L1

ende:
  pop rbp
  ret
