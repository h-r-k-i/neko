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

// dont assume any of this code is even close to valid C

// lets pretend there is a library called
#include <bios.h>
// that has a function to allow us to talk to the BIOS, and an
#include <asm.h>
// that has functions correlating to real assembly

int main() { // i mean this isn't main but this also isn't
             // proper C so who gives a shit
    // canonicalize CS:EIP
    clearInterruptFlags();
    ljump(0x0000, start);

    start:

    // load segment registers
    ax ^= ax; // yeah just fucking kill this
    ds = ax;
    es = ax;
    fs = ax;
    gs = ax;
    ss = ax;

    // set stack pointer to point down
    sp = 0x7000;

    // re-enable interrupts
    setInterruptFlags();

    r8b = 0; // yeah just throw it here
    // this would fail in real mode btw
    // for compatibility reasons things like r8-16 dont exist
    // until you enable protected mode
    // here we have "not a real program yet" mode so we're fine

    // reset disk controller
    ah = 0x00;
    dl = *boot_drive; // we treat boot_drive as a pointer here
    // because it kinda is
    // sure we don't declare it as such but this isnt real c
    // fuck you
    CallBIOS(0x13);

    // Check if we have ah=42h because if we don't we cant use it

    ah = 0x41;
    bx = 0x55AA;
    dl = *boot_drive;
    CallBIOS(0x13);

    if (getFlag(CF) == TRUE || bx != 0xAA55 || (cx & 1) == 0) {
        // I think we can just switch over to
        // AH=0x02 to read sectors
        goto sector_read_hell;
    }

    DAP = {
        uint8_t  size = 0x10;
        uint8_t  reserved = 0x00;
        uint16_t sector_count = 17;
        uint16_t offset = 0x0000;
        uint16_t segment = 0x0100;
        uint64_t lba = 1;
    };


    si = &DAP;
    ah = 0x42;
    dl = *boot_drive;
    CallBIOS(0x13);

    if (getFlag(CF) == TRUE) {
        // fuck it chs mode
        goto sector_read_hell;
    }
    goto final;
    sector_read_hell:
    // i dont wanna do this
    ah = 0x02;
    al = 17;
    ch = 0;
    cl = 2;
    bx = 0x0000;
    es = 0x0100; // what the fuck am i doing
    dh = 0;
    dl = *boot_drive;
    r8b += 1;
    CallBIOS(0x13);
    if (getFlag(CF) == FALSE) goto final;
    if (r8b == 3) quit();
    goto sector_read_hell;

    final:
    ljump(0x0100, 0x0000); // i didn't have to debug this in s1.s several times fuck you

    // because this is fucky pseudoassembly we put vars here

    uint8_t boot_drive = 0;
    boot_drive = dl; // save boot drive
    pad(510); // pad to 510 bytes, not 512, because magic number
    sign(0x55AA); // aforementioned
}

// DAP should look something like this:
// 0x0: size of DAP (10h)
// 0x1: reserved (00h)
// 0x2: sector count (0x01 - 0x7f for compatibility although could be as high as 0xff)
// 0x4: transfer buffer (offset:segment, 00:00 - ff:ff)
// 0x8: starting LBA lower bytes (0x00000000 - 0xFFFFFFFF)
// 0xC: starting LBA upper bytes (0x00000000 - 0x0000FFFF)