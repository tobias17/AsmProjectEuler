.code
Problem8 proc
	mov r8, -4 ; array indexing counter
	;   r9       loaded value reg
	mov r11, 0 ; highest value
	mov r12, 0 ; values since last 0

	mov rax, 1 ; reset for mult
LoopHead:
	add r8, 4    ; i += 4
	cmp r8, 4000 ; is i >= 4000 (1000 ints)
	jge Ending   ; if so, break to ending

	mov r9d, DWORD PTR [rcx+r8] ; load in new value from array
	cmp r9, 0   ; is new value == 0
	je ZeroValue ; if so, reset

	; non-zero value
	inc r12      ; inc values since last 0
	mul r9       ; multiply by new value

	cmp r12, 13  ; check values since last 0
	jl LoopHead  ; less than, not ready to check
	je CheckIfLarger ; equal, no division needed

	; divide out 13 indexes ago
	mov r9d, DWORD PTR [rcx+r8-52] ; load in new value from array
	mov rdx, 0 ; clear for division
	div r9

CheckIfLarger:
	cmp rax, r11   ; is new product > r11
	cmovg r11, rax ; if so, replace it
	jmp LoopHead

ZeroValue:
	mov r12, 0 ; reset values since last 0
	mov rax, 1 ; reset product reg
	jmp LoopHead


Ending:
	mov rax, r11
	ret

Problem8 endp
end