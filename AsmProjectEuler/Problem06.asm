.code
Problem6 proc
	mov r8, 0  ; sum of squares reg
	mov r9, 0  ; square of sum reg

	; sum of squares calc
	mov r10, 1 ; set loop counter
FirstLoopHead:
	mov rax, r10 ; put counter into rax
	mul r10      ; so we can square it
	add r8, rax  ; increment sum reg by square res

	inc r10
	cmp r10, 100	  ; check if loop counter <= 100
	jle FirstLoopHead ; if so, loop

	; first loop done, square of sum calc
	mov r10, 1 ; reset loop counter
SecondLoopHead:
	add r9, r10  ; increment sum reg by square res

	inc r10
	cmp r10, 100	   ; check if loop counter <= 100
	jle SecondLoopHead ; if so, loop

	; second loop done, square result
	mov rax, r9  ; put sum into rax
	mul r9       ; so we can square it

	sub rax, r8  ; subract the 2 calculations
	ret
Problem6 endp
end