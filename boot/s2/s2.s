[bits 16]

%if 0
 FILENAME:      ./boot/s2/s2.s
 NAME:          SBL, Stage 2
 DESCRIPTION:   Sets up the device for booting into the kernel,
                exits Real Mode, and boots Stage 3.
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          28 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

%if 0
0100 0000 | Top of memory hole
000F 0000 | Video memory, MM I/O, BIOS data
000A 0000 | Bottom of memory hole
0009 0000 | Kernel preload end at 0009 F000
0000 1000 | ...
     F000 | Kernel preload start
     E000 | Top of protected mode stack at F000
     D000 | ...
     C000 | Disk buffer ends at C7FF
     B000 | ...
     A000 | ...
     9000 | ...
     8000 | Disk buffer start
     7000 | boot1 stored between 7C00-7DFF
     6000 | Toop of real mode stack at 7000
     5000 | ...
     4000 | ...
     3000 | boot2 ends at 31FF
     2000 | ...
     1000 | boot2 start
     0000 | Reserved (really 000-500 is reserved)


%endif

%macro cpush 1
    push word 0
    push word %1
%endmacro

%macro ccall 1
    push word 0
    call %1
%endmacro

global start
extern c_add, sbl_build


start:
    cli
    xor ax, ax
    mov ss, ax
    sti

    mov [boot_drive], dl
    mov dl, [boot_drive]
    mov bp, boot_drive

    pop dx
    mov [lba_state], dx
    xor dx, dx


    ; clear all the registers except the ones I can't.
    cli
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dh, dh
    mov si, 0x6FFF
    xor di, di
    xor bp, ax

    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ss, ax
    mov sp, 0x6FFF
    sti

    ; confirm for the user that we're in S2

    mov ah, 0x13
    xor dx, dx
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov cx, m1l
    push ds
    pop es
    mov bp, m1
    int 0x10
    inc dh
    mov [row], dh

    ; test call of c function
    cpush 4
    cpush 3
    ccall c_add
    add sp, 8
    cmp ax, 7
    jne hang3

stage0_1:
    ; S1: Build the SBL Data structure

    cpush SBL_Data
    ccall sbl_build
    add sp, 4
    cmp ax, 177
    je hang4 ; if 177 is returned then the SBL build succeeded BUT we're in debug mode so the bootloader will halt to allow map validation
    test ax, ax
    jnz hang3

; stage2:
;     ; the lit asks us to set the stack pointer but we did
;     ; so we skip that and move on to

;     ; S2: Query BIOS for size of lower and upper memory.

;     xor ax, ax
;     mov es, ax
;     o32 mov eax, 0x0000E820
;     o32 xor ebx, ebx
;     o32 mov ecx, 0x00000018
;     o32 mov edx, 0x534D4150
;     mov di, smap_offst
;     int 0x15

;     ; check if this even worked
;     jc legacy_memcheck
;     o32 cmp eax, 0x534D4150
;     jne legacy_memcheck
;     o32 cmp ebx, 0
;     je stage3_2

;     ; if it did, increment the memmap size by 1
;     mov dx, [smap_size]
;     inc dx
;     mov [smap_size], dx

;     add di, 24
;     memloop:
;         o32 mov eax, 0x0000E820
;         o32 mov ecx, 0x00000018
;         o32 mov edx, 0x534D4150
;         int 0x15

;         jc legacy_memcheck
;         o32 cmp eax, 0x534D4150
;         jne legacy_memcheck
;         o32 test ebx, ebx
;         jz stage3_2

;         mov dx, [smap_size]
;         inc dx
;         mov [smap_size], dx
        
;         add di, 0x0018
;         pusha
;         cmp dx, 128
;         jae memcheck_suffix ; if we're at 128 entries, we don't want to overflow the buffer so we just stop here
;         popa

;         jmp memloop

;     memcheck_suffix:
;         mov ah, 0x13
;         mov al, 0x01
;         mov bh, 0
;         mov bl, 0x07
;         mov dh, [row]
;         xor dl, dl
;         mov cx, m5l
;         push ds
;         pop es
;         mov bp, m5
;         int 0x10
;         inc dh
;         mov [row], dh
    
;     legacy_memcheck:
;         mov ah, 0x13
;         mov al, 0x01
;         mov bh, 0
;         mov bl, 0x07
;         mov dh, [row]
;         xor dl, dl
;         mov cx, m3l
;         push ds
;         pop es
;         mov bp, m3
;         int 0x10
;         inc dh
;         mov [row], dh

;         ; Report legacy use
;         mov word ax, [SBL_Data + 24]
;         or ax, 0x0001
;         mov [SBL_Data + 24], ax

;         ; configure node
;         mov bx, [smap]
;         mov word [bx], 0xE801
;         mov ax, bx
;         mov bx, [SBL_Node]
;         mov word [bx], ax
;         mov ax, bx
;         add ax, 0x0004
;         mov word [bx + 2], ax
;         mov [SBL_Node], ax


;         mov si, [smap]

;         mov ax, 0xE801
;         int 0x15
;         jc memfail
;         cmp cx, 0
;         je memfail

;         mov [si + 2], ax
;         mov [si + 4], bx
;         mov [si + 6], cx
;         mov [si + 8], dx
;         xor ax, ax
;         jmp stage3_1

; stage3_1:
;     jmp stage3

; stage3_2:
;     ; configure node
;     mov bx, [smap]
;     mov word [bx], 0xE820
;     mov ax, bx
;     mov bx, [SBL_Node]
;     mov word [bx], ax
;     mov ax, bx
;     add ax, 0x0004
;     mov word [bx + 2], ax
;     mov [SBL_Node], ax


; S3: Read kernel from disk to lower memory.
stage3:

    ; Reset the disk controller (the following code is a literal copy-
    ; paste from S1 lmfaoooo)
    xor bl, bl
    mov ah, 0x00
    xor dx, dx
    mov dl, [boot_drive]
    int 0x13

    ; Get the value we stored at the beginning of S2
    mov dx, [lba_state]
    cmp dx, 0x464C
    je sector_read_hell
    cmp dx, 0x5343
    jne hang    ; if we can get neither FL nor SC something got fucked up
    ; that or I fucked up

    ; Now that we've confirmed that we can use the modern disk reader,
    ; do that to read into s3 (this has just the number changed lel)
    push cs
    pop ds
    mov si, DAP_S3
    mov ah, 0x42
    mov dl, [boot_drive] ; todo: add more comments because assembly scares me
    int 0x13

    ; if fail, try a different way
    jc sector_read_hell
    jmp final

    sector_read_hell:
        ; I don't wanna fucking bother adding support for PCs that require
        ; me to do bullshit geometry checks and whatnot
        ; so you know what? I'm just not going to do it.
        ; Fuck you.

        mov ah, 0x13
        mov al, 0x01
        mov bh, 0
        mov bl, 0x07
        mov dh, [row]
        xor dl, dl
        mov cx, m6l
        push ds
        pop es
        mov bp, m6
        int 0x10
        inc dh
        mov [row], dh
        xor dx, dx

        hang2:
            hlt
            jmp hang2

    final:
        nop ; lmao
        jmp stage4

; S4: Enable A20 line.
stage4:
    jmp setA20
    ; I had an elaborate method to triple-check that A20 is
    ; enabled with a function and then if it's not working
    ; then give up but it breaks so fuck it violently
    ; enable A20 

    setA20:
        ; violently tell QEMU to stfu with A20
        ; in al, 0x92
        ; and al, 0xFD
        ; out 0x92, al
        ; make sure to comment this shit out before testing on hardware
        ; that doesn't jerk you off and enable A20 at startup
        ; like the OptiPlex
        ; although on Haswell+ CPUs A20 may be forcibly set to HIGH

        mov ah, 0x13
        mov al, 0x01
        mov bh, 0
        mov bl, 0x07
        mov dh, [row]
        xor dl, dl
        mov cx, m8l
        push ds
        pop es
        mov bp, m8
        int 0x10
        inc dh
        mov [row], dh

        ; first just try Fast A20:
        in al, 0x92
        test al, 2
        jnz aftsA20
        or al, 2
        and al, 0xFE
        out 0x92, al

        ; GOD KILL ME I FUCKING HATE BOOTLOADER DEVELOPMENT
        ; fuck it stealing from OSDev
        call enable_A20

        aftsA20:
        jmp stage5

    ; S5: Disable interrupts.
stage5:
    nop ; lol part 2: electric boogaloo
    cli
    jmp stage6

; S6: Set up Global Descriptor Table ahead of Protected Mode
stage6:
    ; fun fact: there's no real way of verifying that
    ; the GDT is loaded other than loading and seeing
    ; if we triple fault. lol. Love when that happens.

    ; can't wait to test this shit on bare metal.
    lgdt [GDT_DESC]

    ; Before we enter Protected Mode let's set up VGA
    mov ah, 0x00
    mov al, 0x03    ; 80x25 although 80x50 may work
    int 0x10        ; but QEMU craps out if I try
    ; 0x09 for 132x50, 0x05 for 80x50, 0x03 for 80x25

    ;; and also do a check for what our disks are
    xor dx, dx
    mov dl, [boot_drive] ; yeah that's good enough

    ; as it turns out I also need to set up an IDT
    setup_idt:
        mov ecx, 256              ; 256 entries
        lea edi, [IDT]      ; Point to start of IDT
        
    .loop69:
        mov eax, shit_isr
        mov word [edi], ax
        mov word [edi+2], 0x08
        mov byte [edi+4], 0
        mov byte [edi+5], 0x8E
        shr eax, 16
        mov word [edi+6], ax
        
        add edi, 8
        dec ecx
        jnz .loop69
    
    ; now write the checksum
    mov ax, 0xFFFF
    mov bx, 0xFFFF
    mov cx, 0xFFFF
    mov dx, 0xFFFF

    ; sub magic
    sub dx, [SBL_Data]
    sbb cx, [SBL_Data + 2]
    sbb bx, [SBL_Data + 4]
    sbb ax, [SBL_Data + 6]

    ; sub flags
    sub dx, [SBL_Data + 16]
    sbb cx, [SBL_Data + 18]
    sbb bx, [SBL_Data + 20]
    sbb ax, [SBL_Data + 22]

    ; sub antiflags
    sub dx, [SBL_Data + 24]
    sbb cx, [SBL_Data + 26]
    sbb bx, [SBL_Data + 28]
    sbb ax, [SBL_Data + 30]

    ; store checksum
    mov [SBL_Data + 14], ax
    mov [SBL_Data + 12], bx
    mov [SBL_Data + 10], cx
    mov [SBL_Data + 8], dx
    jmp stage7

; S7: Finally enter Protected Mode
; This is based on the Intel IA-32 Architecture Software
; Developer's Manual at cs.cmu.edu/~410/doc/intel-sys.pdf
stage7:
    cli
    lgdt [GDT_DESC]
    in al, 0x70
    or al, 0x80
    out 0x70, al
    mov eax, cr0
    or al, 1
    mov cr0, eax
    ; jmp hang2
    
    jmp 0x08:stage7b

[bits 32]
; extern _start
stage7b:
    ; refresh the segment registers
    ; mov byte [0xB8000], 'X'
    ; mov ax, 0x10

    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    lidt [IDTR] ; load this piece of shit IDT
    in al, 0x80
    and al, 0x7F
    out 0x70, al
    mov al, 0xFF
    out 0xA1, al
    out 0x21, al
    sti

; S8: Jump to Stage 3
stage8:
    cli
    o32 mov esp, 0x7000 - 1 ; RM Stack Top
    o32 mov ebx, smap       ; Pointer to SMAP
    o32 mov eax, 0x4F4B454E ; NEKO (Magic Number)
    ; jmp hang2
    jmp dword 0x08:0x8000
    ; jmp hang2
    ; jmp hang2

[bits 16]
hang:
    cli
    mov ah, 0x13
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov dh, [row]
    xor dl, dl
    mov cx, m2l
    push ds
    pop es
    mov bp, m2
    int 0x10
    inc dh
    mov [row], dh
    hlt
    jmp hang

memfail:
    mov bx, SBL_Data
    add bx, 16
    mov ax, [bx]
    mov cx, 0x0001
    not cx
    and ax, cx
    mov word [bx], ax

    mov bx, SBL_Data
    add bx, 24
    mov ax, [bx]
    or ax, 0x0001
    mov word [bx], ax


    mov word [0x3040], 0x0001


    cli
    mov ah, 0x13
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov dh, [row]
    xor dl, dl
    mov cx, m4l
    push ds
    pop es
    mov bp, m4
    int 0x10
    inc dh
    mov [row], dh
    hlt
    jmp hang2
    
enable_A20: ; no comments fuck you
    cli

    call    a20wait
    mov     al,0xAD
    out     0x64,al

    call    a20wait
    mov     al,0xD0
    out     0x64,al

    call    a20wait2
    in      al,0x60
    push    ax

    call    a20wait
    mov     al,0xD1
    out     0x64,al

    call    a20wait
    pop     ax
    or      al,2
    out     0x60,al

    call    a20wait
    mov     al,0xAE
    out     0x64,al

    sti
    ret

a20wait:
    in      al,0x64
    test    al,2
    jnz     a20wait
    ret


a20wait2:
    in      al,0x64
    test    al,1
    jz      a20wait2
    ret

hang_dbg:
    hlt
    jmp hang_dbg

hang3:
    cli
    mov ah, 0x13
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov dh, [row]
    xor dl, dl
    mov cx, m11l
    push ds
    pop es
    mov bp, m11
    int 0x10
    inc dh
    mov [row], dh
    hlt
    jmp hang2

hang4:
    cli
    mov ah, 0x13
    mov al, 0x01
    mov bh, 0
    mov bl, 0x07
    mov dh, [row]
    xor dl, dl
    mov cx, m12l
    push ds
    pop es
    mov bp, m12
    int 0x10
    inc dh
    mov [row], dh
    hlt
    jmp hang2

shit_isr:
    iret


boot_drive: db 0
row: db 0

lba_state: dw 0
chs_retries: db 0

; messages
m1 db 'Loading from hard drive...', 0x0a, 0x0d, 0x00
m1l equ $ - m1

m2 db 'E: Something happened. Please check drive state.', 0x0a, 0x0d, 0x00
m2l equ $ - m2

m3 db 'Falling back to legacy memory detection...', 0x0a, 0x0d, 0x00
m3l equ $ - m3

m4 db 'E: failed to get memory size (consider upgrading your device past 1994)', 0x0a, 0x0d, 0x00
m4l equ $ - m4

m5 db 'W: BIOS may be corrupt, deciding this is enough enough memory to map...', 0x0a, 0x0d, 0x00
m5l equ $ - m5

m6 db 'E: Could not use LBA reading, quitting! (get a PC from this millenium, asshole)', 0x0a, 0x0d, 0x00
m6l equ $ - m6

m7 db 'I: A20 pre-enabled! (This OS may be on an emulator!)', 0x0a, 0x0d, 0x00
m7l equ $ - m7

m8 db 'Enabling A20!', 0x0a, 0x0d, 0x00
m8l equ $ - m8

m9 db "E: I don't even know how this happens but your memory is just fucked.", 0x0a, 0x0d, 0x00
m9l equ $ - m9

m10 db "E: dawg you can't even access A20 on this shit kek", 0x0a, 0x0d, 0x00
m10l equ $ - m10

m11 db "E: get this fucking function to work you idiot", 0x0a, 0x0d, 0x00
m11l equ $ - m11

m12 db "E: run pmemsave to get a memory map and then run without debug mode", 0x0a, 0x0d, "note: if you see this msg on a real machine esp outside of debug mode something has gone very wrong", 0x0a, 0x0d, 0x00
m12l equ $ - m12

DAP_S3:
    db 0x10         ; Size of DAP
    db 0            ; Reserved
    dw s3_sectors   ; Sectors to read; hardcoded to 36
    dw s3_loc       ; Offset to load to
    dw 0x0000       ; Segment to load to
    dq 17           ; Starting LBA sector

;DAP_S1K:
;    db 0x10         ; you know the drill
;    db 0            ; reserved
;    dw s1k_sectors  ; 

; DAP_NEKO:

SBL_Data equ 0x3000
SBL_Node: dd 0x3040

smap: dw 0x3440
smap_size equ 0x3442
smap_offst equ 0x3444

s3_loc equ 0x7F00
s3_sectors equ 36
s1k_sectors equ 1152

GDT_START:
    dq 0                    ; HAS TO BE NULL
    dq 0x00CF9A000000FFFF   ; flat code segment
    dq 0x00CF92000000FFFF   ; flat data segment
GDT_END:

GDT_DESC:
    dw GDT_END - GDT_START - 1  ; start, offset by 1 because idfk
    dd GDT_START                ; base addr

IDT:
    times 256 * 8 db 0 ; Fuck You! Eat My Fucking Asshole!

IDTR:
    dw (256 * 8) - 1
    dd IDT

; padding + 0xABAB signature are appended by the linker script (s2.ld),
; since this file no longer knows the final size once s2.c is linked in