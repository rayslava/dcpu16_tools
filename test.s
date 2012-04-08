mov a, 10

invoke(inttostr, digit)

mov a, [0x8000]
mov b, [0x8001]
mov c, [0x8002]
mov a, [0x8003]
mov b, [0x8004]

dat 0xeee0

:strcmp
	mov i, 0
	mov a, pop
	mov b, pop

	:__strcmp_loop1
		ifn [a],[b]
		jmp __strcmp_exit
		add a, 1
		add b, 1
		add i, 1
		ifn [a], 0
		jmp __strcmp_loop1

	:__strcmp_exit
		jmp pop

:strlen
	mov a, pop
	mov i, 0

	:__strlen_loop
		ife [a], 0
		jmp __strlen_exit
		add i, 1
		add a,1
		jmp __strlen_loop
	:__strlen_exit

	ret

:writeline
	mov a, pop
	mov i, 0

	:__writeline_loop1
		mov [0x8000+i], [a]
		add i, 1
		add a, 1
		ifn [a], 0
		jmp __writeline_loop1
		
	ret

:inttostr
	mov a, pop
	mov x, [a]
	mov b, 0x8000
	mov y, 10000
	jmp __next_digit_start

	:__digit		
		add x, 48
		
		add b, 1
		mov [b],x
		ret

	:__next_digit
		mov x, [a]
		mod x, y
		div y, 10

	:__next_digit_start 
		div x, y
		jsr __digit
		ifg y, 1
		jmp __next_digit
		
	ret

:datum
	:str1 
		dat "abctefg", 0
	:str2 
		dat "abcdefg", 0
	:digit
		dat 12345
