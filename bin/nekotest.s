bits 64
global _start64
extern kernel_main

_start64:
    mov edi, 0xB8000
    mov word [rdi],     0x0F4F  ; 'O' (0x4F), White on Black (0x0F)
    mov word [rdi + 2], 0x0F4B  ; 'K' (0x4B), White on Black (0x0F)
    mov word [rdi + 4], 0x0F21  ; '!' (0x21), White on Black (0x0F)

    call kernel_main

hang:
    hlt
    jmp hang