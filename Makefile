CC=arm-none-eabi-gcc
MACH=cortex-m4
LinkerScript=stm32_ls.ld

CFLAGS= -c -mcpu=$(MACH) -mthumb -Wall -O0
LDFLAGS= -nostdlib -T $(LinkerScript) -Wl,-Map=Debug/run.map

SRC_PATH=Core/Src
STUP_PATH=Core/Startup

SRC_OBJ_PATH=Debug/Core/Src
STUP_OBJ_PATH=Debug/Core/Startup

SRC_OBJ= $(SRC_OBJ_PATH)/main.o $(SRC_OBJ_PATH)/other.o
STUP_OBJ= $(STUP_OBJ_PATH)/stm32_startup.o

OBJ= $(SRC_OBJ) $(STUP_OBJ)


all: $(OBJ) Debug/run.elf

$(SRC_OBJ_PATH)/main.o:$(SRC_PATH)/main.c
	$(CC) $(CFLAGS) -o $@ $^
	
$(SRC_OBJ_PATH)/other.o:$(SRC_PATH)/other.c
	$(CC) $(CFLAGS) -o $@ $^ 

$(STUP_OBJ_PATH)/stm32_startup.o:$(STUP_PATH)/stm32_startup.c
	$(CC) $(CFLAGS) -o $@ $^
	
Debug/run.elf: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^
	
clean:
	rm -rf Debug/Core/Startup/*.o Debug/Core/Src/*.o Debug/*.elf

load:
	openocd -f board/stm32f4discovery.cfg
