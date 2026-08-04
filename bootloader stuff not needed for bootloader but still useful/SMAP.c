/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/SMAP.c
 * NAME:        SBL, Stage 3 || System Memory Map Parser
 * DESCRIPTION: When SBL S2 produces a map using E820 or whatever method it might
 *              use to produce the memory map this program is used to convert the
 *              memory map from a list of bytes in real mode memory to actual
 *              structures that may be used to determine the mapping of memory
 *              pages when setting up long mode.
 * 
 * TODO:        Handle GRUB's memory map.
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "SMAP.h"

uint8_t GetMapSize() { // syfm about using uint8_t
    return E820_MAP_COUNT;
}

bytemap volatile * GetEntry(uint8_t entry) {
    if (entry >= E820_MAP_COUNT || E820_MAP_COUNT == 0) return NULL;
    return &((volatile bytemap *)ENTRY_START)[entry];
}