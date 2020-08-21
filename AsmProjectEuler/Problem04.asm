.code
Problem4 proc
	mov r8d, 999 ; holds first operand
	mov r9d, 999 ; holds second operand
	mov r10d, 0  ; answer reg
	mov r12d, 10 ; contand divisor

LoopHead:
	; main logic
	mov eax, r8d
	mul r9d
	cmp eax, 100000 ; check to see if result is 6 digit number
	jl LoopContinue ; if so, skip ahead

	cmp eax, r10d   ; check to see if result is greater than current answer
	jl LoopContinue ; if so, skip ahead

	; we have a 6 digit number less than current largest palindrome
	mov r11d, eax ; store the result of mult
	mov edx, 0    ; clear for div
	div r12d
	push rdx      ; push mod onto stack

	mov edx, 0    ; clear for div
	div r12d
	push rdx      ; push mod onto stack
	
	mov edx, 0    ; clear for div
	div r12d
	mov r13d, edx ; move mod to r13
	
	mov edx, 0    ; clear for div
	div r12d
	cmp edx, r13d ; see if 2 mods are equal
	jne Pop2      ; if not break
	
	mov edx, 0    ; clear for div
	div r12d
	pop r13       ; pop result from mod 10,000
	cmp edx, r13d ; see if 2 mods are equal
	jne Pop1      ; if not break
	
	mov edx, 0    ; clear for div
	div r12d
	pop r13       ; pop result from mod 100,000
	cmp edx, r13d ; see if 2 mods are equal
	jne LoopContinue ; if not break

	; number is a palindrome!
	mov r10d, r11d ; move new value into ans reg
	jmp LoopContinue

Pop2:
	pop r13
Pop1:
	pop r13
LoopContinue:
	; inner loop ending logic
	dec r9d
	cmp r9d, 100 ; check if inner loop finished
	jge LoopHead
	
	; outer loop ending logic
	mov r9d, 999  ; reset r9 counter
	dec r8d
	cmp r8d, 100 ; check if outer loop finished
	jge LoopHead

	; outer loop fallthrough
	mov eax, r10d
	ret
Problem4 endp
end