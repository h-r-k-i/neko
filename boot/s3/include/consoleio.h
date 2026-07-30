/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/consoleio.c
 * NAME:        SBL, Stage 3 || Console-like Functions Relevant Header
 * DESCRIPTION: I Fucking Hate Writing Kernel Code
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#ifndef CONSOLEIO_H
#define CONSOLEIO_H

#include <stdint.h>
#include <stdarg.h>

#define BLACK       0x00
#define BLUE        0x01
#define GREEN       0x02
#define CYAN        0x03
#define RED         0x04
#define MAGENTA     0x05
#define BROWN       0x06
#define LGRAY       0x07

#define DGRAY       0x08
#define LBLUE       0x09
#define LGREEN      0x0A
#define LCYAN       0x0B
#define LRED        0x0C
#define LMAGENTA    0x0D
#define YELLOW      0x0E
#define WHITE       0x0F

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

void printk(char *, ...);
char * itoa(int32_t, char *);
char * xtoa(int32_t, char *, uint8_t);
void scroll(uint8_t);

#endif