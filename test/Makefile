CROSS:=arm-none-eabi-
all:
	@$(CROSS)as main.s -mcpu=cortex-a8
	@$(CROSS)objdump -d a.out
	@$(CROSS)objcopy a.out a.bin -Obinary
	@od -x a.bin
clean:
	@rm a.out a.bin -f
