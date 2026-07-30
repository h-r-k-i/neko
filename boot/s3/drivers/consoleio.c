/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/consoleio.c
 * NAME:        SBL, Stage 3 || Console-like Functions
 * DESCRIPTION: shitty, ass, abhorrent implementation of what is basically printf and itoa
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "consoleio.h"

int x = 0;
int y = 0;

uint16_t * video = (uint16_t *)0xB8000;

/* 
 * Format specifier:
 * %[parameter][flags][width][.precision][length]type
 * 
 * Parameter: (POSIX NOT C)
 * n$ -> n is the index of the value param to serialize
 * 
 * Flags:
 * -   -> Left-align ("100    " instead of "    100")
 * +   -> Plus prepending ("+100" instead of "100")
 * " " -> Prepend a space character (ignored if + exists)
 *        (" 100" instead of "100")
 * 0 -> When width is specified, prepend zeros instead of
 *      spaces ("0000100" instead of "    100")
 * ' -> Thousands grouping ("100,000" instead of "100000")
 * # -> Variable:
 *      for g/G: Trailing zeros are kept
 *      for f/F, e/E, g/G: Output always contains a radix pt
 *      for o, x/X, the text 0, 0x, 0X (respc.) is prefixed
 * 
 * Width: Specifies the minimum amount of characters to output
 * 
 * Precision:
 *     Specifies the maximum amount of characters to output
 *     FLOATING POINTS: Digits to the right with which to
 *                      round
 *      g/G: Total amount of significant figures to include
 *      STRINGS: Amount of characters to allow, truncate aft.
 * 
 * Length:
 *      Shit about character conversion:
 *      hh  Expect int from char
 *      h   Expect int from short
 *      l   Expect long
 *      ll  Expect long long
 *      L   Expect long double (FLOATING POINT SHIT)
 *      z   Expect size_t
 *      j   Expect intmax_t
 *      t   Expect ptrdiff_t
 * 
 * Type:
 *      %       %
 *      d, i    signed integer                          (ITARG)
 *      u       unsigned integer
 *      f, F    fixed-point double
 *      e, E    scientific notation double
 *      g, G    double, determine appropriate notation
 *      x, X    hexadecimal integer                     (ITARG)
 *      o       octal
 *      s       null-terminated string                  (ITARG)
 *      c       character
 *      p       pointer
 *      a, A    hexadecimal double
 *      n       DUMP: current character count
 */

void printk(char * format, ...) {
    uint32_t i = 0;
    va_list args;
    va_start(args, format);
    uint32_t expected_args = 0, args_consumed = 0;
    for (int j = 0; format[j]; j++) {
        if (format[j] == '%' && format[j + 1] && format[j + 1] != '%') {
            expected_args++;
        }
    }
    
    while (format[i] != '\0') {
        // assume default attribute
        if (format[i] == '\n') {
            x = -1;
            y++;
        }
        else if (format[i] == '\t') {
            x += 3;
        }
        else if (format[i] == '%') {
            if (format[i + 1] == '%' || (args_consumed >= expected_args)) {
                i++;
                video[y * 80 + x] = (((BLACK << 4) | WHITE) << 8) | format[i];
            }
            else if (format[i + 1] == 'd' || format[i + 1] == 'i') {
                i++;
                int value = va_arg(args, int);
                char stringk[32];
                itoa(value, stringk);
                printk(stringk);
                x--;
                args_consumed++;
            }
            else if (format[i + 1] == 'x' || format[i + 1] == 'X') {
                format[i + 1] == 'x' ? printk("0x") : printk("0X");
                i++;
                // and then move to converting to hex
                int value = va_arg(args, int);
                char stringk[9];
                xtoa(value, stringk, format[i] == 'x' ? 0 : 1);
                printk(stringk);
                x--;
                args_consumed++;
            }
            else if (format[i + 1] == 's') {
                i++;
                char * stringk = va_arg(args, char *);
                printk(stringk);
                x--;
                args_consumed++;
            }
            else
            {
                video[y * 80 + x] = (((BLACK << 4) | WHITE) << 8) | format[i];
                args_consumed++;
            }
        }
        else video[y * 80 + x] = (((BLACK << 4) | WHITE) << 8) | format[i];
        x++;
        if (x == VGA_WIDTH) {
            x = 0;
            y++;
        }
        if (y == VGA_HEIGHT) {
            scroll(1);
            y--;
        }
        i++;
    }
    va_end(args);
}

char * itoa(int32_t val, char * str) {
    if (val == 0) {
        str[0] = '0';
        str[1] = '\0';
        return str;
    }
    if (val == INT32_MIN) {
        const char * min_str = "-2147483648";
        int i = 0;
        while (min_str[i]) {
            str[i] = min_str[i];
            i++;
        }
        str[i] = '\0';
        return str;
    }
    int negative = val > 0 ? 0 : 1;
    if (negative == 1) {
        val = (val) * -1;
        str[0] = '-';
    }
    int32_t size = 1;
    int32_t s2 = 1;
    
    while (s2 <= val / 10) {
        size++;
        s2 *= 10;
    }
    int s3 = size;
    
    for (int i = 0; i < s3; i++) {
        str[i +  negative] = (val % 10) + '0';
        val /= 10;
    }
    
    for (int i = 0; i < s3 / 2; i++) {
        char temp = str[i + negative];
        str[i + negative] = str[s3 - i - 1 + negative];
        str[s3 - i - 1 + negative] = temp;
    }
    
    str[s3 + negative] = '\0';
    
    return str;
}

char * xtoa(int32_t val, char * str, uint8_t capitalize) {
    int32_t mask = 0xF0000000;
    uint8_t buffer = 0;
    for (int32_t i = 0; i < 8; i++) {
        uint8_t buffer = (val >> ((7 - i) * 4)) & 0xF;  // Simpler
        str[i] = (buffer < 10) ? ('0' + buffer) : ((capitalize ? 'A' : 'a') + buffer - 10);
    }
    uint8_t isFirstBit = 0;
    while (isFirstBit != 1) {
        isFirstBit = 1;
    }
    str[8] = '\0';
    return str;
}

void scroll(uint8_t lines) {
    for (int i = 0; i < VGA_HEIGHT * VGA_WIDTH; i++) {
        video[i] = video[VGA_WIDTH * lines + i];
    }
}