mov a, 10

invoke(strlen,str1)

mov a, [0x8000]
mov b, [0x8001]
mov c, [0x8002]
mov a, [0x8003]
mov b, [0x8004]

word 0xeee0

strcmp:
	mov i, 0
	mov a, pop
	mov b, pop

	__strcmp_loop1:
		ifn [a],[b]
		jmp __strcmp_exit
		add a, 1
		add b, 1
		add i, 1
		ifn [a], 0
		jmp __strcmp_loop1

	__strcmp_exit:
		jmp pop

strlen:
	mov a, pop
	mov i, 0

	__strlen_loop:
		ifn [a], 0
		add i, 1
		add a,1
		jmp __strlen_loop

	jmp pop

writeline:
	mov a, pop
	mov i, 0

	__writeline_loop1:
		mov [0x8000+i], [a]
		add i, 1
		add a, 1
		ifn [a], 0
		jmp __writeline_loop1

	jmp pop

datum:
	exitmsg: word "exit ok",0
	str1: data "abctefg", 0
	str2: data "abcdefg", 0
