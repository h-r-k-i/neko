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
extern c_add, sbl_build, sbl_read


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

    jmp stage4

stage0_1:
    ; S1: Build the SBL Data structure

    cpush ImpAreaSize
    cpush ImpArea
    cpush SBL_Data
    ccall sbl_build
    add sp, 4
    cmp ax, 177
    je hang4 ; if 177 is returned then the SBL build succeeded BUT we're in debug mode so the bootloader will halt to allow map validation


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
        jmp stage6

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
    jmp stage0_1

; S6: Load and jump to Stage 3 (addl unreal mode bullshit)
stage6:
    o32 mov eax, 0x4F4B454E ; NEKO (Magic Number)
    o32 mov ebx, SBL_Data
    o32 mov edx, [boot_drive]
    o32 and edx, 0x000000FF
    jmp 0x0000:s3_loc

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


boot_drive: db 0
row: db 0
lba_state: dw 0

; messages
m1 db 'Loading from hard drive...', 0x0a, 0x0d, 0x00
m1l equ $ - m1

m2 db 'E: Something happened. Please check drive state.', 0x0a, 0x0d, 0x00
m2l equ $ - m2

m6 db 'E: Could not use LBA reading, quitting! (get a PC from this millenium, asshole)', 0x0a, 0x0d, 0x00
m6l equ $ - m6

m8 db 'Enabling A20!', 0x0a, 0x0d, 0x00
m8l equ $ - m8

m11 db "E: get this fucking function to work you idiot", 0x0a, 0x0d, 0x00
m11l equ $ - m11

m12 db "E: run pmemsave to get a memory map and then run without debug mode", 0x0a, 0x0d, "note: if you see this msg on a real machine esp outside of debug mode something has gone very wrong", 0x0a, 0x0d, 0x00
m12l equ $ - m12

DAP_S3:
    db 0x10         ; Size of DAP
    db 0            ; Reserved
    dw s3_sectors   ; Sectors to read; hardcoded to 48 for now
    dw s3_loc       ; Offset to load to
    dw 0x0000       ; Segment to load to
    dq 25           ; Starting LBA sector (zero-based)

SBL_Data equ 0x5000

s3_loc equ 0x8000
s3_sectors equ 78

ImpArea equ $

shit_isr:
    iret

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

ImpAreaSize equ $ - ImpArea

; padding + 0xABAB signature are appended by the linker script (s2.ld),
; since this file no longer knows the final size once s2.c is linked in