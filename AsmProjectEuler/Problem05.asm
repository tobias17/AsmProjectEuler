.code
Problem5 proc
	; This problem can be done entirely arithmetically, not programmatically
	; Start by taking all of the numbers are breaking them down to prime factorization
	; 20 = 5^1 * 2^2
	; 19 = 19^1
	; 18 = 3^2 * 2^1
	; 17 = 17^1
	; 16 = 2^4
	; 15 = 5^1 * 3^1
	; 14 = 7^1 * 2^1
	; 13 = 13^1
	; 12 = 3^1 * 2^2
	; 11 = 11^1
	; (list 1-10 is redundant, as all are subsets of 11-20)
	; Taking all of the prime factors and combining them together, keeping the higher exponent
	; one when the bases are the same, we get
	; 19 * 17 * 13 * 11 * 7 * 5 * 3^2 * 2^4
	; And now we get to calculate the result! :)

	; go on multiplication spree
	mov rax, 19
	mov r8, 17
	mul r8
	mov r8, 13
	mul r8
	mov r8, 11
	mul r8
	mov r8, 7
	mul r8
	mov r8, 5
	mul r8
	mov r8, 3
	mul r8
	mul r8
	mov r8, 2
	mul r8
	mul r8
	mul r8
	mul r8
	ret
Problem5 endp
end