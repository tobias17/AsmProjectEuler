extern malloc: proc

.data
STACK_BASE QWORD 0

.code
Problem14 proc
	push rcx

	; r8 = int* -> int[1 mil]
	mov rcx, 4000000
	call malloc
	mov r8, rax

	; for (i in range(1 mil)) { array[i] = 0 }
	mov r9, 0
InitLoopHead:
	mov DWORD PTR [r8+r9], 0
	add r9, 4
	cmp r9, 4000000
	jl InitLoopHead



	mov [STACK_BASE], rsp

	mov DWORD PTR [r8], 1 ; set chain from 1 = to 1
	mov r9, 0	; index counter
	mov r10, 0	; max value reg
	mov r13, 2	; const for mod div
	mov r14, 3	; const for mult
	mov r15, 4	; const for mult
MainLoopHead:
	; if (++index >= 1000000) { GOTO Ending }
	inc r9
	cmp r9, 1000000
	jge Ending
	; else

	; if (array[index * 4] != 0) { Skip this loop iteration }
	mov rax, r9
	mul r15
	mov ecx, [r8+rax]
	cmp ecx, 0
	jne MainLoopHead
	; else

	mov r11, r9	; load index in to working reg
	inc r11		; increment to go from index to value

InnerLoopHead:
	push r11 ; push the value onto the stack

	; rdx = value % 2
	mov rax, r11
	mov rdx, 0
	div r13

	; if (rdx == 0) { GOTO ValueIsEven }
	cmp rdx, 0
	je InnerLoopEnd
	; else

;ValueIsOdd
	; value = 3*value + 1
	mov rax, r11
	mul r14
	inc rax

InnerLoopEnd:
	mov r11, rax

	; if (value > 1000000) { keep calculating }
	cmp rax, 1000000
	jg InnerLoopHead
	; else

	; rax = (value - 1) * 4 [array index]
	dec rax
	mul r15

	mov ecx, [r8+rax] ; load in value saved
	
	; if (loaded value == 0) { keep looping }
	cmp ecx, 0
	je InnerLoopHead
	; else

CacheTheStack:
	pop rax ; pop latest value off stack
	inc ecx ; increment chain length

	; rax = (value - 1) * 4 [array index]
	dec rax
	mul r15

	; if (rax >= 4000000) { keep caching the stack }
	cmp rax, 4000000
	jge CacheTheStack
	; else

	mov [r8+rax], ecx ; store chain length into cache

	; if (stack pointer >= stack base) { GOTO MainLoopHead }
	cmp rsp, [STACK_BASE]
	jge MainLoopHead
	; else { keep caching the stack }
	jmp CacheTheStack

Ending:
	mov r9, 0	; array index
	mov r10, 0	; max value
	mov r11, 0	; max index
EndingLoopHead:
	mov ecx, [r8+r9]
	cmp ecx, r10d	; is value > max value
	cmovg r10d, ecx	; if so, replace max value
	cmovg r11, r9	; and replace max index

	; if (array index += 4 < 4 mil) { keep looping }
	add r9, 4
	cmp r9, 4000000
	jl EndingLoopHead
	; else

	; rax = array index / 4 + 1
	mov rax, r11
	mov rdx, 0
	div r15
	inc rax

	pop rcx
	ret
Problem14 endp





Problem14_Sol_2 proc
	push rcx

	; r8 = int* -> int[1 mil]
	mov rcx, 4000000
	call malloc
	mov r8, rax

	; for (i in range(1 mil)) { array[i] = 0 }
	mov r9, 0
InitLoopHead:
	mov DWORD PTR [r8+r9], 0
	add r9, 4
	cmp r9, 4000000
	jl InitLoopHead



	mov DWORD PTR [r8], 1 ; set chain from 1 = to 1
	mov r9, 1	; index counter
	mov r10, 0	; max value reg
	mov r13, 2	; const for mod div
	mov r14, 3	; const for mult
	mov r15, 4	; const for mult
MainLoopHead:
	mov r11, r9	; load index in to working reg
	inc r11		; increment to go from index to value
	mov r12, 0	; reset chain length reg
InnerLoopHead:
	inc r12 ; increment chain length

	; rdx = value % 2
	mov rax, r11
	mov rdx, 0
	div r13

	; if (rdx == 0) { GOTO ValueIsEven }
	cmp rdx, 0
	je ValueIsEven
	; else

;ValueIsOdd
	; value = 3*value + 1
	mov rax, r11
	mul r14
	inc rax
	mov r11, rax
	jmp InnerLoopEnd

ValueIsEven:
	; rax still contains value/2 from mod div
	mov r11, rax

InnerLoopEnd:
	; if (value > index) { keep looping }
	cmp r11, r9
	jg InnerLoopHead
	; else

;MainLoopEnd
	; rax = (value - 1) * 4
	mov rax, r11
	dec rax
	mul r15

	mov edx, DWORD PTR [r8+rax]	; load in value from memory
	add r12, rdx				; chain length += loaded value

	mov rax, r9
	mul r15
	mov DWORD PTR [r8+rax], r12d; store new chain length in array

	; if chain length is longer than saved max, replace it
	cmp r12, r10
	cmovg r10, r12
	cmovg rcx, r9

	; if (++index < 1000000) { keep looping }
	inc r9
	cmp r9, 1000000
	jl MainLoopHead
	; else

	mov rax, rcx
	pop rcx
	inc rax
	ret
Problem14_Sol_2 endp
end