TARGET=main
CROSS=arm-none-eabi-
CSFLAGS=-c -mcpu=cortex-a8
CCFLAGS=-c -mcpu=cortex-a8

OBJS+=start.o main.o add.o

all:$(TARGET)
$(TARGET):$(OBJS)
	@$(CROSS)gcc -T ./link.ld -nostdlib -o $@ $^
	@$(CROSS)objdump -D $@
	@$(CROSS)objcopy $@ $@.bin -Obinary
	@od -x $@.bin
%.o:%.s
	@$(CROSS)gcc $(CSFLAGS) -o $@ $<
%.o:%.c
	@$(CROSS)gcc $(CCFLAGS) -o $@ $<
clean:
	@rm -f *.out *.bin *.o $(TARGET) $(OBJS)
