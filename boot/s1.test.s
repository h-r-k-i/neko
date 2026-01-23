/* Tasks:
 * Disable interrupts
 * Canonicalize %CS:%EIP
 * Load segment registers %DS, %ES, %FS, %GS, %SS
 * Set the stack pointer
 * Re-enable interrupts
 * Reset the disk controller
 * Read the location of the second-stage bootloader
 * Jump to s2's code
 * 
 * In the event of failure:
 * Notify the user of a failure condition
 * Disable interrupts
 * Kill the program
 */

; this time we assume this isnt valid assembly


%if 0

Bootloader memory map:

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
     7000 | boot0 stored between 7C00-7DFF
     6000 | Toop of real mode stack at 7000
     5000 | ...
     4000 | ...
     3000 | boot1 ends at 31FF
     2000 | ...
     1000 | boot1 start
     0000 | Reserved
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
    test bx, 0xAA55
    jne sector_read_hell
    test cx, 1
    jz sector_read_hell

    ; Now that we've confirmed that we can use the modern disk reader,
    ; do that to read into s2

    mov si, DAP
    mov ah, 0x42
    mov dl, [boot_drive]
    int 0x13

    ; if fail, try a different way
    jc sector_read_hell
    jmp final;

    sector_read_hell:
        ; now that we've confirmed that we can't use the modern disk reader,
        ; use the legacy one to read into s2
        mov ah, 0x02
        mov al, 17
        mov ch, 0
        mov cl, 2
        mov dx, 0x0100
        mov es, dx
        mov dh, 0
        mov dl, [boot_drive]
        int 0x13

        ; test if we got in; if not just fucking give up
        jnc final
        test bl, 3
        je hang
        inc bl
        jmp sector_read_hell

    final:
        ; if all passes jump into s2
        jmp 0x0100:0x0000

    hang:
        cli
        hlt
        jmp hang

    boot_drive: db 0

    DAP:
        db 0x10
        db 0x00
        dw 17
        dw 0x0000
        dw 0x0100
        dq 1

    times 510 - ($ - $$) db 0
    dw 0xAA55