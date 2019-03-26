

	.section .text
	.global start
	.global main

start:
	/* set stack pointer */
	li sp,0x10000

	/* jump to main C code */
	jal ra,main

	li a0, 0x80000004
	sw zero, 0(a0)

	/* trap */
	ebreak

