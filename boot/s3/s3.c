/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/s3.c
 * NAME:        SBL, Stage 3
 * DESCRIPTION: help
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

// QUICKTASK LIST:
// Get Multiboot info structure
// Enter Long Mode (god help me)
// Load the kernel built at ./bin/neko.c
// Jump to the kernel loader
// Cry because you sent practically garbage data to your kernel
//      and it triple-faulted
// Cry for good measure
// Delete a few more entries here because you decide you aren't
//      gonna waste your time wrangling them

#include "SMAP.h"
#include "s3.h"
#include "consoleio.h"
#include "IDT.h"
#include "inline.h"
#include "longmode.h"

void s3_main(uint32_t eax, uint32_t ebx, uint32_t edx) {
    // asm volatile (
    //     ".intel_syntax noprefix\n\t"
    //     "mov eax, 0x6B637546\n\t"
    //     ".att_syntax prefix"
    //     : /* outputs */
    //     : /* inputs */
    //     :"eax" /* clobbered */
    // );

    uint16_t * video = (uint16_t *)0xB8000;
    char * str1 = "SBL: Loading Neko...               \0";
    uint16_t index = 0;

    while (str1[index] != '\0') {
        video[index] =  (0x07 << 8) | str1[index];
        ++index;
    }

    if (eax == SBL) {
        printk("Rewriting interrupt table...\n");
        IDT_INIT();

        // printk("Remapping PIC...\n");
        // PIC_remap(0x20, 0x28);

        // printk("Unmasking IRQ...\n");
        // outb(0x21, inb(0x21) & ~0x00);

        printk("Checking for Long Mode support...\n");

        int8_t longmodeSupported = 0;
        if (checkCPUID() != 1) {
            printk("No CPUID support detected.\n");
            // Copilot wants me to then halt but right now there's no reason to not add Protected Mode support.
            // Not right now, though. Writing basically two kernels fucking hurts my head to think of.
        }
        else {
            longmodeSupported = queryLongMode();
            if (longmodeSupported == 0) {
                printk("Long Mode supported.\n");
            }
            else if (longmodeSupported == 1) {
                printk("Long Mode not supported.\n");
            }
            else if (longmodeSupported == -1) {
                printk("CPU too old for Long Mode support.\n");
            }
            else {
                printk("Error occurred while checking Long Mode support.\n");
            }
        }

        // if (longmodeSupported != 0) hang();

        // disablePaging();
        // GDT_INIT_64();
        // PT_INIT();
        // enableLongMode();



        while (1) ;
    }
    else if (eax == MULTIBOOT1) { /* todo: Multiboot1 handling */ }
    else if (eax == MULTIBOOT2) { /* todo: Multiboot2 handling */ }
    else {
        str1 = "what????????????????";
        index = 0;
        while (str1[index] != '\0') {
            video[index] = (0x0F << 8) | str1[index];
            index++;
        }
        hang();
    }
}

void hang() {
    while (1) ;
}