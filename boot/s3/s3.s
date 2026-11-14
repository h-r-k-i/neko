[bits 16]
global _start
extern s3_main

%macro cpush 1
    push word 0
    push word %1
%endmacro

%macro ccall 1
    push word 0
    call %1
%endmacro

%if 0
 FILENAME:      ./boot/s3.s
 NAME:          SBL, Stage 3
 DESCRIPTION:   Does the part where I pretend my problems don't exist
                and does a bunch of unreal mode prep before handing 
                over control to the kernel.
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          12 November 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

section .text

_start:
    cli
    cld
    mov  esp, 0xF000

    mov  [boot_eax], eax
    mov  [boot_ebx], ebx
    and  edx, 0xFF
    mov  [boot_edx], edx

    ; mov ax, 0x0F41 ; white on black 'A'
    ; mov ebx, 0xB8000
    ; mov [ebx], ax
    ; ; jmp $

    push dword [boot_edx]
    push dword [boot_ebx]
    push dword [boot_eax]
    ccall s3_main

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

gdtinfo:
    dw gdt_end - gdt - 1
    dd gdt

gdt:
    dq 0x0000000000000000   ; null descriptor
    dq 0x00009A000000FFFF   ; flat code segment
    dq 0x00CF92000000FFFF   ; flat data segment
gdt_end:

section .bss
align 4
boot_eax resd 1
boot_ebx resd 1
boot_edx resd 1