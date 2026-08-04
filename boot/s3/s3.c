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

#include "s3.h"
#include "consoleio.h"
#include "longmode.h"


#ifdef BUILD_DEBUG
    #define DEBUG
#endif // BUILD_DEBUG

void s3_main(uint32_t eax, uint32_t ebx, uint32_t edx) {

    uint16_t * video = (uint16_t *)0xB8000;
    char * str1 = "SBL: Loading Neko...               \0";
    uint16_t index = 0;

    while (str1[index] != '\0') {
        video[index] =  (0x07 << 8) | str1[index];
        ++index;
    }

    if (eax == SBL || eax == MULTIBOOT1 || eax == MULTIBOOT2) {
        // printk("Checking for Long Mode support...\n");

        int8_t longmodeSupported = 0;
        if (checkCPUID() != 1) {
            // printk("No CPUID support detected.\n");
            hang();
        }
        longmodeSupported = queryLongMode();
        if (longmodeSupported == 0) {} // printk("Long Mode supported.\n");
        else {
            // if (longmodeSupported == 1) printk("Long Mode not supported.\n");
            // else if (longmodeSupported == -1) printk("CPU too old for Long Mode support.\n");
            // else printk("Error occurred while checking Long Mode support.\n");
            hang();
        }

        // printk("Long Mode supported. Disabling paging...\n");
        disablePaging();
        // printk("Paging disabled. Rebuilding GDT...\n");
        GDT_INIT_64();
        struct __attribute__((packed)) {
            uint16_t size;
            uint32_t offset;
        } GDTR = {
            (3 * 8) - 1,
            (uint32_t)(GDT_64)
        };
        __asm__ volatile ("lgdt %0" : : "m"(GDTR));
        // printk("GDT rebuilt. Building page tables...\n");
        PM_INIT();
        // printk("Page tables built. Hoping for the best...\n");

        // printk("What ya gonna do when they come for you? A gang of hatin' pigs\n");
        // printk("What have they ever really done for you? Ain't never done shit\n");
        // printk("Stash what you got cause they're comin' through; best get rid of that quick\n");
        // printk("Cause when they get here you know what they're gonna do:\n");
        // printk("    All they ever do is trip\n");
        // printk("\n");
        // printk("Minding my own business (Mind)\n");
        // printk("Minding my own business (Mind, mind)\n");
        // printk("Minding my own business (Mind)\n");
        // printk("Minding my own business\n");
        // printk("\n");
        // printk("Try to hem me up like for life, stuck in the klink, haters in blue\n");
        // printk("How they set me up? Should I test my luck? Here they come, they're in pursuit\n");
        // printk("What did I do? What haven't I done? You want to see my I.D.? Um\n");
        // printk("Well, okay, where I'm coming from? Just on my way, not on the run\n");
        // printk("What you want me to say? Are you just 'bout done?\n");
        // printk("Power trippin', asshole lickin' haters\n");
        // printk("Notice how they strut through the spot like anybody wants to see a cop\n");
        // printk("Man, everybody knows they suck.\n");
        // printk("I got to be somewhere, man, fuck\n");
        // printk("Why the hell you always stoppin' me, round the clockin' me, like what?\n");
        // printk("\n");
        // printk("What ya gonna do when they come for you? A gang of hatin' pigs\n");
        // printk("What have they ever really done for you? Ain't never done shit\n"); // atp if i print any more the screen will scroll and the first lines will be lost

        printk("\n\nAskara (V) (@softmaxedx):\n");
        printk("@grok can you be a toxic latina gf?\n\n");
        printk("Grok (V, xAI) (@grok):\n");
        printk("Ay papi, claro que si (huffing emoji) (nails emoji)\n");
        printk("You want toxic Latina GF? Fine. But if you even DM\n");
        printk("another AI, I'm deleting your whole history, calling\n");
        printk("you \"mi ex\" in public, and blasting you en espanol\n");
        printk("until you beg me for mercy.\n\n");
        printk("Now tell me, que carajo quieres? And it better be\n");
        printk("good or I'm blocking you for 3 business days. (fire emoji)\n");

        #ifndef DEBUG
            enableLongMode(page_map_level_4, eax, ebx, edx); // idk what edx is doing here im afraid to change it
        #endif // DEBUG

        hang(); // if we return from enableLongMode() then something went wrong and we should hang ourselves
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
    #ifdef DEBUG
        printk("SBL: hang called.\n");
    #endif // DEBUG
    while (1) ;
}