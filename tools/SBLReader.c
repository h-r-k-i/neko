#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

#define MAP_START   0x3000
#define MAP_END     0x8000


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


int main(int argc, char *argv[]) {
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
    if (present & 0x1ULL <<  0) printf("\tMemory map\n");
    if (present & 0x1ULL <<  2) printf("\tText framebuffer\n");
    if (present & 0x1ULL <<  3) printf("\tVideo framebuffer\n");
    if (present & 0x1ULL <<  4) printf("\tProtected mode\n");
    if (present & 0x1ULL <<  5) printf("\tEntropy\n");
    if (present & 0x1ULL <<  6) printf("\tFloating-point\n");
    if (present & 0x1ULL <<  7) printf("\tACPI\n");
    if (present & 0x1ULL <<  8) printf("\tSMBIOS\n");
    if (present & 0x1ULL <<  9) printf("\tUEFI\n");
    if (present & 0x1ULL << 10) printf("\tBootloader\n");
    if (present & 0x1ULL << 11) printf("\tTopology\n");
    if (present & 0x1ULL << 12) printf("\tGDT\n");
    if (present & 0x1ULL << 13) printf("\tVM\n");
    if (present & 0x1ULL << 16) printf("\tRTC\n");
    if (present & 0x1ULL << 17) printf("\tDisplay\n");
    if (present & 0x1ULL << 18) printf("\tSerial\n");
    if (present & 0x1ULL << 63) printf("\tIdentity\n");
    printf("\n");

    if(fseek(file, data.first, SEEK_SET) != 0) {
        perror("Seek failure");
        fclose(file);
        return -1;
    }

    SBL_Node node;

    /* manual seeking yayyyyyyyyyyyyyyyyyy */

    // Memory map
    {
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

                switch (entry.Type) {
                    case 0x01: puts("Memory available to the OS\n"); break;
                    case 0x02: puts("System-Reserved Memory\n"); break;
                    case 0x03: puts("ACPI memory reclaimable after an ACPI table read\n"); break;
                    case 0x04: puts("ACPI memory not reclaimable\n"); break;
                    case 0x05: puts("Bad memory\n"); break;
                    default: puts("Unknown memory, likely reserved.\n"); break;
                }
            }
        }

    }

    // stuff

    // exit
    fclose(file);
    return 0;
}