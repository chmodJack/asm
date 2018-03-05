
#ifndef CONFIG_SKIP_LOWLEVEL_INIT
/*
 *************************************************************************
 *
 * CPU_init_critical
 *
 *************************************************************************
 */
	.globl lowlevel_init
lowlevel_init:

	/* get cpu id */
  	mrc     p15, 0, r0, c0, c0, 5     	@ Read CPU ID register
  	ands    r0, r0, #0x03             	@ Mask off, leaving the CPU ID field
  	mov     r1, #0xF                  	@ Move 0xF (represents all four ways) into r1

	@对称多处理器结构，用来在多核处理器之间的协调同步，负载均衡
	@要组建SMP系统，首先最关键的一点就是需要合适的CPU相配合。我们平时看到的CPU都是单颗使用，所以看不出来它们有什么区别，
	@但是，实际上，支持SMP功能并不是没有条件的，随意拿几块CPU来就可以建立多处理系统那简直是天方夜谈。
	@要实现SMP功能，我们使用的CPU必须具备以下要求：
		@1、CPU内部必须内置APIC（Advanced Programmable Interrupt Controllers）单元。Intel 多处理规范的核心就是高级可编程中断控制器
		@（Advanced Programmable Interrupt Controllers--APICs）的使用。CPU通过彼此发送中断来完成它们之间的通信。通过给中断附加动作
		@（actions），不同的CPU可以在某种程度上彼此进行控制。每个CPU有自己的APIC（成为那个CPU的本地APIC），并且还有一个I/O APIC来处
		@理由I/O设备引起的中断，这个I/O APIC是安装在主板上的，但每个CPU上的APIC则不可或缺，否则将无法处理多CPU之间的中断协调。
		@2、相同的产品型号，同样类型的CPU核心。例如，虽然Athlon和Pentium III各自都内置有APIC单元，想要让它们一起建立SMP系统是不可能的，
		@当然，即使是Celeron和Pentium III，那样的可能性也为0，甚至Coppermine核心的Pentium III和Tualatin的Pentium III也不能建立SMP系统--
		@这是因为他们的运行指令不完全相同，APIC中断协调差异也很大。
		@3、完全相同的运行频率。如果要建立双Pentium III系统，必须两颗866MHz或者两颗1000MHz处理器，不可以用一颗866MHz，另一颗1000MHz来
		@组建，否则系统将无法正常点亮。
		@4、尽可能保持相同的产品序列编号。即使是同样核心的相同频率处理器，由于生产批次不同也会造成不可思议的问题。两个生产批次的CPU作
		@为双处理器运行的时候，有可能会发生一颗CPU负担过高，而另一颗负担很少的情况，无法发挥最大性能，更糟糕的是可能导致死机，因此，
		@应该尽可能选择同一批生产的处理器来组建SMP系统。
	/* join SMP */
	@ACTLR 是否表示硬件负责缓冲一致性?
	@很好的说明ACTLR:http://ilinuxkernel.com/?p=1798
  	mrc     p15, 0, r0, c1, c0, 1   	@ Read ACTLR
  	mov     r1, r0
  	orr     r0, r0, #0x040          	@ Set bit 6
  	cmp     r0, r1
  	mcrne   p15, 0, r0, c1, c0, 1   	@ Write ACTLR

	/* enable maintenance broadcast */
	@auxiliary control register
	@辅助控制存储器
	@程序流程预测包括静态和动态分支预测和返回栈。这一位启用了所有三种形式的程序流程预测。
	@您可以通过设置辅助控制寄存器中的位来单独启用或禁用每个表单。
	@http://blog.csdn.net/panfengsoftware/article/details/7915605
	mrc     p15, 0, r0, c1, c0, 1      	@ Read Aux Ctrl register
	mov     r1, r0
    orr     r0, r0, #0x01              	@ Set the FW bit (bit 0)
	cmp     r0, r1
    mcrne   p15, 0, r0, c1, c0, 1      	@ Write Aux Ctrl register

	mov	 pc, lr							@ back to caller

#endif /* CONFIG_SKIP_LOWLEVEL_INIT */
