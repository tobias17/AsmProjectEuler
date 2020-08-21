.code
Problem2 proc
	mov r8d, 1  ; first number in fib
	mov r9d, 1  ; second number in fib
	mov r11d, 0 ; summation register
	mov r12d, 2 ; constant for division

LoopHead:
	mov r10d, r9d ; save second fib number
	add r9d, r8d  ; comp next fib number
	mov r8d, r10d ; shift saved fib number

	mov r13d, 0   ; clear cmov reg
	mov eax, r9d ; load new fib number to be divided
	mov edx, 0    ; clear for division
	div r12d      ; divide by 2
	cmp edx, 0    ; check if mod 2 == 0
	cmove r13d, r9d
	add r11d, r13d

	cmp r9d, 4000000
	jl LoopHead

	; loop done fall through return
	mov eax, r11d
	ret
Problem2 endp
end