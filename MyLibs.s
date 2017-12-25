@局部符号
@指定rodata段
.section .rodata
@指定对齐格式
.align 2
str:
	@ascii字符串
	.ascii "%s\n\0"

@定义全局符号
.global MyStrcpy
@指定text段
.section .text
@指定对齐格式
.align 2
MyStrcpy:
	@不用调用别的函数,不用临时变量,所以lr和fp都不用压栈
	@保存第一个地址参数,等函数结束时恢复
	push {a1}

	@循环起始点
start:
	@从第二个地址里面加载数据到寄存器
	ldr a3,[a2]
	@把数据写入第一个地址的内存里面
	str a3,[a1]
	@源地址和目的地址都往后偏移1个字节
	add a1,a1,#1
	add a2,a2,#1
	@判断拷贝的数据是否为'0',判断的结果保存在cpsr的Z位
	cmp a3,#0
	@条件跳转,bne:如果Z位不为0就跳转(b not equal) beq:(b equal) ble:(b less or equal)
	bne start

	@恢复函数的第一个参数到a1寄存器
	pop {a1}
	@跳转回到父函数
	mov pc,lr

@全局符号
.global prints
@指定text段
.section .text
@指定对齐格式2^x (x=2)
.align 2
prints:
	@不使用局部变量,所以不用保存fp,但是因为调用了printf,所以要保存lr
	push {lr}
	@保存父函数传过来的字符串地址到a2,作为printf的第二个参数
	mov a2,a1
	@加载printf的第一个参数
	ldr a1,=str
	@跳转到printf
	bl printf
	@恢复lr寄存器的值
	pop {lr}
	@使函数的返回值为0
	ldr a1,=0
	@跳转回父函数
	mov pc,lr
