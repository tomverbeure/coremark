
	.section .text
	.global start
	.global main

start:
	// We have 32KB or RAM
	li sp,0x08000

	// jump to main C code 
	jal ra,main

    // Write to this register results in simulation halt
	li a0, 0x80000004
	sw zero, 0(a0)

    // Trap
	ebreak

