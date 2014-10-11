
.globl _start
_start:
	b	reset




reset:
	bl	main
	b	.

