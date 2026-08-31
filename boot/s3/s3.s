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

section .multiboot
align 8

; Multiboot 1
MB1_MAGIC equ 0x1BADB002
MB1_FLAGS equ 0x00000003
MB1_CHECKSUM equ -(MB1_MAGIC + MB1_FLAGS)

align 4
dd MB1_MAGIC
dd MB1_FLAGS
dd MB1_CHECKSUM

; Multiboot 2
MB2_MAGIC equ 0xE85250D6
MB2_ARCHITECTURE equ 0x00000000
MB2_HEADER_LENGTH equ (mb2_header_end - mb2_header_start)
MB2_CHECKSUM equ -(MB2_MAGIC + MB2_ARCHITECTURE + MB2_HEADER_LENGTH)

align 8
mb2_header_start:
    dd MB2_MAGIC
    dd MB2_ARCHITECTURE
    dd MB2_HEADER_LENGTH
    dd MB2_CHECKSUM

    dw 0
    dw 0
    dd 8
mb2_header_end:

times (0x8000 - 0x7F00) - ($ - $$) db 0

section .text

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

    mov esp, 0xF000

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