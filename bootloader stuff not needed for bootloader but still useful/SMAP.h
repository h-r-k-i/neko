/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/SMAP.h
 * NAME:        SBL, Stage 3 || System Memory Map Parser Relevant Header
 * DESCRIPTION: see ../SMAP.c
 * 
 * TODO:        see ../SMAP.c
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/


#ifndef SMAP_H
#define SMAP_H

#include <stdint.h>
#include "consoleio.h"
#include <stddef.h>

#define MAP_START 0x7000
#define ENTRY_START 0x7004
#define MAP_END 0x8000

#define E820_MAP_COUNT (*(volatile uint8_t *)(MAP_START + 0))

typedef struct __attribute((packed)) {
    uint64_t ADDRESS;
    uint64_t SIZE;
    uint32_t TYPE;
    uint32_t ACPI_EXTENDED;
} bytemap;

extern uint8_t GetMapSize();
extern bytemap volatile * GetEntry(uint8_t entry);
#endif