.code
Problem3 proc
	mov r8, 1 ; prime candidate
	mov r9, 600851475143 ; value
	mov r11, 2 ; cached sqrt [floor(sqrt(candidate))]
	mov r12, 2 ; cached square [floor(sqrt(candidate))**2]

LoopHead:
	inc r8      ; go to next prime candidate
	cmp r8, r12 ; see if cached sqrt still applies
	jle NoSqrtIncrement ; candidate <= cached square
	inc r11
	mov rax, r11 ; put new sqrt in rax for mult
	mul r11      ; multiply cached sqrt with itself
	mov r12, rax ; store new cached square

NoSqrtIncrement:
	mov r10, 2  ; initialize div for prime check

	mov rax, r8 ; get candidate ready for division
	mov rdx, 0  ; clear for division
	div r10
	cmp rdx, 0  ; check if rem == 0
	je LoopHead ; candidate not prime, go to next
	inc r10     ; r10 = 3

PrimeCheckHead:
	mov rax, r8 ; get candidate ready for division
	mov rdx, 0  ; clear for division
	div r10
	cmp rdx, 0  ; check if rem == 0
	je LoopHead ; candidate not prime, go to next
	add r10, 2
	cmp r10, r11
	jl PrimeCheckHead ; div less than cached sqrt

	; is prime fall through
IsStillDivisible:
	mov rax, r9  ; move value to be divided
	mov rdx, 0   ; clear for division
	div r8
	cmp rdx, 0   ; check if rem == 0
	jne LoopHead ; no longer divisible
	mov r9, rax  ; make value new div result
	cmp r9, 1    ; check to see if we have reached 1
	jg IsStillDivisible ; greater than 1

	; loop fall through return
	mov rax, r8
	ret
Problem3 endp
end