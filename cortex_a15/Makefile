TARGET:=main
CROSS:=arm-none-eabi-
OBJS:=start.o main.o

#MACHINE=-march=armv7-m -mcpu=cortex-m3 -mfloat-abi=soft -mthumb
MACHINE=-march=armv7-a -mcpu=cortex-a15 -mfloat-abi=softfp -mfpu=neon

CCFLAGS=$(MACHINE) -O0 -std=c11 -g
CSFLAGS=$(MACHINE) -g

LDFLAGS+=-T./link.ld -static -nostartfiles -g

.PHONY:clean $(TARGET)
$(TARGET):$(OBJS)
	$(CROSS)gcc $(LDFLAGS) -o $@ $^
	$(CROSS)objdump -D $@
	$(CROSS)objcopy $@ $@.bin -Obinary
	od -x $@.bin
%.o:%.c
	$(CROSS)gcc -c $(CCFLAGS) -o $@ $<
%.o:%.s
	$(CROSS)gcc -c $(CSFLAGS) -o $@ $<
clean:
	rm -f $(OBJS) $(TARGET) a.out $(TARGET).dis $(TARGET).bin
