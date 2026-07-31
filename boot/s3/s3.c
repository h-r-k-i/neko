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


__attribute__((section(".multiboot"))) struct {
 // todo: set up multiboot
} multiboot_header;

void s3_main(uint32_t eax, uint32_t ebx, uint32_t edx) {

    uint16_t * video = (uint16_t *)0xB8000;
    char * str1 = "SBL: Loading Neko...               \0";
    uint16_t index = 0;

    while (str1[index] != '\0') {
        video[index] =  (0x07 << 8) | str1[index];
        ++index;
    }

    if (eax == SBL || eax == MULTIBOOT1 || eax == MULTIBOOT2) {
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
            hang();
        }
        longmodeSupported = queryLongMode();
        if (longmodeSupported == 0) printk("Long Mode supported.\n");
        else {
            if (longmodeSupported == 1) printk("Long Mode not supported.\n");
            else if (longmodeSupported == -1) printk("CPU too old for Long Mode support.\n");
            else printk("Error occurred while checking Long Mode support.\n");
            hang();
        }

        printk("Long Mode supported. Disabling paging...\n");
        disablePaging();
        printk("Paging disabled. Rebuilding GDT...\n");
        GDT_INIT_64();
        struct __attribute__((packed)) {
            uint16_t size;
            uint32_t offset;
        } GDTR = {
            (3 * 8) - 1,
            (uint32_t)(GDT_64)
        };
        __asm__ volatile ("lgdt %0" : : "m"(GDTR));
        printk("GDT rebuilt. Building page tables...\n");
        PM_INIT();
        printk("Page tables built. Hoping for the best...\n");
        enableLongMode(page_map_level_4, eax, ebx, edx); // idk what edx is doing here im afraid to change it



        while (1) ;
    }
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