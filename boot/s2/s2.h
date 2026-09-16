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

#define SBL_IDENTITY_MAGIC "NEKO"
#define SBL_IDENTITY_NAME "SBLi"

#define VERSION_YEAR 26
#define VERSION_WEEK 36
#define VERSION_DAY 4

#define CONTRACT_YEAR 26
#define CONTRACT_MONTH 9

#define SBL_BOOTLOADER_MAP_COUNT 13
#define SBL_BOOTLOADER_FREE 1
#define SBL_BOOTLOADER_RESERVED 2
#define SBL_BOOTLOADER_INUSE 3
#define SBL_BOOTLOADER_CRITICAL 4


/// Structures

typedef struct __attribute__((packed)) {
    char magic[8];
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
    uint16_t first; // This exists solely to guide the first memory map entry; it'll end up being occupied by part of the first memmap entry. Do not use for ANYTHING ELSE.
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

typedef struct __attribute__((packed)) {
    char magic[8];
    uint64_t entry_count;

    uint32_t RSDPPointer;
    uint32_t RSDPLength;
    uint64_t resv1;

    uint32_t SMBIOSPointer;
    uint32_t SMBIOSLength;
    uint64_t resv2;
} SBL_FirmwareMap;

typedef struct __attribute__((packed)) {
    uint8_t year; // something something y2k
    uint8_t week;
    uint8_t day;
} SBL_BootloaderVersion;

typedef struct __attribute__((packed)) {
    uint8_t year;
    uint8_t month;
} SBL_ContractVersion;

typedef struct __attribute__((packed)) {
    char magic[4];
    char name[4];
    SBL_BootloaderVersion version;
    SBL_ContractVersion contract;

} SBL_Identity;

typedef struct __attribute__((packed)) {
    char Signature[16];
    uint32_t VGAPointer;
    uint32_t count;
    uint32_t VGAModePointer;
    uint32_t resv;
} SBL_DisplayInfoBlock;

typedef struct __attribute__((packed)) {
    uint64_t Address;
    uint64_t Size;
    uint32_t Status;
} SBL_BootloaderMemoryMapEntry;

typedef struct __attribute__((packed)) {
    char Signature[16];
    uint32_t count;
    SBL_BootloaderMemoryMapEntry entries[SBL_BOOTLOADER_MAP_COUNT];
} SBL_BMM;

/// Function Prototypes
// External
extern uint16_t SBL_E820(uint32_t segment_offset, uint32_t* continuation_val);
extern uint16_t SBL_E801(uint32_t segment_offset);
extern uint16_t SBL_88(uint32_t segment_offset);
extern uint16_t SBL_LM_Entropy(void);
extern uint16_t PopulateVBEInfo(uint32_t segment_offset);
extern uint16_t PopulateVBEMode(uint32_t segment_offset, uint32_t mode);

// Internal
SBL_Node* _SBL_NodeMap_fw(SBL_Node* node);
void SBL_memcpy(void* dest, const void* src, uint32_t count);