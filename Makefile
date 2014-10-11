
# CROSS_COMPILE specify the prefix used for all executables used
# during compilation. Only gcc and related bin-utils executables
# are prefixed with $(CROSS_COMPILE).
# CROSS_COMPILE can be set on the command line
# make CROSS_COMPILE=ia64-linux-
# Alternatively CROSS_COMPILE can be set in the environment.
# Default value for CROSS_COMPILE is not to prefix executables

ARCH            ?= arm
CROSS_COMPILE   ?= arm-none-linux-gnueabi-

# Make variables (CC, etc...)

AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump




# Use INCLUDES when you must reference the include/ directory.
# Needed to be compatible with the O= option
INCLUDES	:= -Iinclude 
CFLAGS	:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -pipe -nostdlib $(INCLUDES)
AFLAGS	:= -D__ASSEMBLY__
LDFLAGS	:= -Map a.map

SRCS := start.S
SRCS += main.c

OBJS := start.o
OBJS += main.o


all: a.out a.bin

# image
a.out: $(OBJS) FORCE
	$(LD) $(LDFLAGS) -o $@ -T a.out.lds --start-group $(OBJS) --end-group  

a.bin: a.out FORCE
	$(OBJCOPY) -O binary $< $@

%.o: %.s
	$(AS) $(AFLAGS) $< -o $@
%.o: %.S
	$(CC) $(CFLAGS) $< -c -o $@
%.o: %.c
	$(CC) $(CFLAGS) $< -c -o $@



.PHONY: FORCE
FORCE:

.PHONY: clean
clean:
	rm -f *.o a.out a.bin a.map

