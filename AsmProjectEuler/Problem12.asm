.code
Problem12 proc
	mov r8, 1 ; counter "i"
	mov r9, 1 ; triangle number summation
MainLoopHead:
	inc r8     ; i++
	add r9, r8 ; triangle number += i

	; check divisibility
	mov r10, 1 ; divisor
	mov r11, 1 ; divisors count
DivisibilityHead:
	inc r10      ; increment divisor
	mov rdx, 0   ; clear for div
	mov rax, r9  ; load dividend
	div r10
	cmp rax, r10 ; is quotent < divisor
	jl DoneDividing ; if so, we are done dividing
	cmp rdx, 0 ; is rem != 0
	jne DivisibilityHead ; if so, keep searching
	inc r11 ; else increment divisors count
	jmp DivisibilityHead

DoneDividing:
	cmp r11, 250 ; is divisor count <= 250
	jle MainLoopHead ; if so, keep searching

	mov rax, r9
	ret
Problem12 endp
end