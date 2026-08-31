/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s2/s2.c
 * NAME:        SBL, Stage 2 || Bootloader Functions
 * DESCRIPTION: Helper functions for the second-stage bootloader
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        25 August 2025
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "s2.h"

uint16_t c_add(uint16_t a, uint16_t b) {
    return a + b;
}

// typedef struct __attribute__((packed)) {
//     uint64_t magic;
//     uint64_t checksum;
//     uint64_t flags;
//     uint64_t sgalf;
//     uint64_t first;
// } SBL_Data;

uint16_t sbl_build(uint16_t location) {
    // build SBL data structure at the specified location
    uint64_t* head_64 = (uint64_t*)location;
    SBL_Data* bootloader_header = (SBL_Data*)location;

    // Build the SBL data structure
    /**
     * Structure:
     * 0x0000-0x0003: Magic number (64-bit, always 0x4B4F4E45)
     * 0x0004-0x0007: Checksum (64-bit, sum of all fields should be 0xFFFFFFFFFFFFFFFF)
     * 0x0008-0x000B: Flags (64-bit, bitfield indicating which data is present)
     * 0x000C-0x000F: Antiflags (64-bit, bitfield indicating which data is errors)
     * 0x0010-0x0013: First data point (64-bit, offset to the first data structure)
     */

    bootloader_header->magic = 0x4B4F4E45; // Magic number
    bootloader_header->checksum = 0;          // Checksum (to be calculated later)
    bootloader_header->flags = 0;          // Flags (to be set later)
    bootloader_header->sgalf = 0;          // Antiflags (to be set later)
    bootloader_header->first = 0x3040;     // First data point, set to 0x3040 because i can

    // Data structures are initially built at 0x3040 and each are in total 32-bit
    SBL_Node* SBL_NodeMap = (SBL_Node*)(bootloader_header->first);
    SBL_NodeMap->data = (uint16_t)SBL_NodeMap + sizeof(SBL_Node); // Memory map loc
    // because we're in C-land we can do some straight bullshit
    SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 2 * sizeof(uint16_t) + E820_ENTRY_SIZE * E820_MAX_ENTRIES);

    // Build memory map
    SBL_E820_Header* header = (SBL_E820_Header*)(SBL_NodeMap->data & 0xFFFF); // thank you 32-bit pointers
    header->magic = 0xE820; // We're being hopeful right now and assuming this system isn't fucking ancient
    header->entry_count = 1; // Amount of entries, updated later
    uint32_t segment_offset = 0x0000 << 16 | (uint16_t)(&header->first); // segment:offset or smth idfk this is bullshit
    uint32_t continuation_val = 0; // initial continuation value is always 0 when starting and will be 0 when the map is done
    uint16_t resb = SBL_E820(segment_offset, &continuation_val);

    if (!resb && continuation_val != 0) {
        bootloader_header->flags |= 0x1;
        do {
            segment_offset += E820_ENTRY_SIZE;
            resb = SBL_E820(segment_offset, &continuation_val);
            if (resb != 14 && resb) break;
            header->entry_count++;
        } while (continuation_val != 0 && header->entry_count < E820_MAX_ENTRIES);
    }
    if (resb) switch (resb) {
        case 1:
            // E820 may have actually succeeded
            if (header->entry_count > 1) break; // if we have more than one entry we're probably good
        default:
            {
                bootloader_header->sgalf |= 0x1; // Mark memory map as being shid
                SBL_E801_Map* e801_map = (SBL_E801_Map*)(SBL_NodeMap->data & 0xFFFF);
                e801_map->magic = 0xE801; // Magic number for E801 map
                segment_offset = 0x0000 << 16 | (uint16_t)(&e801_map->extended_memory_1k); // start of the memory info
                resb = SBL_E801(segment_offset); // god help us all
                if (!resb) {
                    bootloader_header->flags |= 0x1; // Mark decent memory map as successfully built
                    SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 5 * sizeof(uint16_t));
                    break;
                }
                // there is no god
                SBL_88_Map* sbl88 = (SBL_88_Map*)(SBL_NodeMap->data & 0xFFFF);
                sbl88->magic = 0x0088; // Magic number for SBL 88 map
                segment_offset = 0x0000 << 16 | (uint16_t)(&sbl88->memory_above_1M); // start of the memory info
                resb = SBL_88(segment_offset);
                if (!resb) {
                    SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 2 * sizeof(uint16_t));
                    break;
                }
                bootloader_header->sgalf &= (~0x0001);
                return RETVAL; // gen atp wtf are we supposed to do
            }
    }
    else {
        SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 2 * sizeof(uint16_t) + E820_ENTRY_SIZE * header->entry_count);
    }
    // Build video framebuffer info
    // SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    // Build text framebuffer info
    // Build protected mode info
    // Build entropy info
    // Build floating-point info
    // Build ACPI info
    // Build SMBIOS info
    // Build UEFI info
    // Build bootloader info
    // Build topology info
    // Build GDT info
    // Build virtual machine info
    // Build real time clock info
    // Build display info
    // Build serial bus info
    // Build bootloader identity info
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    SBL_NodeMap->data = (uint16_t)(SBL_NodeMap + 1);
    SBL_NodeMap->next = 0x0000; // fuck it write straight into the fucking IVT
    char id[] = "SBL v26.34.1";
    SBL_memcpy((void*)SBL_NodeMap->data, id, 12);
    bootloader_header->flags |= 1ULL << 63;

    // Calculate checksum
    bootloader_header->checksum = 0xFFFFFFFFFFFFFFFF;
    bootloader_header->checksum -= bootloader_header->magic + bootloader_header->flags + bootloader_header->sgalf;

    return RETVAL;
}

SBL_Node* _SBL_NodeMap_fw(SBL_Node* node) {
    return (SBL_Node*)(node->next);
}

void SBL_memcpy(void* dest, const void* src, uint16_t count) {
    char* d = (char*)dest;
    const char* s = (const char*)src;
    for (uint16_t i = 0; i < count; i++) {
        d[i] = s[i];
    }
}