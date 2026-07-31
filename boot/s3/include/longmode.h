/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/longmode.h
 * NAME:        SBL, Stage 3 || Long Mode Assembly Helper Header
 * DESCRIPTION: Provides function prototypes for checking CPUID support
 *              and querying Long Mode support.
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        29 July 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#ifndef LONGMODE_H
#define LONGMODE_H

/// Standard library includes
#include <stdint.h>

/// Other includes

/// Defined Constants
// Page Table Flags
#define PRESENT 0x1ULL
#define WRITABLE 0x2ULL
#define USER_ACCESSIBLE 0x4ULL
#define WRITE_THROUGH 0x8ULL
#define CACHE_DISABLED 0x10ULL
#define ACCESSED 0x20ULL
#define DIRTY 0x40ULL
#define PD_LARGE_PAGE 0x80ULL
#define PT_PAT_SUPPORTED 0x80ULL
#define GLOBAL 0x100ULL
#define PD_PAT_SUPPORTED 0x1000ULL
#define EXECUTE_DISABLE 0x8000000000000000ULL

#define PHYADDR_SIZE 36

// Errors
#define PML4_NO_ENTRY -1
#define PML4_INVALID_ENTRY -2
#define PML4_WRITE_ERROR -3
#define PDPT_NO_ENTRY -4
#define PDPT_INVALID_ENTRY -5
#define PDPT_WRITE_ERROR -6
#define PD_NO_ENTRY 1
#define PD_INVALID_ENTRY 2
#define PD_WRITE_ERROR 3
#define PT_NO_ENTRY 4
#define PT_INVALID_ENTRY 5
#define PT_WRITE_ERROR 6

// GDT Bullshit God End My Suffering
#define LIMIT (0xFULL << 48) | 0xFFFFULL
#define BASE 0x0ULL

// [Flags]
#define GRANULARITY 0x1ULL << 55
#define LONG_MODE 0x1ULL << 53

// [Access Byte]
#define PRESENT_GDT 0x01ULL << 47
#define DESCRIPTOR_TYPE 0x01ULL << 44
#define EXECUTABLE 0x01ULL << 43
#define READ_WRITE 0x01ULL << 41
#define ACCESS 0x01ULL << 40


/// Region Mapping

// if you're wondering the logic for these exact addresses,
// find a better programmer.
uint64_t * page_table = (uint64_t *)0x90000;
uint64_t * page_directory = (uint64_t * ) 0x91000;
uint64_t * page_directory_pointer_table = (uint64_t *)0x92000;
uint64_t * page_map_level_4 = (uint64_t *)0x93000;

uint64_t * GDT_64 = (uint64_t *)0x900;


/// Function prototypes
extern uint8_t checkCPUID(void);
extern int8_t queryLongMode(void);
extern void disablePaging(void);
extern void enableLongMode(uint64_t * PML4_LOCATION, uint64_t eax, uint64_t ebx, uint64_t edx);

/// Header-Defined Functions
// these are defined in the header because
// I do NOT want to write a separate .c file
// for this shit.

// Sets up the page table entries for Long Mode
static inline int32_t PT_INIT(void) {
    uint64_t entry = 0;
    for (int i = 0; i < 512; i++) {
        uint64_t loc = i * 0x1000; // 4 KiB pages
        entry = (uint64_t) PRESENT | WRITABLE | USER_ACCESSIBLE | loc;
        page_table[i] = entry;
        if (page_table[i] != entry) return PT_WRITE_ERROR;
    }
    return 0;
}


// Initializes the page tables for Long Mode
static inline int32_t PM_INIT(void) {

    // init clear tables because real life fucking sucks
    for (int i = 0; i < 512; i++) {
        page_map_level_4[i] = 0;
        page_directory_pointer_table[i] = 0;
        page_directory[i] = 0;
        page_table[i] = 0;
    }

    // setting up the page map tables are pretty easy at this stage
    // the first three just have the one entry that memmap to the
    // next level down, and the page table just does the
    // memory map.
    // Don't ask me how the memory map works because
    // even with OSDev I got no fucking clue.

    page_map_level_4[0] = 0x3 | (uint64_t)page_directory_pointer_table;
    page_directory_pointer_table[0] = 0x3 | (uint64_t)page_directory;
    page_directory[0] = 0x3 | (uint64_t)page_table;

    // Maybe it doesn't work.
    // We'll see when it triple-faults.
    // lol.
    return PT_INIT();
}

// yk we need a proper GDT too right?
static inline int32_t GDT_INIT_64(void) {
    GDT_64[0] = 0ULL; // null descriptor
    GDT_64[1] = PRESENT_GDT | DESCRIPTOR_TYPE | EXECUTABLE | READ_WRITE | LONG_MODE | GRANULARITY | LIMIT; // code segment
    GDT_64[2] = PRESENT_GDT | DESCRIPTOR_TYPE | READ_WRITE | GRANULARITY | LIMIT; // data segment
    return 0;
}

// NO I AM NOT DOING FUCKING PML5 TAKE YOUR PML5 AND SHOVE IT UP YOUR ASS


#endif // LONGMODE_H