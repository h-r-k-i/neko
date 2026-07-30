/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/IDT.h
 * NAME:        SBL, Stage 3 || Interrupt Descriptor Table Builder
 * DESCRIPTION: evil
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        4 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#ifndef IDT_H
#define IDT_H

#include <stdint.h>

// Gate Types
#define TASK_GATE   0x05
#define INTERRUPT16 0x06
#define TRAP16      0x07
#define INTERRUPT32 0x0E
#define TRAP32      0x0F

// Priviledge Levels
#define KERNEL  0
#define DRIVER0 1
#define DRIVER1 2
#define USER    3

// Selector; unchanged because of the flat mem model
// Index: 0x01
// TI: 0x00
// RPL: 0x00. This may be set dynamically and will in Neko but for now there's no need.
#define SS 0x0008

// PIC Definitions, stolen from OSDev
#define PIC1		    0x20
#define PIC2		    0xA0
#define PIC1_COMMAND	PIC1
#define PIC1_DATA	    (PIC1+1)
#define PIC2_COMMAND	PIC2
#define PIC2_DATA	    (PIC2+1)

#define PIC_EOI         0x20

#define ICW1_ICW4       0x01
#define ICW1_SINGLE     0x02
#define ICW1_INTERVAL4	0x04
#define ICW1_LEVEL      0x08
#define ICW1_INIT	    0x10

#define ICW4_8086	    0x01
#define ICW4_AUTO	    0x02
#define ICW4_BUF_SLAVE	0x08
#define ICW4_BUF_MASTER	0x0C
#define ICW4_SFNM	    0x10

#define CASCADE_IRQ     2



#define PIC_READ_IRR    0x0a
#define PIC_READ_ISR    0x0b

typedef void (*isr_t)(void);
extern isr_t isr_table[256];

extern uint64_t system_time_us;

typedef struct __attribute__((packed)) {
    uint16_t SIZE;
    uint32_t OFFSET;
} IDTR32_T;

typedef struct __attribute__((packed)) {
    uint16_t OFFSET_LOW;
    uint16_t SELECTOR;
    uint8_t ZERO;
    uint8_t ATTRIBUTES;
    uint16_t OFFSET_HIGH;
} IDT32_T;

// extern IDT32_T idt[256];

extern IDT32_T * idt;

struct registers {
    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags, useresp, ss;
};

// Initial IDT handler functions
void IDT_INIT(void);
void IDT_WRITE(uint8_t, uint8_t, uint8_t, void (*)(uint32_t));
void ISR_HANDLE(struct registers);

// Interrupt table || Exceptions (DO NOT MODIFY)
void GENERAL_EXCEPTION(uint32_t);

void DIVIDE_ERROR(uint32_t);
void DEBUG_EXCEPTION(uint32_t);
void NMI_INTERRUPT(uint32_t);
void BREAKPOINT(uint32_t);
void OVERFLOW(uint32_t);
void BOUND_RANGE_EXCEEDED(uint32_t);
void INVALID_OPCODE(uint32_t);
void NO_FLOATING_POINT(uint32_t);
void DOUBLE_FAULT(uint32_t);
void COPROCESSOR_SEGMENT_OVERRUN(uint32_t);
void INVALID_TSS(uint32_t);
void SEGMENT_NOT_PRESENT(uint32_t);
void STACK_SEGMENT_FAULT(uint32_t);
void GENERAL_PROTECTION_FAULT(uint32_t);
void PAGE_FAULT(uint32_t);
// Intel reserved function here lol
void X87_FPU_ERROR(uint32_t);
void ALIGNMENT_ERROR(uint32_t);
void MACHINE_CHECK(uint32_t);
void SIMD_FPU_EXCEPTION(uint32_t);
void VIRTUALIZATION_ERROR(uint32_t);
void CONTROL_EXCEPTION(uint32_t);

// Other IDT functions
void GENERAL_INTERRUPT(uint32_t);
void KEYBOARD_INTERRUPT(uint32_t);
void TIMER_INTERRUPT(uint32_t);

// Functions related to the PIC
extern void PIC_sendEOI(uint8_t);
extern void PIC_remap(uint32_t, uint32_t);
extern void PIC_disable(void);
extern void IRQ_set_mask(uint8_t);
extern void IRQ_clear_mask(uint8_t);
extern uint16_t PIC_get_irr(void);
extern uint16_t PIC_get_isr(void);



#endif