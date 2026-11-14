[bits 16]

%if 0
 FILENAME:      ./boot/s3/drivers/pwm.s
 NAME:          SBL, Stage 3 power management functions
 DESCRIPTION:   Power management functions
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          13 November 2026
 COPYRIGHT:     Haruki Media Group (notably a lot of this is still MIT license)
 LICENSE:       MIT License (./LICENSE)
 NOTE:          none
%endif

; renamed arg_segment because segment is an actual nasm keyword
%define arg_segment [bp + 0x08]
; renamed arg_offset to match arg_segment
%define arg_offset [bp + 0x06]

global ShutDownPC

; Returns if failed, otherwise does not return for... obvious reasons
ShutDownPC:
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)

    push bp
    mov bp, sp
    push es
    push di
    push bx
    push ds
    push si

    ; installation check
    mov ax, 0x5300
    xor bx, bx
    int 0x15
    jc .ShutDownPC_END
    cmp bx, 0x504D
    jne .ShutDownPC_END

    ; connect real-mode interface
    mov ax, 0x5301
    xor bx, bx
    int 0x15
    jnc .ShutDownPC_connected
    cmp ah, 0x02
    jne .ShutDownPC_END


    .ShutDownPC_connected:

    ; driver version 1.2 (ignore failure)
    mov ax, 0x530E
    xor bx, bx
    mov cx, 0x0102
    int 0x15

    ; enable PM for all devices
    mov ax, 0x5308
    mov bx, 0x0001
    mov cx, 0x0001
    int 0x15

    ; engage PM
    mov ax, 0x530F
    mov bx, 0x0001
    mov cx, 0x0001
    int 0x15

    ; power off
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
    ; if we're still here... idfk


    .ShutDownPC_END:
    pop si
    pop ds
    pop bx
    pop di
    pop es
    pop bp
    retf