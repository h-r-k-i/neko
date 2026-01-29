bits 32
global _start

_start:
    mov edi, 0xB8000
    mov eax, 0x0F4B0F4F
    mov [edi], eax

hang:
    hlt
    jmp hang