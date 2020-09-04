CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size
NM = arm-none-eabi-nm
# Should STMCUBEPROG as command line arg to make

LIBCDIR = /data/electronics_projects/toolchains/gcc-arm-none-eabi-9-2020-q2-update/arm-none-eabi/lib/
LIBC_FLAVOR = c_nano

CFLAGS = -mthumb -mcpu=cortex-m3 -msoft-float -Ideps/CMSIS_5/CMSIS/Core/Include/ -Ideps/musl/ -Ideps/FreeRTOS/ -Ideps/FreeRTOS/include/ -Ideps/peripheral_library/ -Ideps -Isrc -DSTM32F10X_HD -DUSE_FULL_LL_DRIVER  -lm --specs=nosys.specs 

PROG_SRC    := $(wildcard src/*.c)
PROGS_OBJ   := $(patsubst src/%.c, src/%.o, $(PROG_SRC))
DEPS_SRC    := $(wildcard deps/*.c)
DEPS_OBJ    := $(patsubst deps/%.c, deps/%.o, $(DEPS_SRC))
PERIPH_DEPS_SRC    := $(wildcard deps/peripheral_library/*.c)
PERIPH_DEPS_OBJ    := $(patsubst deps/peripheral_library/%.c, deps/peripheral_library/%.o, $(PERIPH_DEPS_SRC))
FREERTOS_DEPS_SRC    := $(wildcard deps/FreeRTOS/*.c)
FREERTOS_DEPS_OBJ    := $(patsubst deps/FreeRTOS/%.c, deps/FreeRTOS/%.o, $(FREERTOS_DEPS_SRC))
MUSL_DEPS_SRC    := $(wildcard deps/musl/*.c)
MUSL_DEPS_OBJ    := $(patsubst deps/musl/%.c, deps/musl/%.o, $(MUSL_DEPS_SRC))
MISC_DEPS_SRC    := $(wildcard deps/misc/*.c)
MISC_DEPS_OBJ    := $(patsubst deps/misc/%.c, deps/misc/%.o, $(MISC_DEPS_SRC))


all: fw.bin

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
deps/%.o: deps/%.c
	$(CC) $(CFLAGS) -c $< -o $@

deps/peripheral_library/%.o: deps/peripheral_library/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
deps/FreeRTOS/%.o: deps/FreeRTOS/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
deps/musl/%.o: deps/musl/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
deps/misc/%.o: deps/misc/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
crt.o: crt_stm32f103rc.s
	$(AS) -o crt.o crt_stm32f103rc.s


main.o: main.c
	$(CC) $(CFLAGS) -c -o $@ $< 

	
fw.elf: linker.ld crt.o main.o $(PROGS_OBJ) $(DEPS_OBJ) $(PERIPH_DEPS_OBJ) $(FREERTOS_DEPS_OBJ) $(MUSL_DEPS_OBJ) $(MISC_DEPS_OBJ)
	$(LD) -T linker.ld -o fw.elf crt.o $(PROGS_OBJ) $(DEPS_OBJ) $(PERIPH_DEPS_OBJ) $(FREERTOS_DEPS_OBJ) $(MUSL_DEPS_OBJ) $(MISC_DEPS_OBJ) main.o
	
fw.bin: fw.elf
	$(BIN) -O binary fw.elf fw.bin
	@echo -e "\n---- Biggest space wasters :D -----"
	$(NM) -t d  --print-size --size-sort fw.elf | tail -n 10
	@echo -e "----        END               -----\n"
	$(SIZE) -A  fw.elf
	$(SIZE) --target=binary -A  fw.bin
	
clean:
	rm -f *.o *.elf *.bin
	rm -f src/*.o
	rm -f deps/*.o
	rm -f deps/musl/*.o
	rm -f deps/misc/*.o
	rm -f deps/FreeRTOS/*.o
	rm -f deps/peripheral_library/*.o

size: fw.elf fw.bin
	$(SIZE) -G  fw.elf
	@echo -e "\n---- Biggest space wasters :D -----"
	$(NM) -t d  --print-size --size-sort fw.elf | tail -n 10
	@echo -e "----        END               -----\n"
	$(SIZE) -A  fw.elf
	$(SIZE) --target=binary -A  fw.bin
