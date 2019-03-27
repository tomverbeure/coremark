
ITERATIONS      = 1

GENERIC_OBJS  = ../core_main.o ../core_list_join.o ../core_matrix.o ../core_state.o ../core_util.o 
PLATFORM_OBJS = core_portme.o ee_printf.o
OBJS          = start.o $(GENERIC_OBJS) $(PLATFORM_OBJS)

TOOLCHAIN_PREFIX = /opt/riscv32i/bin/riscv32-unknown-elf-

CFLAGS_COMMON =  -g -Wall -I.. -I. -DITERATIONS=$(ITERATIONS)
CFLAGS_COMMON += -DPERFORMANCE_RUN=1

CFLAGS 		= $(CFLAGS_COMMON)

LDFLAGS 	= --std=gnu99 -ffreestanding -nostdlib -lgcc

coremark_Os_rv32imc.bin: CFLAGS += -Os -march=rv32imc 
coremark_Os_rv32imc.bin: EXE_NAME = coremark_Os_rv32imc

coremark_O2_rv32imc.bin: CFLAGS += -O2 -march=rv32imc
coremark_O2_rv32imc.bin: EXE_NAME = coremark_O2_rv32imc

coremark_Os_rv32im.bin: CFLAGS += -Os -march=rv32im
coremark_Os_rv32im.bin: EXE_NAME = coremark_Os_rv32im

coremark_O2_rv32im.bin: CFLAGS += -O2 -march=rv32im
coremark_O2_rv32im.bin: EXE_NAME = coremark_O2_rv32im

coremark_O2_rv32i.bin: CFLAGS += -O2 -march=rv32i
coremark_O2_rv32i.bin: EXE_NAME = coremark_O2_rv32i

.PHONY: all
all: 
	make clean
	make coremark_Os_rv32imc.bin coremark_Os_rv32imc.dis coremark_Os_rv32imc.hex
	make clean
	make coremark_O2_rv32imc.bin coremark_O2_rv32imc.dis coremark_O2_rv32imc.hex 
	make clean
	make coremark_Os_rv32im.bin coremark_Os_rv32im.dis coremark_Os_rv32im.hex  
	make clean
	make coremark_O2_rv32im.bin coremark_O2_rv32im.dis coremark_O2_rv32im.hex  
	make clean
	make coremark_O2_rv32i.bin coremark_O2_rv32i.dis coremark_O2_rv32i.hex  

coremark_%.dis: $(EXE_NAME).elf
	$(TOOLCHAIN_PREFIX)objdump -D $< > $@

coremark_%.bin: $(EXE_NAME).elf
	echo $(EXE_NAME)
	$(TOOLCHAIN_PREFIX)objcopy -O binary $< $@

coremark_%.hex: coremark_%.bin
	$(TOOLCHAIN_PREFIX)objcopy -I binary -O ihex $< $@

$(EXE_NAME).elf: $(OBJS)
	$(TOOLCHAIN_PREFIX)gcc $(CFLAGS) -T sections.lds -Wl,-Bstatic,-Map,$(EXE_NAME).map,--strip-debug -o $@ $(OBJS) $(LDFLAGS)
	chmod -x $@

%.o: %.c Makefile
	$(TOOLCHAIN_PREFIX)gcc -Wall -c $(CFLAGS) $< -o $@

%.o: %.S Makefile
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf ../*.s *.s ../*.o *.o ../*.d *.d .elf .map

clean_all: clean
	rm -rf *.elf *.map *.bin *.dis *.hex

-include *.d

