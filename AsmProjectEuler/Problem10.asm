.code
Problem10 proc
	push 2       ; push 2 onto the stack as first prime to jump-start algorithm
	mov r9, rsp  ; store where the base of the stack is
	push 3       ; 3 and 5 also have to get pushed for jump-start
	push 5       ; ^
	mov r10, 3   ; cached sqrt reg
	mov r11, 9   ; cached square reg
	mov r12, 5   ; loop counter reg (prime candidate)
	mov r15, 10  ; sum of primes less than 2 mil

MainLoopHead:
	add r12, 2 ; increment prime candidate
	cmp r12, 2000000 ; check if candidate > 2,000,000
	jg Ending ; if so, jump to ending

	; check to see if cache is still valid
	cmp r11, r12   ; is cached square >= i
	jge CacheValid ; if so, skip ahead
	; update cached sqrt and square reg
	inc r10	       ; increment sqrt
	mov rax, r10   ; move sqrt into rax
	mul r10        ; so we can square it
	mov r11, rax   ; and store result back in r11

	; cache is now valid, check if i is prime
CacheValid:
	mov r13, r9  ; grab stack base into counter
PrimeCheckHead:
	mov r14, [r13] ; fetch value "x" from stack
	cmp r14, r10   ; is x > cached sqrt
	jg IsPrime     ; if so, is prime

	mov rdx, 0   ; clear for division
	mov rax, r12 ; set divident
	div r14      ; divide by x
	cmp rdx, 0   ; is rem == 0
	je MainLoopHead ; if so, not prime

	; end of prime check loop
	sub r13, 8   ; increment stack base counter by 8
	jmp PrimeCheckHead
	
IsPrime:
	add r15, r12  ; add new prime to summation
	cmp r12, 1500 ; check if latest prime >= 1500  [sqrt(2 mil) = 1414]
	jge MainLoopHead ; if so, skip adding to stack

	; latest prime < 1500
	push r12 ; push new prime onto stack
	jmp MainLoopHead

Ending:
	; all primes summated, clean up and return
	mov rsp, r9  ; restore stack pointer
	pop r10      ; pop to finish stack pointer clean-up
	mov rax, r15
	ret
Problem10 endp
end