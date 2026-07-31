#include <stdint.h>

void kernel_main(void) {
    uint16_t * vmem = (uint16_t *)0xB8000;

    const char * msg = "test from neko kernel_main(). if this is shown, we are in neko 64-bit kernel space          ";
    for (int i = 0; msg[i] != '\0'; i++) {
        vmem[i] = (uint16_t)msg[i] | 0x0F00; // White on Black
    }
    while (1) { asm("hlt"); }
}