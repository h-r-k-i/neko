bits 32
global _start
extern s3_main

%if 0
 FILENAME:      ./boot/s3.s
 NAME:          NekoDOS Bootloader, Stage 3.1
 DESCRIPTION:   Exists as a temporary program to
                verify transfer into Protected Mode
                and transfer control to s3.c.
                A stub, basically.
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          29 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

_start:
    cli
    cld

    mov [boot_eax], eax
    mov [boot_ebx], ebx
    and edx, 0x000000FF
    mov [boot_edx], edx
    
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0xF000 - 1

    push dword [boot_edx]
    push dword [boot_ebx]
    push dword [boot_eax]
    call s3_main

hang:
    hlt
    jmp hang

a3 db 'hi hi hi hi hi hi hi hi hi hi', 0x0a, 0x0d, 0x00

section .bss
align 4
boot_eax resd 1
boot_ebx resd 1
boot_edx resd 1


times (0xC800 - 0x8000) - ($ - $$) - 4 resb 0
dd 0x75726168