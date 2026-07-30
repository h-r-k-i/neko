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

#define MULTIBOOT1  0x2BADB002
#define MULTIBOOT2  0x36D76289
#define SBL         0x4F4B454E

extern void hang();

#endif
