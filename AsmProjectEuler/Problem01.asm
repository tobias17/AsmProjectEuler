.code
Problem1 proc
	mov r8d, 0 ; r8 is sum register
	mov r9d, 1 ; r9 is loop counter
	mov r10d, 3 ; constant for division
	mov r11d, 5 ; constant for division

LoopHead:
	
	mov r12d, 0 ; clear cmov reg

	mov eax, r9d ; move i to be divided
	mov edx, 0 ; clear d for division
	div r10d ; divide by 3
	cmp edx, 0
	cmove r12d, r9d
	mov eax, r9d ; move i to be divided
	mov edx, 0 ; clear d for division
	div r11d ; divide by 5
	cmp edx, 0
	cmove r12d, r9d
	add r8d, r12d ; increment by cmov ref

	; end of loop management
	inc r9d
	cmp r9d, 1000
	jne LoopHead

	; finished fallthrough, return value
	mov eax, r8d
	ret
Problem1 endp
end