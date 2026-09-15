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

uint8_t SBL_memcmp(const void* dest, const void* src, uint16_t count) {
    const char* d = (const char*)dest;
    const char* s = (const char*)src;
    for (uint16_t i = 0; i < count; i++) {
        if (d[i] != s[i]) return 1; // not equal
    }
    return 0; // equal
}

typedef struct __attribute__((packed)) {
    char Signature[8];
    uint8_t Checksum;
    char OEMID[6];
    uint8_t Revision;
    uint32_t RsdtAddress;
} RSDP;

typedef struct __attribute__((packed)) {
    RSDP rsdp;
    uint32_t Length;
    uint64_t XsdtAddress;
    uint8_t ExtendedChecksum;
    uint8_t Reserved[3];
} XSDP;

typedef struct __attribute__((packed)) {
    char Signature[4];
    uint8_t Checksum;
    uint8_t Length;
    uint8_t MajorVersion;
    uint8_t MinorVersion;
    uint16_t MaxSize;
    uint8_t EPointRevision;
    uint8_t FormatArea[5];
    uint8_t IAString[5];
    uint8_t IChecksum;
    uint16_t STableLength;
    uint32_t STableAddress;
    uint16_t StructCount;
    uint8_t Revision;
} SMBIOS32;

typedef struct __attribute__((packed)) {
    char Signature[5];
    uint8_t Checksum;
    uint8_t Length;
    uint8_t MajorVersion;
    uint8_t MinorVersion;
    uint8_t DocRev;
    uint8_t EPointRevision;
    uint8_t resv;
    uint32_t STableLength;
    uint64_t STableAddress;
} SMBIOS64;

typedef struct __attribute__((packed)) {
    char Signature[4];
    uint16_t Version;
    uint16_t OemStringPtr[2];
    uint8_t Capabilities[4];
    uint16_t VideoModePtr[2];
    uint16_t TotalMemory;
    uint8_t resv[492];
} VBEInfoBlock;

typedef struct __attribute__((packed)) {
    uint16_t Attributes;
    uint8_t Window_A;
    uint8_t Window_B;
    uint16_t Granularity;
    uint16_t WindowSize;
    uint16_t Segment_A;
    uint16_t Segment_B;
    uint32_t WinFuncPtr;
    uint16_t Pitch;
    uint16_t Width;
    uint16_t Height;
    uint8_t WChar;
    uint8_t YChar;
    uint8_t Planes;
    uint8_t bpp;
    uint8_t Banks;
    uint8_t MemoryModel;
    uint8_t BankSize;
    uint8_t ImagePages;
    uint8_t resv1;
    uint8_t RedMask;
    uint8_t RedPosition;
    uint8_t GreenMask;
    uint8_t GreenPosition;
    uint8_t BlueMask;
    uint8_t BluePosition;
    uint16_t resv2;
    uint8_t DirectColorAttributes;
    uint32_t FramebufferAddress;
    uint32_t OffScreenMemOffset;
    uint16_t OffScreenMemSize;
    uint8_t resv3[206];
} VBEModeInfoBlock;

typedef struct __attribute__((packed)) {
    uint64_t Address;
    uint64_t Size;
    uint32_t Type;
    uint32_t RESERVED;
} E820h_Map_Entry;

uint8_t ValidateRSDP(void* rsdp) {
    uint8_t sum = 0;
    uint8_t length = sizeof(RSDP);
    for (uint8_t i = 0; i < length; i++) sum += ((uint8_t*)rsdp)[i];
    if (sum == 0) if (((RSDP*)rsdp)->Revision >= 2) for (uint32_t i = 0; i < ((XSDP*)(rsdp))->Length; i++) sum += ((uint8_t*)rsdp)[i];
    return sum;
}


uint16_t sbl_build(uint16_t location, uint16_t impArea, uint16_t impAreaSize) { // uint16_t idt_location, uint16_t idt_handler_loc, uint16_t gdt_location

    // build SBL data structure at the specified location
    uint64_t* head_64 = (uint64_t*)location;
    SBL_Data* bootloader_header = (SBL_Data*)location;


    _Static_assert(sizeof(VBEModeInfoBlock) == 256, "VBE mode info block is not 256 bytes");
    _Static_assert(sizeof(VBEInfoBlock) == 512, "VBE info block is not 512 bytes");

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
    bootloader_header->first = location + sizeof(SBL_Data);     // First data point

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
        bootloader_header->flags |= 0x1ULL;
        do {
            header->entry_count++;
            segment_offset += E820_ENTRY_SIZE;
            resb = SBL_E820(segment_offset, &continuation_val);
            if (resb != 14 && resb) break;
        } while (continuation_val != 0 && header->entry_count < E820_MAX_ENTRIES);
        SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 2 * sizeof(uint16_t) + E820_ENTRY_SIZE * header->entry_count);
    }
    if (resb) switch (resb) {
        case 1:
            // E820 may have actually succeeded
            if (header->entry_count > 1) break; // if we have more than one entry we're probably good
        default:
            {
                bootloader_header->sgalf |= 0x1ULL; // Mark memory map as being shid
                SBL_E801_Map* e801_map = (SBL_E801_Map*)(SBL_NodeMap->data & 0xFFFF);
                e801_map->magic = 0xE801; // Magic number for E801 map
                segment_offset = 0x0000 << 16 | (uint16_t)(&e801_map->extended_memory_1k); // start of the memory info
                resb = SBL_E801(segment_offset); // god help us all
                if (!resb) {
                    bootloader_header->flags |= 0x1ULL; // Mark decent memory map as successfully built
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
        SBL_NodeMap->next = ((uint16_t)(SBL_NodeMap) + sizeof(SBL_Node) + 2 * sizeof(uint16_t) + E820_ENTRY_SIZE * E820_MAX_ENTRIES);
    }

    // Build long mode and entropy info (later other cpu features maybe)
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    SBL_NodeMap->data = (uint16_t)(SBL_NodeMap + 1);
    SBL_NodeMap->next = SBL_NodeMap->data + sizeof(uint64_t);

    uint64_t* flags_ptr = (uint64_t*)(SBL_NodeMap->data);
    *flags_ptr = 0x0000; // clear the flags

    resb = SBL_LM_Entropy();

    if (!(resb & 0xF000)) {
        bootloader_header->flags |= 0x1ULL << 4; // CPUID available
        *flags_ptr |= 0x1ULL << 0; // CPUID validated
        if (resb & 0x0080) *flags_ptr |= 0x1ULL << 1; // Long mode available
        if (resb & 0x0008) *flags_ptr |= 0x1ULL << 2; // Entropy available
    }
    else bootloader_header->sgalf |= 0x1ULL << 4; // CPUID not validated using the easy way out

    // Build ACPI/SMBIOS data
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    SBL_NodeMap->data = (uint16_t)(SBL_NodeMap + 1);
    SBL_NodeMap->next = SBL_NodeMap->data + sizeof(SBL_FirmwareMap);
    SBL_FirmwareMap* fw = (SBL_FirmwareMap*)(SBL_NodeMap->data);
    // these are cleared to placeholder the values
    // since dealing with rm segmentation makes me want to harm myself and others
    fw->entry_count = 8;

    fw->RSDPPointer = 0x00000000;
    fw->RSDPLength = 0x00000000;
    fw->resv1 = 0x0000000000000000;

    fw->SMBIOSPointer = 0x00000000;
    fw->SMBIOSLength = 0x00000000;
    fw->resv2 = 0x0000000000000000;

    // when done write magic number
    char id2[] = "gon.kms!"; // no null term fuck you
    SBL_memcpy(&(fw->magic), id2, 8);

    // for acpi first try the easy way out
    uint16_t* EBDA = (uint16_t*)(0x40E);
    uint32_t EBDALoc = (uint32_t)(*EBDA) << 4;
    char id3[] = "RSD PTR ";
    uint32_t RSDPLoc = 0;
    if (EBDALoc != 0) {
        for (uint16_t i = 0; i < 0x400; i += 16) {
            if (SBL_memcmp((void*)(EBDALoc + i), id3, 8) == 0) {
                if (ValidateRSDP((void*)(EBDALoc + i)) == 0) {
                    RSDPLoc = EBDALoc + i;
                    break;
                }
            }
        }
    }
    
    // else try the hard way out (which is basically the same thing but in an upper page)
    if (RSDPLoc == 0) {
        for (uint32_t i = 0xE0000; i < 0xFFFFF; i += 16) {
            if (SBL_memcmp((void*)(i), id3, 8) == 0) {
                if (ValidateRSDP((void*)(i)) == 0) {
                    RSDPLoc = i;
                    break;
                }
            }
        }
    }
    if (RSDPLoc != 0) {
        fw->RSDPPointer = RSDPLoc;
        RSDP* rsdp = (RSDP*)(fw->RSDPPointer);
        if (rsdp->Revision >= 2) fw->RSDPLength = ((XSDP*)rsdp)->Length;
        else fw->RSDPLength = sizeof(RSDP);
    }

    // get SMBIOS
    uint32_t SMBIOSLoc = 0;
    // this SHOULD be changed if an SMBIOS is found
    // 82 is chosen arbitrarily; 0x00 and 0xFF indicate
    // the type of SMBIOS found
    uint8_t SMBIOSType = 82;
    for (uint32_t i = 0xF0000; i < 0xFFFFF; i+= 16) {
        if (SBL_memcmp((void*)(i), "_SM_", 4) == 0) {
            SMBIOSLoc = i;
            SMBIOSType = 0; 
            break;
        }
        else if (SBL_memcmp((void*)(i), "_SM3_", 5) == 0) {
            SMBIOSLoc = i;
            SMBIOSType = 0xFF;
            break;
        }
    }

    if (SMBIOSLoc != 0 && SMBIOSType != 82 && ((SMBIOSLoc & 0xF) == 0)) {
        if (SMBIOSType == 0) {
            uint8_t sum = 0;
            for (uint8_t i = 0; i < sizeof(SMBIOS32); i++)
                sum += ((uint8_t*)(SMBIOSLoc))[i];
            
            if (sum == 0) {
                fw->SMBIOSPointer = SMBIOSLoc;
                fw->SMBIOSLength = ((SMBIOS32*)(SMBIOSLoc))->STableLength;
            }
        }
        if (SMBIOSType == 0xFF) {
            uint8_t sum = 0;
            for (uint8_t i = 0; i < sizeof(SMBIOS64); i++)
                sum += ((uint8_t*)(SMBIOSLoc))[i];
            
            if (sum == 0) {
                fw->SMBIOSPointer = SMBIOSLoc;
                fw->SMBIOSLength = ((SMBIOS64*)(SMBIOSLoc))->STableLength;
            }
        }
    }

    bootloader_header->sgalf |= 1ULL << 7; // mark firmware map as done

    // Build display info
    // im gonna fucking cry istfg please stop with the asm torment
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    VBEInfoBlock vbe = {0}; // "yeah just push 512 bytes onto the stack" - the mentally deranged
    SBL_NodeMap->data = (uint16_t)(SBL_NodeMap + 1);
    SBL_DisplayInfoBlock* dib = (SBL_DisplayInfoBlock*)(SBL_NodeMap->data);
    uint16_t rest = PopulateVBEInfo(((uint32_t)&vbe >> 4) << 16 | ((uint32_t)&vbe & 0xF)); // awful
    if (((rest & 0xFF00) == 0) && (rest & 0xFF) == 0x4F) {
        bootloader_header->flags |= 1ULL << 17;
        dib->VGAPointer = (uint32_t)&vbe;
        VBEModeInfoBlock vbeMib = {0}; // once again stack initialization like i can afford that :3
        uint32_t vbeModePointer = vbe.VideoModePtr[0] << 16 + vbe.VideoModePtr[1];
        uint32_t vbeDataPointer = 0x100000;

        // i see we're gonna have to parse our data
        if ((bootloader_header->flags & 0x1) == 0 && (bootloader_header->sgalf & 0x1) == 1) if (((SBL_88_Map*)(((SBL_Node*)(bootloader_header->first))->data))->memory_above_1M < 2048) return -3;
        else if ((bootloader_header->flags & 0x1) == 1 && (bootloader_header->sgalf & 0x1) == 0) {
            E820h_Map_Entry* e820map = (E820h_Map_Entry*)(((SBL_E820_Header*)(((SBL_Node*)(bootloader_header->first))->data))->first);
            uint16_t e7122222222 = 0; // im running out of varnames
            for (uint16_t i = 0; i < ((SBL_E820_Header*)(((SBL_Node*)(bootloader_header->first))->data))->entry_count; i++) {
                if (e820map[i].Address >= 0x100000 && e820map[i].Size >= 0x100000 && e820map[i].Type == 0x01) {
                    e7122222222 = i;
                    vbeDataPointer = e820map[i].Address;
                    break;
                }
            }
        }
        else if ((bootloader_header->flags & 0x1) == 1 && (bootloader_header->sgalf & 0x1) == 1) if (((SBL_E801_Map*)(((SBL_Node*)(bootloader_header->first))->data))->configured_memory_1k < 2048 && ((SBL_E801_Map*)(((SBL_Node*)(bootloader_header->first))->data))->extended_memory_1k < 2048) return -3;
        else return -3; // this state should be impossible

        dib->VGAModePointer = vbeDataPointer;
        dib->count = 0;
        
        for (uint32_t i = 0; ((uint16_t*)(vbeModePointer))[i] != 0xFFFF; i++) {
            rest = PopulateVBEMode(((uint32_t)&vbeMib >> 4) << 16 | ((uint32_t)&vbeMib & 0xF),
                            ((uint16_t*)(vbeModePointer))[i]);
            if ((rest & 0xFF00) != 0) continue;
            SBL_memcpy((void*)vbeDataPointer, &vbeMib, 256);
            vbeDataPointer += 256;
            if (vbeDataPointer >= 0x200000) break;
            dib->count++;
        }

        SBL_memcpy(dib->Signature, "visbvisbvisbvisb", 16);
    }
    else {
        stupidHeaderIPutHereForEase:
            bootloader_header->flags &= ~(1ULL << 17);
            bootloader_header->sgalf |= 1ULL << 17;
            if ((rest >> 8) == 1) SBL_NodeMap->data = 42069;
            else if ((rest >> 8) == 2) SBL_NodeMap->data = 6767;
            else if ((rest >> 8) == 3) SBL_NodeMap->data = 0x6E6F; // just "no"
            else SBL_NodeMap->data = 0x0001;
    }
    SBL_NodeMap->next = SBL_NodeMap->data + sizeof(SBL_DisplayInfoBlock);


    // Build bootloader map info
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    SBL_NodeMap->data = 69; // i am so fucking funny
    SBL_NodeMap->next = (uint16_t)(SBL_NodeMap + 1);
    bootloader_header->sgalf |= 1ULL << 62; // mark bootloader info as complete
    bootloader_header->flags |= 1ULL << 62; // mark bootloader info as incomplete

    
    // Build bootloader identity info
    SBL_NodeMap = _SBL_NodeMap_fw(SBL_NodeMap);
    SBL_NodeMap->data = (uint16_t)(SBL_NodeMap + 1);
    SBL_NodeMap->next = 0x0000; // fuck it write straight into the fucking IVT
    // volatile uint64_t x = bootloader_header->flags;
    // // x |= 1ULL << 63;
    // ((uint32_t*)x)[1] |= 0x80000000U;
    bootloader_header->flags |= 0x1ULL << 63;
    SBL_Identity* identity = (SBL_Identity*)(SBL_NodeMap->data);
    SBL_memcpy(identity->magic, SBL_IDENTITY_MAGIC, sizeof(identity->magic));
    SBL_memcpy(identity->name, SBL_IDENTITY_NAME, sizeof(identity->name));
    identity->version.year = 26;
    identity->version.week = 35;
    identity->version.day = 2;
    identity->contract.year = 26;
    identity->contract.month = 9;
    

    // Calculate checksum
    bootloader_header->checksum = 0xFFFFFFFFFFFFFFFF;
    bootloader_header->checksum -= bootloader_header->magic + bootloader_header->flags + bootloader_header->sgalf;

    return RETVAL;
}

SBL_Node* _SBL_NodeMap_fw(SBL_Node* node) {
    return (SBL_Node*)(node->next);
}

void SBL_memcpy(void* dest, const void* src, uint32_t count) {
    char* d = (char*)dest;
    const char* s = (const char*)src;
    for (uint32_t i = 0; i < count; i++) {
        d[i] = s[i];
    }
}