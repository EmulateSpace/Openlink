#
# link demo Makefile
#
# (C) 2017.09 <buddy.zhang@aliyun.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

CC=gcc
LD=ld
AS=as
OBJDP=objdump

CFLAGS  :=
LDFLAGS :=
ASFLAGS :=

objs += main.o

# objdump
debug_dump = \
	$(OBJDP) -s -S -x -dh $(1) > $(1).objdump

#debug rule
cross_all = \
        $(CC) $(CFLAGS) -E -o $(1).i $(1).c; \
        $(CC) $(CFLAGS) -S -o $(1).s $(1).i; \
        $(AS) $(ASFLAGS) -o $(1).o $(1).s;   \

link: $(objs)
	$(CC) $(LDFLAGS) $^ -o $@
	$(call debug_dump,$@)

$(objs):
	$(call cross_all,$(patsubst %.o,%,$@))

PHONY += clean
clean:
	rm -rf *.i *.o link *.s *.objdump
