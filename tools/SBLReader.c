#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>
#include <string.h>

#define MAP_START   0x4000


uint32_t min(uint32_t a, uint32_t b) {
    return (a < b) ? a : b;
}

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


// Memory map:
typedef struct __attribute__((packed)) {
    uint16_t validation;
    uint16_t extended_1k;
    uint16_t extended_64k;
    uint16_t configured_1k;
    uint16_t configured_64k;
} E801h_Map;

typedef struct __attribute__((packed)) {
    uint16_t validation;
    uint16_t highermem;
} E88h_Map;

typedef struct __attribute__((packed)) {
    uint16_t validation;
    uint16_t size;
} E820h_Map_Header;

typedef struct __attribute__((packed)) {
    uint64_t Address;
    uint64_t Size;
    uint32_t Type;
    uint32_t RESERVED;
} E820h_Map_Entry;

// 128-bit-aligned map this sucks i dont even think i need the
// vers numbers but theyre here im fucking tired 128-bit-aligned
// if you hate it write your own shitty catgirl-themed bootloader
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


uint32_t main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <mem.bin>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "rb");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    if(fseek(file, MAP_START, SEEK_SET) != 0) {
        perror("Seek failure");
        fclose(file);
        return -1;
    }

    SBL_Data data;
    if (fread(&data, sizeof data, 1, file) != 1) {
        perror("Read failure");
        fclose(file);
        return 1;
    }

    char magic[9] = {0};
    for (int i = 7; i >= 0; i--) {
        char byte = (data.magic >> (i * 8)) & 0xFF;
        if (byte < 32 || byte > 126) magic[i] = '.';
        else magic[i] = byte;
    }

    printf("Magic: 0x%016" PRIx64 " (%s)\n", data.magic, magic);
    printf("Checksum: 0x%016" PRIx64, data.checksum);
    if (data.checksum + data.magic + data.flags + data.sgalf == 0xFFFFFFFFFFFFFFFF) {
        printf(" (valid)\n");
    } else {
        printf(" (invalid)\n");
    }
    printf("Flags: 0x%016" PRIx64 "\n", data.flags);
    printf("Antiflags: 0x%016" PRIx64 "\n", data.sgalf);
    printf("First data point: 0x%016" PRIx64 "\n\n", data.first);

    uint64_t present = data.flags | data.sgalf;
    printf("Present data:\n");
    printf("\tMemory map");
    if (data.flags & (0x1ULL <<  0) && data.sgalf & (0x1ULL <<  0)) printf(" (failed)");
    if (data.flags & (0x1ULL <<  0) && data.sgalf & (0x1ULL <<  1)) printf(" (88h format)");
    if (data.flags & (0x1ULL <<  1) && data.sgalf & (0x1ULL <<  0)) printf(" (legacy format)");
    if (data.flags & (0x1ULL <<  1) && data.sgalf & (0x1ULL <<  1)) printf(" (modern format)");
    printf("\n");
    if (present & 0x1ULL <<  4) printf("\tCPU Features");
    if (data.flags & (0x1ULL <<  4) && data.sgalf & (0x1ULL <<  4)) printf(" (malformed)");
    printf("\n");
    if (present & 0x1ULL <<  7) printf("\tFirmware");
    if (data.flags & (0x1ULL <<  7) && data.sgalf & (0x1ULL <<  7)) printf(" (malformed)");
    printf("\n");
    if (present & 0x1ULL << 17) printf("\tDisplay");
    if (data.flags & (0x1ULL << 17) && data.sgalf & (0x1ULL << 17)) printf(" (malformed)");
    printf("\n");
    if (present & 0x1ULL << 62) printf("\tBootloader");
    if (data.flags & (0x1ULL << 62) && data.sgalf & (0x1ULL << 62)) printf(" (malformed)");
    printf("\n");
    if (present & 0x1ULL << 63) printf("\tIdentity");
    if (data.flags & (0x1ULL << 63) && data.sgalf & (0x1ULL << 63)) printf(" (malformed)");
    printf("\n");

    if (fseek(file, data.first, SEEK_SET) != 0) {
        perror("Seek failure");
        fclose(file);
        return -1;
    }

    SBL_Node node;

    /* manual seeking yayyyyyyyyyyyyyyyyyy */

    // Memory map
    if (present & 0x1ULL <<  0) {
        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        if ((data.flags & (0x1ULL << 0)) == 0) {
            if ((data.sgalf & (0x1ULL << 0)) == 0) {
                printf("Hi. It's the tfem who wrote this entire thing. I don't know what you're trying to do but if it's involving SBL then the memory map is absolutely bullshit right now. I highly recommend you use a virtual machine that was written *after* Babbage designed his Difference Engine.\n");
                printf("Error: :3 :joy: :index_pointing_at_the_viewer:\n");
                return 69;
            }
            else {
                // todo: 88h map
                E88h_Map map;
                if (fseek(file, node.data, SEEK_SET) != 0) {
                    perror("Seek failure");
                    fclose(file);
                    return -1;
                }
                if (fread(&map, sizeof map, 1, file) != 1) {
                    perror("Read failure");
                    fclose(file);
                    return 1;
                }
                printf("Memory map is legacy INT 15h AX=88h format.\n");
                printf("Memory map data:\n");
                printf("\tValidation: 0x%04" PRIx16 "\n", map.validation);
                printf("\tMemory above 1MiB: %u KB\n", map.highermem);
            }
            fclose(file);
            return 0;
        }

        if (data.sgalf & 0x1ULL << 0) {
            E801h_Map map;
            if (fseek(file, node.data, SEEK_SET) != 0) {
                perror("Seek failure");
                fclose(file);
                return -1;
            }

            if (fread(&map, sizeof map, 1, file) != 1) {
                perror("Read failure");
                fclose(file);
                return 1;
            }

            printf("Memory map is legacy AX=E801h format.\n");
            printf("Memory map data:\n");
            printf("\tValidation: 0x%04" PRIx16 "\n", map.validation);
            printf("\tExtended memory past 1MiB (1k blocks): %u blocks\n", map.extended_1k);
            printf("\tExtended memory past 16MiB (64k blocks): %u blocks\n", map.extended_64k);
            printf("\tConfigured memory past 1MiB (1k blocks): %u blocks\n", map.configured_1k);
            printf("\tConfigured memory past 16MiB (64k blocks): %u blocks\n", map.configured_64k);

            uint64_t total_memory = 0x100000ULL + ((uint64_t)map.extended_1k * 1024) + ((uint64_t)map.extended_64k * 65536);
            uint64_t usable_memory = 0x100000ULL + ((uint64_t)map.configured_1k * 1024) + ((uint64_t)map.configured_64k * 65536);

            printf("True size of memory: %llu bytes\n", total_memory);
            printf("Usable memory: %llu bytes\n", usable_memory);
        }
        else {
            E820h_Map_Header header;
            E820h_Map_Entry entry;
            if (fseek(file, node.data, SEEK_SET) != 0) {
                perror("Seek failure");
                fclose(file);
                return -1;
            }

            if (fread(&header, sizeof header, 1, file) != 1) {
                perror("Read failure");
                fclose(file);
                return 1;
            }

            // header.size++; // some straight bullshit tends to happen so we just increment the size by 1 to account for it

            printf("Memory map is E820h format.\n");
            printf("Memory map data:\n");
            printf("\tValidation: 0x%04" PRIx16 "\n", header.validation);
            printf("\tTotal entry count: %" PRIu16 " entries\n\n", header.size);
            uint64_t total_memory = 0;

            for (uint16_t ID = 0; ID < header.size; ID++) {
                if (fread(&entry, sizeof entry, 1, file) != 1) {
                    perror("Read failure");
                    fclose(file);
                    return 1;
                }
                printf("\tMemory Map Entry %" PRIu16 ":\n", ID + 1);
                printf("\tAddress: 0x%016" PRIx64 "\n", entry.Address);
                printf("\tSize: %" PRIu64 " bytes\n", entry.Size);
                printf("\tType: ");

                total_memory += entry.Size;

                switch (entry.Type) {
                    case 0x01: puts("Memory available to the OS\n"); break;
                    case 0x02: puts("System-Reserved Memory\n"); break;
                    case 0x03: puts("ACPI memory reclaimable after an ACPI table read\n"); break;
                    case 0x04: puts("ACPI memory not reclaimable\n"); break;
                    case 0x05: puts("Bad memory\n"); break;
                    default: puts("Unknown memory, likely reserved.\n"); break;
                }
            }

            printf("Total memory size: %" PRIu64 " bytes\n", total_memory);
        }

    }
    else {
        perror("What kind of fucking system are you using???");
        fclose(file);
        return 0x4655434B; // FUCK
    }

    putchar('\n');

    // Long mode and entropy data
    if (present & 0x1ULL <<  4) {
        if (fseek(file, node.next, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        uint64_t fgr = 0x0000;
        if (fseek(file, node.data, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&fgr, sizeof fgr, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        fgr & (0x1ULL << 0) ? printf("CPUID is available.\n") : printf("CPUID is not validated.\n");
        fgr & (0x1ULL << 1) ? printf("Long mode is available.\n") : printf("Long mode is not validated.\n");
        fgr & (0x1ULL << 2) ? printf("RDRAND is available.\n") : printf("RDRAND is not validated.\n");
    }

    putchar('\n');

    // Firmware data
    if (present & 0x1ULL <<  7) {
        if (fseek(file, node.next, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        SBL_FirmwareMap fm;
        if (fseek(file, node.data, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }
        if (fread(&fm, sizeof fm, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        printf("Firmware data:\n");
        printf("\tMagic: %.8s\n", fm.magic);
        printf("\tEntries: %" PRIu64 "\n", fm.entry_count);
        if (fm.entry_count == 0 || fm.entry_count > 8 ||
            fm.resv1 != 0 || fm.resv2 != 0 || memcmp(fm.magic, "gon.kms!", 8) != 0) {
            printf("\tNo valid ACPI/SMBIOS data present.\n");
        }
        printf("\n");
        printf("\tRSDP Pointer: 0x%08" PRIx32 "\n", fm.RSDPPointer);
        printf("\tRSDP Length: %" PRIu32 " bytes\n", fm.RSDPLength);\
        printf("\tSMBIOS Pointer: 0x%08" PRIx32 "\n", fm.SMBIOSPointer);
        printf("\tSMBIOS Length: %" PRIu32 " bytes\n", fm.SMBIOSLength);
    }

    putchar('\n');

    // Display data
    if (present & 0x1ULL << 17) {
        if (fseek(file, node.next, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        printf("\tVBE info block at 0x%04" PRIx16 "\n", node.data);
    }

    putchar('\n');

    // Bootloader data
    if (present & 0x1ULL << 62) {
        if (fseek(file, node.next, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }
    }

    putchar('\n');
    
    // Bootloader identity statement
    if (present & 0x1ULL << 63) { // this should always work but who knows
        if (fseek(file, node.next, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&node, sizeof node, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }
        printf("Bootloader identity statement:\n");
        SBL_Identity identity;
        if (fseek(file, node.data, SEEK_SET) != 0) {
            perror("Seek failure");
            fclose(file);
            return -1;
        }

        if (fread(&identity, sizeof identity, 1, file) != 1) {
            perror("Read failure");
            fclose(file);
            return 1;
        }

        printf("\tMagic: %.4s\n", identity.magic);
        printf("\tName: %.4s\n", identity.name);
        printf("\tProduced by: %.3s v%u.%u.%u\n", identity.name, identity.version.year, identity.version.week, identity.version.day);
        printf("\tContract: SBLc v%u.%u\n", identity.contract.year, identity.contract.month);
    }

    // exit
    fclose(file);
    return 0;
}