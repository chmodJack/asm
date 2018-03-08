.global _start
.section .text
.align 2
_start:
	bl reset
	bl main

	clrex
	dmb
	dsb
	isb

reset:
	mov sp,#0xffffffff

	ldr r0,=bss_start
	ldr r1,=bss_end
	ldr r2,=#0
	bl clear_bss

	mov pc,lr

.section .text
.align 2
clear_bss:
	cmp r0,r1
	beq end
	str r2,[r0]
	add r0,#1
	b clear_bss
end:
	mov r0,#0
	mov pc,lr
