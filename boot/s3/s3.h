/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/s3.h
 * NAME:        SBL, Stage 3 || Relevant Header File
 * DESCRIPTION: did not think this was needed but apparently it is lol
 *              dw not much'll be done here.
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#ifndef S3_H
#define S3_H

// #define MULTIBOOT1  0x2BADB002
// #define MULTIBOOT2  0x36D76289
#define SBL         0x4F4B454E

#include "consoleio.h"
#include "longmode.h"

// SeaBIOS Characters; these may not work on other BIOSes but whatever
#define NULL         0x00
#define WHITE_SMILE  0x01
#define BLACK_SMILE  0x02
#define HEART        0x03
#define DIAMOND      0x04
#define CLUB         0x05
#define SPADE        0x06
#define BULLET       0x07
#define INV_BULLET   0x08
#define CIRCLE       0x09
#define INV_CIRCLE   0x0A
#define MALE         0x0B
#define FEMALE       0x0C
#define QUARTER_NOTE 0x0D // technically an eighth note
#define EIGHTH_NOTE  0x0E // technically a double eighth note
#define WHITE_SUN    0x0F // i have no clue what this char is supposed to be

#define TRIANGLE_RIGHT    0x10 // apex points right
#define TRIANGLE_LEFT     0x11 // apex points left
#define UP_DOWN_ARROW     0x12
#define DOUBLE_BANG       0x13
#define PARAGRAPH         0x14
#define SECTION           0x15
#define BLACK_RECTANGLE   0x16
#define UP_DOWN_WITH_BASE 0x17
#define UP_ARROW          0x18
#define DOWN_ARROW        0x19
#define RIGHT_ARROW       0x1A
#define LEFT_ARROW        0x1B
#define RIGHT_ANGLE       0x1C
#define RIGHT_LEFT_ARROW  0x1D
#define TRIANGLE_UP       0x1E
#define TRIANGLE_DOWN     0x1F

#define SPACE         0x20
#define BANG          0x21
#define DOUBLE_QUOTE  0x22
#define HASH          0x23
#define DOLLAR_SIGN   0x24
#define PERCENT       0x25
#define AMPERSAND     0x26
#define APOSTROPHE    0x27
#define LEFT_PAREN    0x28
#define RIGHT_PAREN   0x29
#define ASTERISK      0x2A
#define PLUS          0x2B
#define COMMA         0x2C
#define DASH          0x2D
#define PERIOD        0x2E
#define FORWARD_SLASH 0x2F

#define ZERO         0x30
#define ONE          0x31
#define TWO          0x32
#define THREE        0x33
#define FOUR         0x34
#define FIVE         0x35
#define SIX          0x36
#define SEVEN        0x37
#define EIGHT        0x38
#define NINE         0x39
#define COLON        0x3A
#define SEMICOLON    0x3B
#define LESS_THAN    0x3C
#define EQUALS       0x3D
#define GREATER_THAN 0x3E
#define QUESTION     0x3F

#define AT    0x40
#define CAP_A 0x41
#define CAP_B 0x42
#define CAP_C 0x43
#define CAP_D 0x44
#define CAP_E 0x45
#define CAP_F 0x46
#define CAP_G 0x47
#define CAP_H 0x48
#define CAP_I 0x49
#define CAP_J 0x4A
#define CAP_K 0x4B
#define CAP_L 0x4C
#define CAP_M 0x4D
#define CAP_N 0x4E
#define CAP_O 0x4F

#define CAP_P         0x50
#define CAP_Q         0x51
#define CAP_R         0x52
#define CAP_S         0x53
#define CAP_T         0x54
#define CAP_U         0x55
#define CAP_V         0x56
#define CAP_W         0x57
#define CAP_X         0x58
#define CAP_Y         0x59
#define CAP_Z         0x5A
#define LEFT_BRACKET  0x5B
#define BACKSLASH     0x5C
#define RIGHT_BRACKET 0x5D
#define CARET         0x5E
#define UNDERSCORE    0x5F

#define BACKTICK 0x60
#define LOW_A    0x61
#define LOW_B    0x62
#define LOW_C    0x63
#define LOW_D    0x64
#define LOW_E    0x65
#define LOW_F    0x66
#define LOW_G    0x67
#define LOW_H    0x68
#define LOW_I    0x69
#define LOW_J    0x6A
#define LOW_K    0x6B
#define LOW_L    0x6C
#define LOW_M    0x6D
#define LOW_N    0x6E
#define LOW_O    0x6F

#define LOW_P       0x70
#define LOW_Q       0x71
#define LOW_R       0x72
#define LOW_S       0x73
#define LOW_T       0x74
#define LOW_U       0x75
#define LOW_V       0x76
#define LOW_W       0x77
#define LOW_X       0x78
#define LOW_Y       0x79
#define LOW_Z       0x7A
#define LEFT_BRACE  0x7B
#define PIPE        0x7C
#define RIGHT_BRACE 0x7D
#define TILDE       0x7E
#define HOUSE       0x7F

#define CAP_C_CEDILLA    0x80
#define LOW_U_DIAERESIS  0x81
#define LOW_E_ACUTE      0x82
#define LOW_A_CIRCUMFLEX 0x83
#define LOW_A_DIAERESIS  0x84
#define LOW_A_GRAVE      0x85
#define LOW_A_RING       0x86
#define LOW_C_CEDILLA    0x87
#define LOW_E_CIRCUMFLEX 0x88
#define LOW_E_DIAERESIS  0x89
#define LOW_E_GRAVE      0x8A
#define LOW_I_DIAERESIS  0x8B
#define LOW_I_CIRCUMFLEX 0x8C
#define LOW_I_GRAVE      0x8D
#define CAP_A_DIAERESIS  0x8E
#define CAP_A_RING       0x8F

#define CAP_E_ACUTE      0x90
#define LOW_AE           0x91
#define CAP_AE           0x92
#define LOW_O_CIRCUMFLEX 0x93
#define LOW_O_DIAERESIS  0x94
#define LOW_O_GRAVE      0x95
#define LOW_U_CIRCUMFLEX 0x96
#define LOW_U_GRAVE      0x97
#define LOW_Y_DIAERESIS  0x98
#define CAP_O_DIAERESIS  0x99
#define CAP_U_DIAERESIS  0x9A
#define CENT             0x9B
#define POUND            0x9C
#define YEN              0x9D
#define PESETA           0x9E
#define LOW_FHOOK        0x9F

#define LOW_A_ACUTE          0xA0
#define LOW_I_ACUTE          0xA1
#define LOW_O_ACUTE          0xA2
#define LOW_U_ACUTE          0xA3
#define LOW_N_TILDE          0xA4
#define CAP_N_TILDE          0xA5
#define SUPER_A              0xA6
#define SUPER_O              0xA7
#define QUESTION_MARK_SPANIS 0xA8
#define TON                  0xA9
#define NOT                  0xAA
#define HALF                 0xAB
#define FOURTH               0xAC
#define BANG_SPANISH         0xAD
#define LEFT_GUILLEMET       0xAE
#define RIGHT_GUILLEMET      0xAF

#define LIGHT_SHADE             0xB0
#define MEDIUM_SHADE            0xB1
#define DARK_SHADE              0xB2
#define VERT                    0xB3
#define VERT_LEFT               0xB4
#define VERT_DOUBLE_LEFT        0xB5
#define DOUBLE_VERT_LEFT        0xB6
#define DOUBLE_DOWN_LEFT        0xB7
#define DOWN_DOUBLE_LEFT        0xB8
#define DOUBLE_VERT_DOUBLE_LEFT 0xB9
#define DOUBLE_VERT             0xBA
#define DOUBLE_DOWN_DOUBLE_LEFT 0xBB
#define DOUBLE_UP_DOUBLE_LEFT   0xBC
#define DOUBLE_UP_LEFT          0xBD
#define UP_DOUBLE_LEFT          0xBE
#define LEFT_DOWN               0xBF

#define UP_RIGHT                 0xC0
#define UP_HORIZ                 0xC1
#define DOWN_HORIZ               0xC2
#define VERT_RIGHT               0xC3
#define HORIZ                    0xC4
#define VERT_HORIZ               0xC5
#define VERT_DOUBLE_RIGHT        0xC6
#define DOUBLE_VERT_RIGHT        0xC7
#define DOUBLE_UP_DOUBLE_RIGHT   0xC8
#define DOUBLE_DOWN_DOUBLE_RIGHT 0xC9
#define DOUBLE_UP_DOUBLE_HORIZ   0xCA
#define DOUBLE_DOWN_DOUBLE_HORIZ 0xCB
#define DOUBLE_VERT_DOUBLE_RIGHT 0xCC
#define DOUBLE_HORIZ             0xCD
#define DOUBLE_VERT_DOUBLE_HORIZ 0xCE
#define UP_DOUBLE_HORIZ          0xCF

#define DOUBLE_UP_HORIZ   0xD0
#define DOWN_DOUBLE_HORIZ 0xD1
#define DOUBLE_DOWN_HORIZ 0xD2
#define DOUBLE_UP_RIGHT   0xD3
#define UP_DOUBLE_RIGHT   0xD4
#define DOWN_DOUBLE_RIGHT 0xD5
#define DOUBLE_DOWN_RIGHT 0xD6
#define DOUBLE_VERT_HORIZ 0xD7
#define VERT_DOUBLE_HORIZ 0xD8
#define UP_LEFT           0xD9
#define DOWN_RIGHT        0xDA
#define FULL              0xDB
#define LOWER_HALF        0xDC
#define LEFT_HALF         0xDD
#define RIGHT_HALF        0xDE
#define UPPER_HALF        0xDF

#define ALPHA     0xE0
#define ESZETT    0xE1
#define GAMMA     0xE2
#define PI        0xE3
#define CAP_SIGMA 0xE4 // my suffering continues outside of calc ii and phys ii
#define LOW_SIGMA 0xE5
#define MU        0xE6
#define TAU       0xE7
#define CAP_PHI   0xE8
#define THETA     0xE9
#define OMEGA     0xEA
#define DELTA     0xEB // WARN: LOWERCASE DELTA, NOT UPPERCASE
#define INFINITY  0xEC
#define LOW_PHI   0xED
#define EPSILON   0xEE
#define INTERSECT 0xEF // calc ii and phys ii and now discrete math and statistics i cant fucking escape

#define TRIBAR 0xF0
#define PLUS_MINUS 0xF1
#define GREATER_EQUAL 0xF2
#define LESS_EQUAL 0xF3
#define TOP_INTEGRAL 0xF4 // oh hey there calc ii :face_with_bags_under_eyes:
#define BOTTOM_INTEGRAL 0xF5
#define DIVIDE 0xF6
#define APPROXIMATE 0xF7
#define DEGREE 0xF8
#define LARGE_DOT 0xF9 // looks VERY similar to small dot
#define SMALL_DOT 0xFA // looks VERY similar to large dot
#define ROOT 0xFB
#define SUPER_N 0xFC
#define SUPER_2 0xFD
#define SQUARE 0xFE
#define NBSP 0xFF

extern void hang();

void SBL_warn(uint16_t code, uint16_t severity) {
    printk("SBL: Warning code %u, severity %u\n", code, severity);
}
void SBL_panic(uint16_t code, uint16_t severity) {
    // draw screen
    // print the error (including code + severity)
}

#endif
