ENTRY(start)

SECTIONS
{
    . = 0x1000;

    .text : {
        *(.text*)
        *(.rodata.*)

        __s2_end = .;

        /* pad out to exactly 8KB (0x1000-0x3000) and stamp the
           end-of-stage2 signature; SBL_Data lives at 0x3000 right
           after this, so this must land exactly on the boundary.
           '.' here is an offset from this section's start (0x1000). */
        . = 0x2000 - 2;
        SHORT(0xABAB);
    }
    ASSERT(__s2_end <= ADDR(.text) + 0x2000 - 2, "Stage 2 end is beyond the allowed size")
    .data : { *(.data*) }
    .bss :
    {
        *(COMMON)
        *(.bss*)
    }
}
