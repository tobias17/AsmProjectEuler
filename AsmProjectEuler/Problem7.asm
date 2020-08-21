.code
Problem7 proc
	mov r8, 3    ; prime counter reg (we give 1 for free)
	push 2       ; push 2 onto the stack as first prime to jump-start algorithm
	mov r9, rsp  ; store where the base of the stack is
	push 3       ; 3 and 5 also have to get pushed for jump-start
	push 5       ; ^
	mov r10, 3   ; cached sqrt reg
	mov r11, 9   ; cached square reg
	mov r12, 5   ; loop counter reg (prime candidate)

MainLoopHead:
	add r12, 2 ; increment prime candidate

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
	cmp r14, r10 ; is x > cached sqrt
	jg IsPrime   ; if so, is prime

	mov rdx, 0   ; clear for division
	mov rax, r12 ; set divident
	div r14      ; divide by x
	cmp rdx, 0   ; is rem == 0
	je MainLoopHead ; if so, not prime

	; end of prime check loop
	sub r13, 8   ; increment stack base counter by 8
	jmp PrimeCheckHead
	
IsPrime:
	push r12 ; push new prime onto stack
	inc r8   ; inc counter of total primes
	cmp r8, 10000 ; if prime count <= 10,000
	jle MainLoopHead ; keep getting primes

	; all primes collected, clean up and return
	pop rax     ; pop last prime into return reg
	mov rsp, r9 ; restore stack pointer
	pop r8      ; pop to finish stack pointer clean-up
	ret
Problem7 endp
end