TARGET=main
OBJS+=main.o MyLibs.o

all:$(TARGET)
$(TARGET):$(OBJS)
	@echo [LD] $@
	@$(CROSS)gcc -static -o main $^
	@./$(TARGET)
%.o:%.c
	@echo [CC] $@
	@$(CROSS)gcc -c -o $@ $<
%.o:%.s
	@echo [AS] $@
	@$(CROSS)gcc -c -o $@ $<
clean:
	@echo [CL] $(TARGET) $(OBJS)
	@rm -rf $(TARGET) $(OBJS)
.PHONY:all clean $(TARGET)
