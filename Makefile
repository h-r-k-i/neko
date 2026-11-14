CC  = ~/opt/cross/bin/x86_64-elf-gcc
CXX = ~/opt/cross/bin/x86_64-elf-g++
AS  = ~/opt/cross/bin/x86_64-elf-as
LD  = ~/opt/cross/bin/x86_64-elf-ld
OBJ = ~/opt/cross/bin/x86_64-elf-objcopy

CFLAGS = -ffreestanding -O2 -Wall -Wextra \
    	 -fno-omit-frame-pointer -fno-stack-protector -fno-pie \
		 -nostdlib -mno-red-zone -mcmodel=large \
		 -I./boot/s3/include -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include
CXXFLAGS = -ffreestanding -Wall -Wextra -fno-exceptions \
		   -fno-rtti -m16 -mgeneral-regs-only \
		   -ffreestanding -I./boot/s3/include -DBUILD_DEBUG -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include \
		   -I/home/renee/opt/cross/bin/x86_64-elf/include/c++/15.2.0 -fno-omit-frame-pointer -fno-stack-protector \
		   -fno-pie -nostdlib -mno-red-zone
LDFLAGS = -nostdlib --oformat binary

BUILD_BIN = build

BOOT1_ASM = ./boot/s1.s
BOOT2_ASM = ./boot/s2/s2.s
BOOT2_C   = ./boot/s2/s2.c
BOOT2_BIN  = ./$(BUILD_BIN)/s2.bin

BOOT2_OBJ  = ./$(BUILD_BIN)/s2.o
BOOT2_COBJ = ./$(BUILD_BIN)/s2.c.o
BOOT2_ELF  = ./$(BUILD_BIN)/s2.elf

BOOT2_HELPASM = ./boot/s2/s2func.s
BOOT2_HLP = ./$(BUILD_BIN)/s2func.o

BOOT2_LD = ./boot/s2/s2.ld

BOOT3_ASM = ./boot/s3/s3.s
BOOT3_C	  = ./boot/s3/s3.cpp
BOOT3_D   = $(wildcard ./boot/s3/drivers/*.cpp)
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
BOOT3_COBJ = ./$(BUILD_BIN)/s3.cpp.o
BOOT3_DRIV = $(patsubst ./boot/s3/drivers/%.cpp,./$(BUILD_BIN)/%.cpp.o, $(BOOT3_D))
BOOT3_ELF  = ./$(BUILD_BIN)/s3.elf

BOOT3_LD = ./boot/s3/s3.ld

BOOT3_DRVASM = $(wildcard ./boot/s3/drivers/*.s)
BOOT3_DRVO = $(patsubst ./boot/s3/drivers/%.s,./$(BUILD_BIN)/%.o,$(BOOT3_DRVASM))

INITKERNEL = ./bin/nekotest.s
IK_OBJ = ./$(BUILD_BIN)/nekotest.o

KERNEL = ./bin/neko.c
KERNEL_OBJ = ./$(BUILD_BIN)/neko.o

ifdef S2_DEBUG
    S2_DEBUG_FLAG := -D$(S2_DEBUG)
	
endif

#all:
#	echo $(BOOT3_COBJ)

all: $(BUILD_BIN) $(OS_IMG)

$(BUILD_BIN):
	mkdir -p $(BUILD_BIN)

$(BOOT1_BIN): $(BOOT1_ASM)
	nasm -f bin $< -o $@

$(BOOT2_OBJ): $(BOOT2_ASM)
	nasm -f elf32 $< -o $@

$(BOOT2_COBJ): $(BOOT2_C)
	$(CC) -ffreestanding -m16 -mgeneral-regs-only -O1 -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include $(S2_DEBUG_FLAG) -c $< -o $@

$(BOOT2_HLP): $(BOOT2_HELPASM)
	nasm -f elf32 $< -o $@

$(BOOT2_ELF): $(BOOT2_OBJ) $(BOOT2_COBJ) $(BOOT2_LD) $(BOOT2_HLP)
	$(LD) -m elf_i386 -T $(BOOT2_LD) -o $@ $(BOOT2_OBJ) $(BOOT2_COBJ) $(BOOT2_HLP) -Map=$(BUILD_BIN)/s2.map

$(BOOT2_BIN): $(BOOT2_ELF)
	$(OBJ) -O binary $< $@

$(BOOT3_OBJ): $(BOOT3_ASM)
	nasm -f elf32 $< -o $@

./$(BUILD_BIN)/%.o: ./boot/s3/drivers/%.s
	nasm -f elf32 $< -o $@

$(IK_OBJ): $(INITKERNEL)
	nasm -f elf32 $< -o $@

$(KERNEL_OBJ): $(KERNEL)
	$(CC) -ffreestanding -m16 -I./boot/s3/include -I/home/renee/opt/cross/bin/lib/gcc/x86_64-elf/15.2.0/include -c $< -o $@

./$(BUILD_BIN)/s3.cpp.o: $(BOOT3_C)
	$(CXX) $(CXXFLAGS) -c $< -o $@

./$(BUILD_BIN)/%.cpp.o: ./boot/s3/drivers/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BOOT3_ELF): $(BOOT3_OBJ) $(BOOT3_COBJ) $(BOOT3_DRIV) $(BOOT3_LD) $(BOOT3_DRVO) $(IK_OBJ) $(KERNEL_OBJ)
	$(LD) -m elf_i386 -T $(BOOT3_LD) -o $@ $(BOOT3_OBJ) $(BOOT3_COBJ) $(BOOT3_DRIV) $(BOOT3_DRVO) $(IK_OBJ) $(KERNEL_OBJ)

$(BOOT3_BIN): $(BOOT3_ELF)
	$(OBJ) -O binary $< $@

$(BOOT_BIN): $(BOOT1_BIN) $(BOOT2_BIN) $(BOOT3_BIN)
	cat $(BOOT1_BIN) $(BOOT2_BIN) $(BOOT3_BIN) > $(BOOT_BIN) 

kernel.o: $(KERNEL_C)
	$(CC) $(CFLAGS) -c $(KERNEL_C) -o kernel.o

consoleio.o: ./boot/s3/drivers/consoleio.cpp
	$(CC) $(CFLAGS) -c ./boot/s3/drivers/consoleio.cpp -o consoleio.o

$(KERNEL_BIN): kernel.o
	$(LD) $(LDFLAGS) -Ttext 0x8000 kernel.o -o $(KERNEL_BIN)

# $(OS_IMG): $(BOOT_BIN) $(KERNEL_BIN)
# 	dd if=/dev/zero of=$(OS_IMG) bs=512 count=131072
# 	printf 'label: dos\nstart=2048, type=e, bootable\n' | sfdisk $(OS_IMG)
# 	mkfs.fat -F 16 -n "Neko" --offset=2048 $(OS_IMG) # FAT16 because I can't be fucked to expand the drive size to one that can work with FAT32
# 	dd if=$(BOOT_BIN) of=$(OS_IMG) bs=446 count=1 conv=notrunc
# 	dd if=$(BOOT_BIN) of=$(OS_IMG) bs=512 skip=1 seek=1 conv=notrunc
# 	mmd -i $(OS_IMG)@@1048576 ::/BOOT
# 	mcopy -i $(OS_IMG)@@1048576 $(KERNEL_BIN) ::/BOOT/NEKO.ELF

$(OS_IMG): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMG) bs=512 count=1000000
	printf 'label: dos\nstart=2048, type=c, bootable\n' | sfdisk $(OS_IMG)
	mkfs.fat -F 32 -n "Neko" --offset=2048 $(OS_IMG)
	dd if=$(BOOT_BIN) of=$(OS_IMG) bs=446 count=1 conv=notrunc
	dd if=$(BOOT_BIN) of=$(OS_IMG) bs=512 skip=1 seek=1 conv=notrunc
	mmd -i $(OS_IMG)@@1048576 ::/BOOT
	mcopy -i $(OS_IMG)@@1048576 $(KERNEL_BIN) ::/BOOT/NEKO.ELF

run: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG),if=ide -serial stdio -m 6G -d int,cpu_reset -no-reboot -D qemu.log -cpu host -accel kvm

debug: $(OS_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMG),if=ide -serial stdio -s -S -m 1G -accel kvm -cpu host,+rdrand

clean:
	rm -rf *.o *.bin $(OS_IMG) $(BUILD_BIN)

.PHONY: all run debug clean