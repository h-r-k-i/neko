[bits 16]
[org 0x7c00]

mov ah, 0x0e

; set up loop conditions
mov cx, 15
xor si, si

.loop:
    mov al, [msg+si]
    int 0x10
    inc si
    cmp cx, si
    jne .loop

cli
hlt

msg db 'Hello, World!', 0x0D, 0x0A
times 510 - ($ - $$) db 0

dw 0xAA55