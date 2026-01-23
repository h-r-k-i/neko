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
 * DATE:        22 January 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

 // QUICKTASK LIST:
 // Get Multiboot info structure from s2
 // Invoke Multiboot built at ./boot/multiboot.c
 // Load the kernel loader built at ./boot/main.c
 // Jump to the kernel loader
 // Cry