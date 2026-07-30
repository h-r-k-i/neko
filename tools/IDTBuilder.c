#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

int main() {
    uint8_t errProd[] = {
        0x08,
        0x0a,
        0x0b,
        0x0c,
        0x0d,
        0x0e,
        0x11,
        0x15,
        0x00
    };
    for (uint16_t i = 0; i < 256; i++) {
        printf("global isr%i\n", i);
        printf("isr%i:\n", i);
        printf("\tcli\n");
        uint16_t j = 0;
        while (errProd[j] != 0x00) {
            if (errProd[j++] == i) break;
        }
        if (errProd[j] == 0x00) printf("\tpush 0\n");
        printf("\tpush %i\n\tjmp isr_common\n\n", i);
    }

    printf("section .data\n");
    printf("global isr_table\n");
    printf("isr_table:\n");
    for (uint16_t i = 0; i < 256; i++) {
        printf("\tdd isr%i\n", i);
    }
}