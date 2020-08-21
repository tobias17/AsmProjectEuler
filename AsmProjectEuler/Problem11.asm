.code
Problem11 proc
	mov r14, 0 ; largest value reg

	; horizontal
	mov r8, 0 ; "i" col counter
	mov r9, 0 ; "j" row counter
HorLoopHead:
	mov rax, 20 ; load for mult
	mul r8      ; rax = 20 * i
	add rax, r9 ; rax += j
	mov r10d, DWORD PTR [rcx+rax] ; load in values from mem
	mov r11d, DWORD PTR [rcx+rax+4]
	mov r12d, DWORD PTR [rcx+rax+8]
	mov r13d, DWORD PTR [rcx+rax+12]
	mov rax, r10 ; multiply them all together
	mul r11
	mul r12
	mul r13

	cmp rax, r14   ; is product > highest value
	cmovg r14, rax ; if so, replace it

	; end of inner loop
	add r9, 4
	cmp r9, 64 ; is j <= 64
	jle HorLoopHead

	; end of outer loop
	mov r9, 0
	add r8, 4
	cmp r8, 76 ; is i <= 76
	jle HorLoopHead


	; vertical
	mov r8, 0 ; "i" col counter
	mov r9, 0 ; "j" row counter
VerLoopHead:
	mov rax, 20 ; load for mult
	mul r8      ; rax = 20 * i
	add rax, r9 ; rax += j
	mov r10d, DWORD PTR [rcx+rax] ; load in values from mem
	mov r11d, DWORD PTR [rcx+rax+80]
	mov r12d, DWORD PTR [rcx+rax+160]
	mov r13d, DWORD PTR [rcx+rax+240]
	mov rax, r10 ; multiply them all together
	mul r11
	mul r12
	mul r13

	cmp rax, r14   ; is product > highest value
	cmovg r14, rax ; if so, replace it

	; end of inner loop
	add r9, 4
	cmp r9, 76 ; is j <= 76
	jle VerLoopHead

	; end of outer loop
	mov r9, 0
	add r8, 4
	cmp r8, 64 ; is i <= 64
	jle VerLoopHead


	; diagonal 1 \
	mov r8, 0 ; "i" col counter
	mov r9, 0 ; "j" row counter
Dia1LoopHead:
	mov rax, 20 ; load for mult
	mul r8      ; rax = 20 * i
	add rax, r9 ; rax += j
	mov r10d, DWORD PTR [rcx+rax] ; load in values from mem
	mov r11d, DWORD PTR [rcx+rax+84]
	mov r12d, DWORD PTR [rcx+rax+168]
	mov r13d, DWORD PTR [rcx+rax+252]
	mov rax, r10 ; multiply them all together
	mul r11
	mul r12
	mul r13

	cmp rax, r14   ; is product > highest value
	cmovg r14, rax ; if so, replace it

	; end of inner loop
	add r9, 4
	cmp r9, 64 ; is j <= 64
	jle Dia1LoopHead

	; end of outer loop
	mov r9, 0
	add r8, 4
	cmp r8, 64 ; is i <= 64
	jle Dia1LoopHead


	; diagonal 2 /
	mov r8, 0 ; "i" col counter
	mov r9, 12 ; "j" row counter
Dia2LoopHead:
	mov rax, 20 ; load for mult
	mul r8      ; rax = 20 * i
	add rax, r9 ; rax += j
	mov r10d, DWORD PTR [rcx+rax] ; load in values from mem
	mov r11d, DWORD PTR [rcx+rax+76]
	mov r12d, DWORD PTR [rcx+rax+152]
	mov r13d, DWORD PTR [rcx+rax+228]
	mov rax, r10 ; multiply them all together
	mul r11
	mul r12
	mul r13

	cmp rax, r14   ; is product > highest value
	cmovg r14, rax ; if so, replace it

	; end of inner loop
	add r9, 4
	cmp r9, 76 ; is j <= 76
	jle Dia2LoopHead

	; end of outer loop
	mov r9, 12
	add r8, 4
	cmp r8, 64 ; is i <= 64
	jle Dia2LoopHead


	mov rax, r14
	ret
Problem11 endp
end