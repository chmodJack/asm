TARGET:=main
CROSS:=arm-linux-gnueabi-
CC:=$(CROSS)gcc
ECHO:=@

SSRC+=$(shell find . -name '*.s')
CSRC+=$(shell find . -name '*.c')
CPPSRC+=$(shell find . -name '*.cpp')
OBJS+=$(SSRC:%.s=%.o)
OBJS+=$(CSRC:%.c=%.o)
OBJS+=$(CPPSRC:%.cpp=%.o)

ALLPATHS:=$(shell ls -R | grep :)
CFLAGS+=$(ALLPATHS:%:=-I%)
CFLAGS+=-c -Ofast -DDEBUG -I.

CSFLAGS+=$(CFLAGS)
CCFLAGS+=$(CFLAGS) -std=gnu11
CCPPFLAGS+=$(CFLAGS) -std=gnu++17

LDFLAGS+=$(ALLPATHS:%:=-L%)
LDFLAGS+=-lc -lm -lstdc++ -static

.PHONY:all clean
all:$(TARGET)
	@echo -e '[33m[GO] [32m$<[0m'
	$(ECHO)./$<
	@$(CROSS)objdump -d main > main.dis
$(TARGET):$(OBJS)
	@echo -e '[33m[LD] [32m$@[0m'
	$(ECHO)$(CC) -o $@ $^ $(LDFLAGS)
%.o:%.s
	@echo -e '[33m[CC] [32m$@[0m'
	$(ECHO)$(CC) -o $@ $< $(CSFLAGS)
%.o:%.c
	@echo -e '[33m[CC] [32m$@[0m'
	$(ECHO)$(CC) -o $@ $< $(CCFLAGS)
%.o:%.cpp
	@echo -e '[33m[CC] [32m$@[0m'
	$(ECHO)$(CC) -o $@ $< $(CCPPFLAGS)
clean:
	@echo -e '[33m[RM] [32m$(TARGET) $(OBJS) cscope.* tags[0m'
	$(ECHO)rm -rf $(TARGET) $(OBJS) cscope.* tags
