CC = ~/opt/cross/bin/x86_64-elf-gcc
CXX = ~/opt/cross/bin/x86_64-elf-g++
AS = ~/opt/cross/bin/x86_64-elf-as
LD = ~/opt/cross/bin/x86_64-elf-ld

CFLAGS = -ffreestanding -O2 -Wall -Wextra
CXXFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti
LDFLAGS = -nostdlib

BOOT_ASM = ./boot/s1.s
KERNEL_C = ./bin/neko.c
KERNEL_CPP =
KERNEL_ASM =

BOOT_BIN = boot.bin
KERNEL_BIN = kernel.bin
OS_IMG = os.img

all: $(OS_IMG)

$(BOOT_BIN): $(BOOT_ASM)
	nasm -f bin $(BOOT_ASM) -o $(BOOT_BIN)

kernel.o: $(KERNEL_C)
	$(CC) $(CFLAGS) -c $(KERNEL_C) -o kernel.o

$(KERNEL_BIN): kernel.o
	$(LD) $(LDFLAGS) -Ttext 0x8000 kernel.o -o $(KERNEL_BIN)

$(OS_IMG): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMG) bs=1M count=10
	dd if=$(BOOT_BIN) of=$(OS_IMG) conv=notrunc
	dd if=$(KERNEL_BIN) of=$(OS_IMG) seek=1 conv=notrunc

run: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG) -serial stdio

debug: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG) -serial stdio -s -S

clean:
	rm -f *.o *.bin $(OS_IMG)

.PHONY: all run debug clean