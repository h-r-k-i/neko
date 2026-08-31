/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s2/s2.h
 * NAME:        SBL, Stage 2 || Bootloader Functions Header
 * DESCRIPTION: the helper file has turned into the second stage god end my suffering
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        25 August 2025
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include <stdint.h>

/// Constants

#ifdef DEBUG
    #define RETVAL 177
#else
    #define RETVAL 0
#endif // ifdef DEBUG

#define E820_MAX_ENTRIES 128
#define E820_ENTRY_SIZE 24

/// Macros


/// Structures

typedef struct __attribute__((packed)) {
    uint64_t magic;
    uint64_t checksum;
    uint64_t flags;
    uint64_t sgalf;
    uint64_t first;
} SBL_Data;

typedef struct __attribute__((packed)) {
    uint16_t data;
    uint16_t next;
} SBL_Node;

typedef struct __attribute__((packed)) {
    uint16_t magic;
    uint16_t entry_count;
    uint16_t first; // This exists solely to point to the first memory map entry; it'll end up being occupied by part of the first memmap entry. Do not use for ANYTHING ELSE.
} SBL_E820_Header;

typedef struct __attribute__((packed)) {
    uint16_t magic;
    uint16_t extended_memory_1k;
    uint16_t extended_memory_64k;
    uint16_t configured_memory_1k;
    uint16_t configured_memory_64k;
} SBL_E801_Map;

typedef struct __attribute__((packed)) {
    uint16_t magic;
    uint16_t memory_above_1M;
} SBL_88_Map;

/// Function Prototypes
// External
extern uint16_t SBL_E820(uint32_t segment_offset, uint32_t* continuation_val);
extern uint16_t SBL_E801(uint32_t segment_offset);
extern uint16_t SBL_88(uint32_t segment_offset);

// Internal
SBL_Node* _SBL_NodeMap_fw(SBL_Node* node);
void SBL_memcpy(void* dest, const void* src, uint16_t count);