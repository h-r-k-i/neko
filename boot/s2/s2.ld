ENTRY(start)

SECTIONS
{
    . = 0x1000;

    .text : {
        *(.text*)
        *(.rodata.*)
        *(.rodata)
        *(COMMON)
        *(.bss*)
        *(.data*)

        __s2_end = .;

        . = 0x3000 - 2;
        SHORT(0xABAB);
    }
    ASSERT(__s2_end <= ADDR(.text) + 0x3000 - 2, "Stage 2 end is beyond the allowed size")
}
