[bits 16]

%if 0
 FILENAME:      ./boot/s3/drivers/io.s
 NAME:          SBL, Stage 3 I/O functions
 DESCRIPTION:   I'd rather be listening to Sewerslvt.
                This does some bullshit with I/O and keyboard
                and whatnot lmao who gives a fuck
 AUTHOR:        Haruki Tokumei, Haruki Media Group (I'm still calling myself
                Haruki Tokumei here because I'm lazy even though atpit everyone
                who sees this repo knows it's Renee Graves)
 DATE:          13 November 2026
 COPYRIGHT:     Haruki Media Group (notably a lot of this is still MIT license)
 LICENSE:       MIT License (./LICENSE)
 NOTE:          none
%endif

; renamed arg_segment because segment is an actual nasm keyword
%define arg_segment [bp + 0x08]
; renamed arg_offset to match arg_segment
%define arg_offset [bp + 0x06]

global GetKeyboardInput, EnableCursor, DisableCursor, SetCursorPosition

GetKeyboardInput:
    ; this function is actually really simple lmao
    ; Get input character
    xor ax, ax
    int 0x16
    xor ah, ah
    retf

EnableCursor:
    xor ax, ax
    mov ah, 0x01
    xor cx, cx
    mov ch, 0b11001110
    mov cl, 0x0F
    int 0x10
    retf

DisableCursor:
    xor ax, ax
    mov ah, 0x01
    xor cx, cx
    mov ch, 0b00100000
    int 0x10
    retf

SetCursorPosition:
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: y coordinate (uint16_t)
    ; [bp + 0x08]: x coordinate (uint16_t)

    push bp
    mov bp, sp
    push es
    push di
    push bx
    push ds
    push si

    xor ax, ax
    mov ah, 0x02
    mov dh, [bp + 0x06] ; y coordinate
    mov dl, [bp + 0x08] ; x coordinate
    xor bx, bx
    int 0x10

    pop si
    pop ds
    pop bx
    pop di
    pop es
    pop bp
    retf