[bits 16]
[org 0x7c00]

%if 0
 FILENAME:      ./boot/s1.s
 NAME:          SBL, Stage 1
 DESCRIPTION:   Sets basic functionality and boots Stage 2
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          22 January 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

cli ; disable interrupts
jmp 0x0000:start  ; canonicalize CS:EIP and jump to start

start:
    ; store boot drive ID
    mov [boot_drive], dl

    ; load segment registers

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov si, DAP
    mov sp, 0x7000

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

    jc sector_read_hell
    cmp bx, 0xAA55
    jne sector_read_hell
    test cx, 1
    jz sector_read_hell

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
    jc sector_read_hell
    jmp final

    sector_read_hell:
        ; now that we've confirmed that we can't use the modern disk reader,
        ; use the legacy one to read into s2
        ; FIRST: push FL onto the stack so that we know we can't use LBA
        mov dx, 0x464C
        push dx

        mov ah, 0x02
        mov al, 17
        mov ch, 0
        mov cl, 2
        mov dh, 0
        mov dl, [boot_drive]
        
        mov bx, 0x0100
        mov es, bx
        xor bx, bx
        
        int 0x13
        jnc final
        
        inc byte [retry_count]
        cmp byte [retry_count], 3
        jae hang
        jmp sector_read_hell

    final:
        ; if all passes jump into s2
        mov dl, [boot_drive]
        jmp 0x0000:0x1000

    hang:
        cli
        nop
        mov ah, 0x0E
        nop
        mov al, '?' ; why q mark? uhhhhhhhhhhhhhhh
        nop
        mov bh, 0
        nop
        mov bl, 0x07
        int 0x10
        hlt
        jmp hang
    
    hang_dbg:
        hlt
        jmp hang_dbg

    boot_drive: db 0
    retry_count: db 0

    DAP:
        db 0x10
        db 0
        dw 17
        dd 0x00001000
        dq 1
    
    times 510 - ($ - $$) db 0
    dw 0xAA55