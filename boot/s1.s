[bits 16]
[org 0x7c00]

%if 0
 FILENAME:      ./boot/s1.s
 NAME:          SBL, Stage 1
 DESCRIPTION:   Sets basic functionality and boots Stage 2
                Also contains the boot record info for FAT32
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          22 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

jmp short bgn
nop

%if 0
 FAT32 BIOS Parameter Block (BPB)
%endif

OEM_IDENTIFIER      db "HMNKD000"
BYTES_PER_SECTOR    dw 512
SECTORS_PER_CLUSTER db 1
RESERVED_SECTORS    dw 1
FILE_ALLOC_TABLES   db 2
ROOT_DIR_ENTRIES    dw 0
SECTOR_COUNT_16     dw 0
MEDIA_DESCRIPTOR    db 0xF8
SECTOR_COUNT_FAT    dw 0

SECTORS_PER_TRACK   dw 0
HEAD_COUNT          dw 1
HIDDEN_SECTORS      dd 0
SECTOR_COUNT_32     dd 131072

%if 0
 FAT32 Extended Boot Record (EBR)
%endif

SECTORS_PER_FAT     dd 32
FAT_FLAGS           dw 0
FAT_VERSION         dw 799
ROOT_DIR_CLUSTER    dd 2
FSINFO_SECTOR       dw 1
RESERVED_SECTOR     times 12 db 0
DRIVE_NUMBER        db 0x80
WINDOWS_NT_FLAGS    db 0
BOOT_SIGNATURE      db 0x29
VOLUME_ID           dd "NEKO"
VOLUME_LABEL        db "NekoDOS SRC"
FILESYSTEM_TYPE     db "FAT32   "



bgn:
    cli ; disable interrupts
    jmp 0x0000:start  ; canonicalize CS:EIP and jump to start

start:

    ; load segment registers

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ; mov si, DAP
    mov sp, 0x7000

    mov ax, 0x0003
    int 0x10


    ; store boot drive ID
    mov [boot_drive], dl

    ; re-enable interrupts
    sti

    ; Reset the disk controller
    xor bl, bl
    mov ah, 0x00
    mov dl, [boot_drive]
    int 0x13

    ; Check if modern disk reading is permissible
    mov ah, 0x41
    mov bx, 0x55AA
    mov dl, [boot_drive]    
    int 0x13

    jc sector_read_hell_01
    cmp bx, 0xAA55
    jne sector_read_hell_01
    test cx, 1
    jz sector_read_hell_01

    ; Now that we've confirmed that we can use the modern disk reader,
    ; do that to read into s2

    ; FIRST: push SC onto the stack so that we know we can use LBA
    mov dx, 0x5343
    push dx

    mov si, DAP
    mov ah, 0x42
    mov dl, [boot_drive]
    int 0x13

    ; if fail, try a different way
    jc sector_read_hell_01
    jmp epicgames

    sector_read_hell_01:
       jmp hang ; removing support for CHS; SBL requires INT 13h extensions for disk access.
    
    epicgames: ; haha get it? cus unreal engine? unreal mode? ok ill kill myself now
        cli
        lgdt [gdtinfo]
        mov eax, cr0
        or al, 1
        mov cr0, eax
        jmp 0x0008:subpmode

        subpmode:
            mov bx, 0x10
            mov ds, bx

            and al, 0xFE
            mov cr0, eax
            jmp 0x0000:final


    final:
        ; if all passes jump into s2
        sti
        mov dl, [boot_drive]
        jmp 0x0000:0x1000

    hang:
        cli
        hlt
        jmp hang

    boot_drive: db 0
    retry_count: db 0

    align 4
    DAP:
        db 0x10 ; size of DAP structure
        db 0 ; reserved
        dw 17 ; number of sectors to read
        dw 0x1000 ; offset to read into
        dw 0x0000 ; segment to read into
        dq 1 ; starting LBA sector (sector 1, which is the second sector on disk)
    
    gdtinfo:
        dw gdt_end - gdt - 1
        dd gdt
    
    gdt:
        dq 0x0000000000000000   ; null descriptor
        dq 0x00009A000000FFFF   ; flat code segment
        dq 0x00CF92000000FFFF   ; flat data segment
    gdt_end:
    
    times 510 - ($ - $$) db 0
    dw 0xAA55