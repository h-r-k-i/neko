bits 16
global _start
extern s3_main

%if 0
 FILENAME:      ./boot/s3.s
 NAME:          NekoDOS Bootloader, Stage 3.1
 DESCRIPTION:   Exists as a temporary program to
                verify transfer into Protected Mode
                and transfer control to s3.cpp.
                A stub, basically.
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          29 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

section .text

_start:
    ; cli
    cld

    ; jmp hang
    
    mov [boot_eax], eax
    mov [boot_ebx], ebx
    and edx, 0x000000FF
    mov [boot_edx], edx
    
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov sp, 0xF000

    ; mov ax, 0x0761 ; white on black 'a'
    ; mov ebx, 0xB8000
    ; mov [ebx], ax
    ; jmp $


    push dword [boot_edx]
    push dword [boot_ebx]
    push dword [boot_eax]
    push word 0
    call s3_main

hang:
    mov ah, 0x13
    xor dx, dx
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov cx, a3l
    push ds
    pop es
    mov bp, a3
    int 0x10
    inc dh
    mov [row], dh
    hlt
    jmp hang

a3 db 'hi hi hi hi hi hi hi hi hi hi', 0x0a, 0x0d
a3l equ $ - a3

row: db 0

section .bss
align 4
boot_eax resd 1
boot_ebx resd 1
boot_edx resd 1

section .text
times (0xC800 - 0x8000) - ($ - $$) - 4 db 1
dd 0x75726168