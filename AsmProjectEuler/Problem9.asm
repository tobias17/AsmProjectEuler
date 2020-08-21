.code
Problem9 proc
	mov r8, 1 ; "a" reg
	mov r9, 1 ; "b" reg
	;   r10     "c" reg
	
LoopHead:
	mov r10, 1000 ; c = 1000
	sub r10, r9   ; c -= b
	sub r10, r8   ; c -= a
	
	mov rax, r8  ; move a into rax for square
	mul r8       ; square a
	mov r11, rax ; store a^2 result in r11
	mov rax, r9  ; move b into rax for square
	mul r9       ; square b
	add r11, rax ; increment r11 by b^2

	mov rax, r10 ; move c into rax for square
	mul r10      ; square c
	cmp rax, r11 ; check if c^2 == a^2 + b^2
	je Ending    ; if so, found solution, jump to ending

	; end of inner loop
	inc r9
	cmp r9, 500 ; b < 500
	jl LoopHead ; if so, loop

	; end of outer loop
	inc r8      ; a++
	mov r9, r8  ; b = a
	inc r9      ; b++
	cmp r8, 333 ; a < 333
	jl LoopHead ; if so, loop

Ending:
	mov rax, r8 ; put a into rax for mult
	mul r9      ; a *= b
	mul r10     ; a *= c
	ret         ; return a
Problem9 endp
end