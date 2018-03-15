.global _stext
.section .vectors,"a"
.align 2
_stext:
	.word 0xffff0000 @stack pointer
	.word reset
	.word nmi
	.word hard_fault
	.word mem_manage
	.word bus_fault
	.word usage_fault
	.word 0
	.word 0
	.word 0
	.word 0
	.word svc
	.word debug_mon
	.word 0
	.word pend_sv
	.word sys_tick
	@continue external exceptions...

.global reset
.section .text
.thumb_func
.align 2
reset:
	ldr r0,=#0xffff0004
	ldr r1,[r0]
	ldr r1,=#0xab
	str r1,[r0]

	mov r0,#1
	mov r1,#2
	mov r2,#3
	mov r3,#4

	dmb
	dsb
	isb

	bl init
	cmp r0,#0
	bne .

	mov r0,#1
	ldr r1,=str
	bl main
	cmp r0,#0
	bne .
	b reset

.section .rodata
.align 2
str:
	.ascii "Hello world!\0"

.global init
.section .text
.thumb_func
.weak init
.align 2
init:
	mov r0,#0
	mov pc,lr

.weak nmi
.weak hard_fault
.weak mem_manage
.weak bus_fault
.weak usage_fault
.weak svc
.weak debug_mon
.weak pend_sv
.weak sys_tick

nmi:
	b .
hard_fault:
	b .
mem_manage:
	b .
bus_fault:
	b .
usage_fault:
	b .
svc:
	b .
debug_mon:
	b .
pend_sv:
	b .
sys_tick:
	b .
