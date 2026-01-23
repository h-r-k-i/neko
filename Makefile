CC = ~/opt/cross/bin/x86_64-elf-gcc
CXX = ~/opt/cross/bin/x86_64-elf-g++
AS = ~/opt/cross/bin/x86_64-elf-as
LD = ~/opt/cross/bin/x86_64-elf-ld

CFLAGS = -ffreestanding -O2 -Wall -Wextra
CXXFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti
LDFLAGS = -nostdlib

BOOT1_ASM = ./boot/s1.s
BOOT2_ASM = ./boot/s2.s
KERNEL_C = ./bin/neko.c
KERNEL_CPP =
KERNEL_ASM =

BOOT1_BIN = ./build/s1.bin
BOOT2_BIN = ./build/s2.bin
BOOT_BIN = boot.bin
KERNEL_BIN = kernel.bin
OS_IMG = os.img

BUILD_BIN = build

all: $(BUILD_BIN) $(OS_IMG)

$(BUILD_BIN):
	mkdir -p $(BUILD_BIN)

$(BOOT1_BIN): $(BOOT1_ASM)
	nasm -f bin $< -o $@

$(BOOT2_BIN): $(BOOT2_ASM)
	nasm -f bin $< -o $@

$(BOOT_BIN): $(BOOT1_BIN) $(BOOT2_BIN)
	cat $(BOOT1_BIN) $(BOOT2_BIN) > $(BOOT_BIN) 

kernel.o: $(KERNEL_C)
	$(CC) $(CFLAGS) -c $(KERNEL_C) -o kernel.o

$(KERNEL_BIN): kernel.o
	$(LD) $(LDFLAGS) -Ttext 0x8000 kernel.o -o $(KERNEL_BIN)

$(OS_IMG): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMG) bs=1M count=10
	dd if=$(BOOT_BIN) of=$(OS_IMG) conv=notrunc
	dd if=$(KERNEL_BIN) of=$(OS_IMG) seek=18 conv=notrunc

run: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG) -serial stdio

debug: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG) -serial stdio -s -S

clean:
	rm -rf *.o *.bin $(OS_IMG) $(BUILD_BIN)

.PHONY: all run debug clean