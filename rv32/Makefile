
EXE_NAME        = coremark
ITERATIONS      = 1

GENERIC_OBJS  = ../core_main.o ../core_list_join.o ../core_matrix.o ../core_state.o ../core_util.o 
PLATFORM_OBJS = core_portme.o ee_printf.o
OBJS          = start.o $(GENERIC_OBJS) $(PLATFORM_OBJS)

TOOLCHAIN_PREFIX = /opt/riscv32i/bin/riscv32-unknown-elf-

# VM settings
CFLAGS = -MD -O2 -march=rv32im -g -Wall -I.. -I. -DITERATIONS=$(ITERATIONS)
CFLAGS += -DPERFORMANCE_RUN=1
CFLAGS += -DCORE_DEBUG=1

all: $(EXE_NAME).dis $(EXE_NAME).bin

$(EXE_NAME).dis: $(EXE_NAME).elf
	$(TOOLCHAIN_PREFIX)objdump -D $< > $@

$(EXE_NAME).bin: $(EXE_NAME).elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary $< $@

$(EXE_NAME).elf: $(OBJS)
	$(TOOLCHAIN_PREFIX)gcc $(CFLAGS) -T sections.lds -Wl,-Bstatic,-Map,$(EXE_NAME).map,--strip-debug -nostdlib -o $@ $(OBJS) 
	chmod -x $@

%.o: %.c Makefile
	$(TOOLCHAIN_PREFIX)gcc -Wall -c $(CFLAGS) $< -o $@

%.o: %.S Makefile
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf ../*.s *.s ../*.o *.o ../*.d *.d $(EXE_NAME).elf $(EXE_NAME).map $(EXE_NAME).bin $(EXE_NAME).hex $(EXE_NAME).dis


-include *.d

