[bits 16]

%if 0
 FILENAME:      ./boot/s2/s2func.s
 NAME:          SBL, Stage 2 Functions
 DESCRIPTION:   Helper functions for the second-stage bootloader.
                Especially relied upon by s2.c.
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          25 August 2025
 COPYRIGHT:     Haruki Media Group (notably a lot of this is still MIT license)
 LICENSE:       MIT License (./LICENSE)
 NOTE:          so much make bullshit please im gonna fucking break 
                every one of my bones
%endif

; renamed arg_segment because segment is an actual nasm keyword
%define arg_segment [bp + 0x08]
; renamed arg_offset to match arg_segment
%define arg_offset [bp + 0x06]
%define continuation_pointer [bp + 0x0A]

global SBL_E820, SBL_E801, SBL_88, SBL_LM_Entropy, PopulateVBEInfo, PopulateVBEMode

EID equ 1 << 21
CPUID_EXT equ 0x80000000
CPUID_EXTF equ 0x80000001
CPUID_LM equ 1 << 29

CPUID_RAND equ 0x00000001
CPUID_RAND_EXT equ 1 << 30

SBL_E820:
    ; mov ax, 0xFFFF
    ; retf
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; [bp + 0x0A]: continuation pointer (uint32_t*)

    push bp
    mov bp, sp
    push es
    push di
    push bx
    
    o32 mov ebx, continuation_pointer ; reference continuation pointer
    o32 mov ebx, [ebx] ; and then dereference the pointer
    o32 mov ecx, 0x18 ; 24 bytes for the E820h structure. probably will end up being 20 but never hurt nobody now did it
    o32 mov edx, 0x534D4150 ; SMAP signature
    mov ax, arg_segment
    mov es, ax
    mov di, arg_offset ; offset
    o32 mov eax, 0x0000E820 ; E820h function
    int 0x15

    jc .e820_error1
    o32 cmp eax, 0x534D4150
    jne .e820_error2
    o32 test ebx, ebx
    jz .e820_may_be_done

    ; if we get here continuation is nonzero and we need to notify that
    o32 mov eax, ebx
    o32 mov ebx, continuation_pointer
    o32 mov ebx, [ebx]
    o32 cmp eax, ebx
    je .e820_may_be_done
    o32 mov ebx, continuation_pointer
    o32 mov [ebx], eax ; update the continuation pointer
    o32 xor eax, eax ; return 0 to indicate nothing went wrong
    ; caller should see nonzero value in continuation ptr and know to call this func again
    jmp .SBL_E820_END

    .e820_error1:
        mov al, ah
        xor ah, ah
        test ax, ax
        jnz .SBL_E820_END
        mov ax, 0x0001 ; return error code 1 to indicate E820 may have actually succeeded
        jmp .SBL_E820_END

    .e820_error2:
        ; here the error is that eax is not equal to the smap signature
        ; then in that case we return -1 in ax because the signature is 32-bit
        ; but we're in 16-bit mode?
        ; not gonna risk it for a chocolate biscuit
        mov ax, 0xFFFF
        jmp .SBL_E820_END

    .e820_may_be_done:
        mov ax, 0x0001 ; return 1 to indicate E820 is done probably
        jmp .SBL_E820_END
    
    .SBL_E820_END:
        pop bx
        pop di
        pop es
        pop bp
        retf ; could've just done rets everywhere else this is stupid

SBL_E801:
    ; mov ax, 0xFFFF
    ; retf
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; of note: this segment:offset pair is used to point to the
    ; memory map data structure in memory
    push bp
    mov bp, sp
    push es
    push di
    push bx

    ; implementation for SBL_E801
    mov di, arg_offset
    mov ax, arg_segment
    mov es, ax
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    ; the actual read
    mov ax, 0xE801
    int 0x15
    jc .SBL_E801_ERROR ; jump to error handler if carry flag is set

    ; if no error, write and return success
    mov [es:di], ax
    mov [es:di + 2], bx
    mov [es:di + 4], cx
    mov [es:di + 6], dx
    xor ax, ax ; return success code 0
    jmp .SBL_E801_END


    .SBL_E801_ERROR:
        mov ax, 0xFFFF ; return error code to indicate failure
        jmp .SBL_E801_END

    .SBL_E801_END:
        pop bx
        pop di
        pop es
        pop bp
        retf

SBL_88:
    ; mov ax, 0xFFFF
    ; retf
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; of note: this segment:offset pair is used to point to the
    ; memory map data structure in memory
    push bp
    mov bp, sp
    push es
    push di
    push bx
    ; implementation for SBL_88

    mov di, arg_offset
    mov ax, arg_segment
    mov es, ax
    xor ax, ax

    mov ah, 0x88
    int 0x15

    jc .SBL_88_ERROR ; jump to error handler if carry flag is set
    mov [es:di], ax ; return the value in ax
    xor ax, ax ; return success code 0
    jmp .SBL_88_END

    .SBL_88_ERROR: ; if there's an error here, genuinely, i wish you so much luck; you're gonna fucking need it
        mov ax, 0xFFFF ; return error code to indicate failure
        jmp .SBL_88_END

    .SBL_88_END:
        pop bx
        pop di
        pop es
        pop bp
        retf


SBL_LM_Entropy:
    push bp
    mov bp, sp
    push es
    push di
    push bx

    .SBL_LM_ENTROPY_CHECK_CPUID:
        o32 pushfd
        o32 pop eax

        o32 mov ecx, eax
        o32 xor eax, EID

        o32 push eax
        o32 popfd
        o32 pushfd
        o32 pop eax

        o32 push ecx
        o32 popfd

        o32 xor eax, ecx
        jnz .SBL_LM_ENTROPY_CPUID_SUPPORTED

        mov ax, 0xF000
        jmp .SBL_LM_ENTROPY_END
    
    .SBL_LM_ENTROPY_CPUID_SUPPORTED:
        nop ; lol
        o32 mov eax, CPUID_EXT
        o32 cpuid
        o32 cmp eax, CPUID_EXTF
        jb .SBL_LM_NO_LMAO

        o32 mov eax, CPUID_EXTF
        o32 cpuid
        o32 test edx, CPUID_LM
        jz .SBL_LM_NO_LMAO
        jmp .SBL_LM_ENABLED

    .SBL_LM_NO_LMAO:
        xor ax, ax
        mov ax, 0x0000
        push ax
        jmp .SBL_ENTROPY
    
    .SBL_LM_ENABLED:
        xor ax, ax
        mov ax, 0x0080
        push ax
        jmp .SBL_ENTROPY
    
    .SBL_ENTROPY:
        o32 mov eax, CPUID_RAND
        o32 cpuid
        o32 and ecx, CPUID_RAND_EXT
        jz .SBL_NO_ENTROPY

        xor ax, ax
        pop ax
        or ax, 0x0008
        jmp .SBL_LM_ENTROPY_END

    .SBL_NO_ENTROPY:
        xor ax, ax
        pop ax
        jmp .SBL_LM_ENTROPY_END

    .SBL_LM_ENTROPY_END:
        pop bx
        pop di
        pop es
        pop bp
        retf

PopulateVBEInfo:
    ; mov ax, 0xFFFF
    ; retf
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; of note: this segment:offset pair is used to point to the
    ; memory map data structure in memory
    push bp
    mov bp, sp
    push es
    push di
    push bx
    
    mov di, arg_offset
    mov ax, arg_segment
    mov es, ax

    mov ax, 0x4F00
    int 0x10

    .PopulateVBEInfo_END:
        pop bx
        pop di
        pop es
        pop bp
        retf

PopulateVBEMode:
    ; mov ax, 0xFFFF
    ; retf
    ; variables:
    ; [bp + 0x00]: original base pointer (NOT A VARIABLE DO NOT FUCKING USE)
    ; [bp + 0x02]: return address (see warning above)
    ; [bp + 0x06]: offset (lower half of uint32_t segment:offset pair)
    ; [bp + 0x08]: segment (upper half of uint32_t segment:offset pair)
    ; [bp + 0x0A]: mode (uint16_t)
    ; [bp + 0x0C]: upper half of uint32_t mode data but this should always be 0 because the mode is a 16-bit value
    ; of note: this segment:offset pair is used to point to the
    ; memory map data structure in memory
    push bp
    mov bp, sp
    push es
    push di
    push bx
    
    mov di, arg_offset
    mov ax, arg_segment
    mov es, ax

    mov ax, 0x4F01
    mov cx, [bp + 0x0A]
    int 0x10

    .PopulateVBEMode_END:
        pop bx
        pop di
        pop es
        pop bp
        retf