/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3.c
 * NAME:        NekoDOS Bootloader, Stage 3
 * DESCRIPTION: After a lot of hell regarding the first two stages of the bootloader this
 *              final stage uses plain C to transfer from the bootloader to the kernel.
 *              This is rather simple; our assembly already did 95% of the job and the
 *              rest of the task involves invoking Multiboot and loading the loader for
 *              the kernel.
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        29 January 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

// QUICKTASK LIST:
// Get Multiboot info structure
// Write a proper IDT and load it
// Enter Long Mode (god help me)
// Load the requisite drivers (usually ATA at ./drivers/ATA.c)
// Cry after the ATA driver craps its ass
// Invoke Multiboot processing built at ./boot/multiboot.c
// Load the kernel built at ./bin/neko.c
// Jump to the kernel loader
// Cry because you sent practically garbage data to your kernel
//      and it triple-faulted
// Cry for good measure

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long long int64_t;

void s3_main(void) {
    asm volatile (
        ".intel_syntax noprefix\n\t"
        "mov eax, 0x6B637546\n\t"
        ".att_syntax prefix"
        : /* outputs */
        : /* inputs */
        :"eax" /* clobbered */
    );

    uint16_t * video = (uint16_t *)0xB8000;
    char * str1 = "wow this actually worked\0";
    uint16_t index = 0;

    while (str1[index] != '\0') {
        video[index] =  (0x07 << 8) | str1[index];
        ++index;
    }

    while (1) { asm("hlt"); }
}