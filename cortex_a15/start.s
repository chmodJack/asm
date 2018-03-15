.global _start
.section .vectors,"a"
_start:
	b reset
	ldr pc, _undefined_instruction
	ldr	pc, _software_interrupt
	ldr	pc, _prefetch_abort
	ldr	pc, _data_abort
	ldr	pc, _not_used
	ldr	pc, _irq
	ldr	pc, _fiq

.globl _undefined_instruction
.globl _software_interrupt
.globl _prefetch_abort
.globl _data_abort
.globl _not_used
.globl _irq
.globl _fiq

_undefined_instruction:
	.word undefined_instruction
_software_interrupt:
	.word software_interrupt
_prefetch_abort:
	.word prefetch_abort
_data_abort:
	.word data_abort
_not_used:
	.word not_used
_irq:
	.word irq
_fiq:
	.word fiq

.balignl 16,0xdeadbeef

.align  5
undefined_instruction:
	b .

.align	5
software_interrupt:
	b .

.align	5
prefetch_abort:
	b .

.align	5
data_abort:
	b .

.align	5
not_used:
	b .

.align	5
irq:
	b .

.align	5
fiq:
	b .

.global reset
.section .text
.align 2
reset:
	mrs	r0, cpsr
	and	r1, r0, #0x1f		@ mask mode bits
	teq	r1, #0x1a		@ test for HYP mode
	bicne	r0, r0, #0x1f		@ clear all mode bits
	orrne	r0, r0, #0x13		@ set SVC mode
	orr	r0, r0, #0xc0		@ disable FIQ and IRQ
	msr	cpsr,r0

	@bl cpu_init_cp15
	@bl cpu_init_crit

	bl main
