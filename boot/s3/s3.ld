ENTRY(_start)

SECTIONS
{
    . = 0x8000;

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