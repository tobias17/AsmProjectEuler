.code
Problem13 proc
	mov r8, 196	; index counter [true index * 4]
	mov r9, 10000000000	; value mult const
	mov r10, 0	; accumulation reg
	mov r11, 0	; asnwer reg
	mov r13, 10	; div const

OuterLoopHead:
InnerLoopHead:
	mov r12d, DWORD PTR [rcx+r8] ; load value from mem
	add r10, r12 ; accumulator += value
	add r8, 200 ; index += 50

	; if (index < 5,000) { keep looping }
	cmp r8, 20000
	jl InnerLoopHead
	; else

	; answer reg += accumulation reg * 10^10
	; answer reg /= 10
	mov rax, r10
	mul r9
	add rax, r11
	div r13 ; rdx should be clear from prev mult
	mov r11, rax
	
	sub r8, 20004 ; reset index back to first row, 1 column left

	; if (index < 0) { GOTO Ending }
	cmp r8, 0
	jl Ending
	; else

	mov r10, 0 ; reset accumulation reg
	jmp OuterLoopHead ; loop

Ending:
	mov rax, r11
AnswerTooBig:
	; if (rax < 10^10) { return }
	cmp rax, r9
	jl Return
	; else { rax /= 10, loop }
	mov rdx, 0
	div r13
	jmp AnswerTooBig
Return:
	ret
Problem13 endp
end