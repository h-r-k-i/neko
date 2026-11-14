[bits 16]

%if 0
 FILENAME:      ./boot/s3/drivers/disk.s
 NAME:          SBL, Stage 3 disk driver functions
 DESCRIPTION:   Have you ever cooked half a brick in the air fryer?
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

global GetSector, GetDriveParameters

GetDriveParameters:
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; [bp + 0x0A]: drive number (uint8_t)

    push bp
    mov bp, sp
    push es
    push di
    push bx
    push ds
    push si

    mov ds, arg_segment
    mov si, arg_offset
    mov dl, [bp + 0x0A] ; drive number
    mov ah, 0x48
    int 0x13

    mov al, ah
    xor ah, ah

    pop si
    pop ds
    pop bx
    pop di
    pop es
    pop bp
    retf

GetSector:
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; [bp + 0x0A]: drive number (uint8_t)

    push bp
    mov bp, sp
    push es
    push di
    push bx
    push ds
    push si

    mov ds, arg_segment
    mov si, arg_offset
    mov dl, [bp + 0x0A] ; drive number
    mov ah, 0x42
    int 0x13

    mov al, ah
    xor ah, ah
    
    .GetSector_END:
        pop si
        pop ds
        pop bx
        pop di
        pop es
        pop bp
        retf ; could've just done rets everywhere else this is stupid