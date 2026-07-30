/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/IDT.c
 * NAME:        SBL, Stage 3 || Interrupt Descriptor Table Builder
 * DESCRIPTION: evil
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        4 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "IDT.h"
#include "consoleio.h"
#include "inline.h"

// I stole these from ChatGPT because uhhh the other line was far cursed trust me
#define GDT_LIMIT_LOW(l)   ((l) & 0xFFFFULL)
#define GDT_BASE_LOW(b)    (((b) & 0xFFFFULL) << 16)
#define GDT_BASE_MID(b)    (((b >> 16) & 0xFFULL) << 32)
#define GDT_ACCESS(a)      ((uint64_t)(a) << 40)
#define GDT_LIMIT_HIGH(l)  (((l >> 16) & 0xFULL) << 48)
#define GDT_FLAGS(f)       (((uint64_t)(f) & 0xFULL) << 52)
#define GDT_BASE_HIGH(b)   (((b >> 24) & 0xFFULL) << 56)

// would you rather this or 
// GDT_ENTRY = (((((((((uint64_t)(((((BASE & 0xFF000000) >> 20) | FLAGS) << 4) |
// ((LIMIT & 0x000F0000) >> 16)) << 8) | ACCESS) << 8) | ((BASE & 0x00FF0000) >> 16)) << 16) |
// (BASE & 0x0000FFFF)) << 16) | (LIMIT & 0x0000FFFF));

// IDT32_T idt[256] __attribute__((aligned(8)));

IDT32_T * idt = (IDT32_T *)0x1000;
uint64_t* gdt = (uint64_t *)0x800; // I learned how to make my mistakes less mistakey, 
                                   // not to stop making the same mistakes.

// void (*idt_func_table[256])(uint32_t);
void (** idt_func_table)(uint32_t) = (void (**)(uint32_t))0x2000; // what the fuck

uint64_t system_time_us = 0;

void IDT_INIT(void) {
    // 1. uhhh I wrote this before I finished IDT_WRITE so basically it's just a 
    // for loop
    for (int i = 0; i < 256; i++) {
        if (i < 0x20) idt_func_table[i] = GENERAL_EXCEPTION;
        else idt_func_table[i] = GENERAL_INTERRUPT;

        idt[i].OFFSET_LOW = (uint32_t)isr_table[i] & 0x0000FFFF;
        idt[i].OFFSET_HIGH = (((uint32_t)isr_table[i] >> 16) & 0xFFFF);
        idt[i].SELECTOR = SS;
        idt[i].ZERO = 0;
        idt[i].ATTRIBUTES = 0x8E;

    }
    IDTR32_T IDTR = {
        .SIZE = 256 * sizeof(IDT32_T) - 1,
        .OFFSET = (uint32_t)idt
    };

    __asm__ volatile ("lidt %0" : : "m"(IDTR));

    // 2. Rebuild GDT because this does absolutely destroy GDT.
    /* 
        * Structure of GDT:
        *  0-15: Limit
        * 16-31: Base
        * 32-39: Base
        * 40-47: Access
        * 48-51: Limit
        * 42-55: Flags
        * 56-63: Base
        * 
        * For a flat memory space limit should be 0xFFFFF
        */
    uint32_t BASE = 0x00000000; // NOT TO BE CHANGED
    uint32_t LIMIT = 0x000FFFFF; // NOT TO BE CHANGED (should make these consts)
    uint8_t ACCESS = 0x00;
    uint8_t FLAGS = 0x00;
    uint64_t GDT_ENTRY;

    // quickly just clean the first entry
    GDT_ENTRY = 0;
    gdt[0] = GDT_ENTRY;

    // build ACCESS byte:
    // 7: Present Bit (MUST BE 1)
    // 6: DPL (0: Highest privilege, 3: Lowest privilege)
    // 5: DPL
    // 4: Descriptor (0: System Segment like TSS, 1: GDT)
    // 3: Executable (0: Data, 1: Executable code)
    // 2: Direction/Conforming (SEE BELOW)
    // 1: RW (0: Not readable if code, not writiable if data; 1: Readable/Writable)
    // 0: Accessed (Just keep as 1 just for fuck's sake)

    // Direction/Conforming:
    // For data selctors: 0: Segment grows up; 1: Segment grows down like a stack
    // For code selectors: 0: Not executable with mismatching privilege,
    //                     1: Executable if privilege is equal or higher

    ACCESS = 0x9B;

    // build FLAGS byte:
    // 3: Granularity (0: Limit is in 1-byte; 1: Limit is in 4096 bytes)
    // 2: Size flag (0: 16-bit; 1: 32-bit)
    // 1: Long Mode Flag (if set DB must be 0)
    // 0: Reserved

    FLAGS = 0x0C;
    // Build GDT:
    // stole this from ChatGPT too.
    GDT_ENTRY =
        GDT_LIMIT_LOW(LIMIT)  |
        GDT_BASE_LOW(BASE)    |
        GDT_BASE_MID(BASE)    |
        GDT_ACCESS(ACCESS)    |
        GDT_LIMIT_HIGH(LIMIT) |
        GDT_FLAGS(FLAGS)      |
        GDT_BASE_HIGH(BASE);


    gdt[1] = GDT_ENTRY;
    // Clear the Code bit for the second one because we need it lowered
    ACCESS &= 0xF7;

    GDT_ENTRY =
        GDT_LIMIT_LOW(LIMIT)  |
        GDT_BASE_LOW(BASE)    |
        GDT_BASE_MID(BASE)    |
        GDT_ACCESS(ACCESS)    |
        GDT_LIMIT_HIGH(LIMIT) |
        GDT_FLAGS(FLAGS)      |
        GDT_BASE_HIGH(BASE);

    2[gdt] = GDT_ENTRY; // fun fact: this is (unfortunately) legal

    struct __attribute__((packed)) {
        uint16_t SIZE;
        uint32_t OFFSET;
    } GDTR = {
        (3 * 8) - 1,
        (uint32_t)(gdt)
    };

    // cross your fingers and clench your assholes
    __asm__ volatile ("lgdt %0" : : "m"(GDTR));

    // next up rebuild P
}
void IDT_WRITE(uint8_t entry, uint8_t type, uint8_t privilege, void (* handler)(uint32_t)) {
    // Change out the IDT Functions handler
    idt_func_table[entry] = handler;

    // Build a new IDT entry
    idt[entry].OFFSET_LOW = (uint32_t)isr_table[entry] & 0x0000FFFF;
    idt[entry].OFFSET_HIGH = ((uint32_t)isr_table[entry] & 0xFFFF0000) >> 16;
    idt[entry].SELECTOR = SS;
    idt[entry].ZERO = 0;
    idt[entry].ATTRIBUTES = 0x80 | (privilege << 5) | type;
}

void isr_handler(struct registers regs) {
    (idt_func_table[regs.int_no])(regs.err_code);
}

void GENERAL_EXCEPTION(uint32_t error_code) {
    printk("Unhandled exception!\n");
    while (1) ;
}

void GENERAL_INTERRUPT(uint32_t IO_CODE) {
    printk("Received unhandled interrupt!\n");
}

void KEYBOARD_INTERRUPT(uint32_t IO_CODE) {
    printk("Got keyboard\n");
    uint8_t scancode = inb(0x60);
    PIC_sendEOI(1);
}

void TIMER_INTERRUPT(uint32_t IO_CODE) {
    system_time_us += 1000;
    PIC_sendEOI(0);
}

void PIC_sendEOI(uint8_t irq) {
    if (irq >= 8) outb(PIC2_COMMAND, PIC_EOI);
    outb(PIC1_COMMAND, PIC_EOI);
}
void PIC_remap(uint32_t offset1, uint32_t offset2) {
	outb(PIC1_COMMAND, ICW1_INIT | ICW1_ICW4);  // starts the initialization sequence (in cascade mode)
	io_wait();
	outb(PIC2_COMMAND, ICW1_INIT | ICW1_ICW4);
	io_wait();
	outb(PIC1_DATA, offset1);                   // ICW2: Master PIC vector offset
	io_wait();
	outb(PIC2_DATA, offset2);                   // ICW2: Slave PIC vector offset
	io_wait();
	outb(PIC1_DATA, 1 << CASCADE_IRQ);          // ICW3: tell Master PIC that there is a slave PIC at IRQ2
	io_wait();
	outb(PIC2_DATA, 2);                         // ICW3: tell Slave PIC its cascade identity (0000 0010)
	io_wait();
	
	outb(PIC1_DATA, ICW4_8086);                 // ICW4: have the PICs use 8086 mode (and not 8080 mode)
	io_wait();
	outb(PIC2_DATA, ICW4_8086);
	io_wait();

	// Unmask both PICs.
	outb(PIC1_DATA, 0);
	outb(PIC2_DATA, 0);
}

void PIC_disable(void) {
    outb(PIC1_DATA, 0xff);
    outb(PIC2_DATA, 0xff);
}


void IRQ_set_mask(uint8_t IRQline) {
    uint16_t port;
    uint8_t value;

    if (IRQline < 8) port = PIC1_DATA;
    else {
        port = PIC2_DATA;
        IRQline -= 8;
    }
    value = inb(port) | (1 << IRQline);
    outb(port, value);
}

void IRQ_clear_mask(uint8_t IRQline) {
    uint16_t port;
    uint8_t value;

    if (IRQline < 8) port = PIC1_DATA;
    else {
        port = PIC2_DATA;
        IRQline -= 8;
    }

    value = inb(port) & ~(1 << IRQline);
    outb(port, value);
}



static uint16_t __pic_get_irq_reg(uint32_t ocw3) {
    outb(PIC1_COMMAND, ocw3);
    outb(PIC2_COMMAND, ocw3);
    return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

uint16_t PIC_get_irr(void) {
    return __pic_get_irq_reg(PIC_READ_IRR);
}

uint16_t PIC_get_isr(void) {
    return __pic_get_irq_reg(PIC_READ_ISR);
}