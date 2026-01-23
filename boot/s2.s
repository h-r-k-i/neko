[bits 16]
[org 0x0000]

%if 0
 FILENAME:      ./boot/s2.s
 NAME:          NekoDOS Bootloader, Stage 2
 DESCRIPTION:   Sets up the device for booting into the kernel, exits Real Mode,
                and boots Stage 3
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          22 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

start:
    mov ah, 0x03
    int 0x10
    mov ah, 0x13
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov cx, m1l
    push cs
    pop es
    mov bp, m1
    int 0x10

    ; S1: Set stack pointer.

    ; S2: Query BIOS for size of lower and upper memory.

    ; S3: Read kernel from disk to lower memory.

    ; S4: Enable A20 line.

    ; S5: Disable interrupts.

    ; S6: Set up Global Descriptor Table ahead of Protected Mode

    ; S7: Finally enter Protected Mode

    ; S8: Jump to Stage 3

m1 db 'Stage 2 loaded, processing neko...', 0x0a, 0x0d, 0x00
m1l equ $ - m1

times (0x3200 - 0x1000) - ($ - $$) - 2 db 0
dw 0xABAB