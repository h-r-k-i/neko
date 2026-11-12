ENTRY(_start)

SECTIONS
{
    . = 0x8000;

    .text : {
        *(.text*)
    }
    .rodata : { *(.rodata*)  }
    .data : { *(.data*) }
    .bss :
    {
        *(COMMON)
        *(.bss*)
        __s3_end = .;
    }

    ASSERT(__s3_end <= ADDR(.text) + 0xC800 - 4, "Stage 3 end is beyond the allowed size")
}