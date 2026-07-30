CC  = ~/opt/cross/bin/x86_64-elf-gcc
CXX = ~/opt/cross/bin/x86_64-elf-g++
AS  = ~/opt/cross/bin/x86_64-elf-as
LD  = ~/opt/cross/bin/x86_64-elf-ld
OBJ = ~/opt/cross/bin/x86_64-elf-objcopy

CFLAGS = -ffreestanding -O2 -Wall -Wextra \
    	 -fno-omit-frame-pointer -fno-stack-protector -fno-pie \
		 -nostdlib -mno-red-zone -mcmodel=large
CXXFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions \
		   -fno-rtti
LDFLAGS = -nostdlib --oformat binary

BUILD_BIN = build

BOOT1_ASM = ./boot/s1.s
BOOT2_ASM = ./boot/s2.s
BOOT3_ASM = ./boot/s3/s3.s
BOOT3_C	  = ./boot/s3/s3.c
BOOT3_D   = $(wildcard ./boot/s3/drivers/*.c)
KERNEL_C  = ./bin/neko.c
KERNEL_CPP =
KERNEL_ASM =

BOOT1_BIN = ./$(BUILD_BIN)/s1.bin
BOOT2_BIN = ./$(BUILD_BIN)/s2.bin
BOOT3_BIN = ./$(BUILD_BIN)/s3.bin

BOOT_BIN   = boot.bin
KERNEL_BIN = kernel.bin
OS_IMG     = os.img

BOOT3_OBJ  = ./$(BUILD_BIN)/s3.o
BOOT3_COBJ = ./$(BUILD_BIN)/s3.c.o
BOOT3_DRIV = $(patsubst ./boot/s3/drivers/%.c,./$(BUILD_BIN)/%.c.o, $(BOOT3_D))
BOOT3_ELF  = ./$(BUILD_BIN)/s3.elf

BOOT3_LD = ./boot/s3/s3.ld

BOOT3_IDT = ./boot/s3/drivers/IDT.s
BOOT3_IDTO = ./$(BUILD_BIN)/IDT.o

BOOT3_LONG = ./boot/s3/drivers/longmode.s
BOOT3_LONGO = ./$(BUILD_BIN)/longmode.o

INITKERNEL = ./bin/nekotest.s
IK_OBJ = ./$(BUILD_BIN)/nekotest.o

#all:
#	echo $(BOOT3_COBJ)

all: $(BUILD_BIN) $(OS_IMG)

$(BUILD_BIN):
	mkdir -p $(BUILD_BIN)

$(BOOT1_BIN): $(BOOT1_ASM)
	nasm -f bin $< -o $@

$(BOOT2_BIN): $(BOOT2_ASM)
	nasm -f bin $< -o $@

$(BOOT3_OBJ): $(BOOT3_ASM)
	nasm -f elf32 $< -o $@


$(BOOT3_IDTO): $(BOOT3_IDT)
	nasm -f elf32 $< -o $@

$(BOOT3_LONGO): $(BOOT3_LONG)
	nasm -f elf32 $< -o $@

./$(BUILD_BIN)/s3.c.o: $(BOOT3_C)
	$(CC) -ffreestanding -m32 -I./boot/s3/include -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include -c $< -o $@

./$(BUILD_BIN)/%.c.o: ./boot/s3/drivers/%.c
	$(CC) -ffreestanding -m32 -I./boot/s3/include -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include -c $< -o $@

$(BOOT3_ELF): $(BOOT3_OBJ) $(BOOT3_COBJ) $(BOOT3_DRIV) $(BOOT3_IDTO) $(BOOT3_LD) $(BOOT3_LONGO)
	$(LD) -m elf_i386 -T $(BOOT3_LD) -o $@ $(BOOT3_OBJ) $(BOOT3_COBJ) $(BOOT3_DRIV) $(BOOT3_IDTO) $(BOOT3_LONGO)

$(BOOT3_BIN): $(BOOT3_ELF)
	$(OBJ) -O binary $< $@

$(BOOT_BIN): $(BOOT1_BIN) $(BOOT2_BIN) $(BOOT3_BIN)
	cat $(BOOT1_BIN) $(BOOT2_BIN) $(BOOT3_BIN) > $(BOOT_BIN) 

kernel.o: $(KERNEL_C)
	$(CC) $(CFLAGS) -c $(KERNEL_C) -o kernel.o

$(KERNEL_BIN): kernel.o
	$(LD) $(LDFLAGS) -Ttext 0x8000 kernel.o -o $(KERNEL_BIN)

$(OS_IMG): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMG) bs=512 count=2048
	dd if=$(BOOT_BIN) of=$(OS_IMG) conv=notrunc
	dd if=$(KERNEL_BIN) of=$(OS_IMG) seek=54 conv=notrunc

run: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG),if=ide -serial stdio -m size=8192

debug: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG),if=ide -serial stdio -s -S -m 1G

clean:
	rm -rf *.o *.bin $(OS_IMG) $(BUILD_BIN)

.PHONY: all run debug clean