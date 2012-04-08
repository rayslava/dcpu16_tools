all:
	m4 macro.m4 test.s > processed.s
	../dcpu16/a16 processed.s
	../dcpu16/dcpu

clean:
	rm out.hex
