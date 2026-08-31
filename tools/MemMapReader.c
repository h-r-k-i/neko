#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

#define MAP_START   0x7000
#define MAP_END     0x8000


typedef struct __attribute__((packed)) {
    uint64_t ADDRESS;
    uint64_t SIZE;
    uint32_t TYPE;
    uint32_t RESERVED;
} bytemap;

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
        return -1;
    }

    uint16_t count;

    fread(&count, sizeof count, 1, file);
    printf("Memory Map Count: %" PRIu16 "\n", count);
    fseek(file, 0x7004, SEEK_SET);

    bytemap data;

    for (uint16_t ID = 0; ID < count; ID++) {
        fread(&data, sizeof data, 1, file);
        printf("Memory Map Entry %" PRIu16 ":\n", ID + 1);
        printf("Address: 0x%016" PRIx64 "\n", data.ADDRESS);
        printf("Size: %" PRIu64 " bytes\n", data.SIZE);
        printf("Type: ");

        switch (data.TYPE) {
            case 0x01: puts("Memory available to the OS\n"); break;
            case 0x02: puts("System-Reserved Memory\n"); break;
            case 0x03: puts("ACPI memory reclaimable after an ACPI table read\n"); break;
            case 0x04: puts("ACPI memory not reclaimable\n"); break;
            default: puts("Unknown memory, likely reserved.\n"); break;
        }
    }

    fclose(file);
    return 0;
}