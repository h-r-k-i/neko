/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/inline.h
 * NAME:        SBL, Stage 3 || Inline assembly functions.
 * DESCRIPTION: stolen from OSDev like you should with everything else.
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#ifndef INLINE_H
#define INLINE_H

#include <stdint.h>
static inline void outb(uint16_t port, uint8_t val) {
    __asm__ volatile ( "outb %b0, %w1" : : "a"(val), "Nd"(port) : "memory");
}
static inline uint8_t inb(uint16_t port) {
    uint8_t ret;
    __asm__ volatile ("inb %w1, %b0"
                    : "=a"(ret)
                    : "Nd"(port)
                    : "memory");
    return ret;
}

static inline void insl(uint16_t port, uint32_t * addr, uint32_t count) {
    __asm__ volatile("rep insl" : "+D"(addr), "+c"(count) : "d"(port) : "memory");
}

static inline void io_wait(void)
{
    outb(0x80, 0);
}
#endif