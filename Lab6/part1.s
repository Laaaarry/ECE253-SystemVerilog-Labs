.global _start
.text
_start:
	la s2, LIST
	addi s10, zero, 0
	addi s11, zero, 0
	li s3, -1
	
	LOOP_START:
		lw t0, 0(s2)
		beq t0, s3, LOOP_END
		add s10, s10, t0
		addi s11, s11, 1
		addi s2, s2, 4
		j LOOP_START
	LOOP_END: ebreak
END: j END

.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1