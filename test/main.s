test:
	push {fp,lr}
	mov r0,#1
	mov r1,#2
	bl accAdd
	pop {fp,lr}
	b end
accAdd:
	add r2,r0,r1
	add r0,#1
	cmp r0,r1
	bne accadd
	mov r2,r0
	mov pc,lr
end:
