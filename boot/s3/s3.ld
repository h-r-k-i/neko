ENTRY(_start)

SECTIONS
{
    . = 0x7F00;

    .text : {
        . = ALIGN(8);
        KEEP(*(.multiboot))
        *(.text*)
    }
    .rodata : { *(.rodata*)  }
    .data : { *(.data*) }
    .bss :
    {
        *(COMMON)
        *(.bss*)
    }
}