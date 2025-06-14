; purpose: print hello world 
; input: none
; output: hello world

global _start 

section .data

value db 7 
message db "Hello World!",0xa,0
new_line db 0xa

section .bss

index resb 1 

section .text


_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, message
	mov edx, 14
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, new_line
	mov edx, 1
	int 0x80

	mov eax, 1
	mov ebx, -1
	int 0x80
