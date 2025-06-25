
global _start

_start:

section .data

values db 10, 20, 30, 40
text_greetings db "Hello humans!",0xa, 0xd
size_text_greetings EQU $-text_greetings
section .bss

n resb 10

section .text


	mov rax, 1
	mov rdi, 1
	mov rsi, text_greetings
	mov rdx, size_text_greetings
	syscall

	mov rax, 60
	mov rdi, 0
	syscall