; purpose: print hello world 
; input: none
; output: hello world

global _start 

section .data

value db 9
message db "Hello Cyber Punk World!",0xd, 0xa
new_line db 0xa

section .bss

index resb 1 
ascii_value resb 1

section .text


_start:
	; loads a pointer
	mov eax, value 
	mov bl, BYTE [eax] 
	lea ecx, DWORD [eax]

	; print the message in the stdout
	mov eax, 4
	mov ebx, 1
	mov ecx, message
	mov edx, 26
	int 0x80

	; prints the number(0-9) in the address value
	mov eax, value
	mov bl, byte [eax]
	add bl, 0x30
	mov eax, ascii_value
	mov byte [ascii_value], bl

	mov eax, 4
	mov ebx, 0x1
	mov ecx, ascii_value
	mov edx, 1
	int 0x80

	; prints a new line
	mov eax, 4
	mov ebx, 0x1
	mov ecx, new_line  
	mov edx, 1
	int 0x80

	; close the program 
	mov eax, 1
	mov ebx, 0
	int 0x80
