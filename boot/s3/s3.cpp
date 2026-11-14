/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/s3.cpp
 * NAME:        SBL, Stage 3
 * DESCRIPTION: help
 *              
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        1 February 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "s3.hpp"
#include "suite.hpp"
#include "disk.hpp"
#include "pwm.hpp"
#include "fatfsd.hpp"

#ifdef BUILD_DEBUG
    #define DEBUG
#endif // BUILD_DEBUG

void s3_main(uint32_t eax, uint32_t ebx, uint32_t edx) {
    uint16_t globalResult_16 = 0;
    // hang();
    volatile uint16_t * video = (uint16_t *)0xB8000;
    char * str1 = "        SBL: Loading Neko...               \0";
    uint16_t index = 0;
    uint16_t a = (0x0F << 8) | 'A';

    while (str1[index] != '\0') video[index] =  (0x0F << 8) | str1[++index];

    if (eax == SBL) {
        DisableCursor();

        // video[0] = (0x0F << 8) | VERT_RIGHT;
        // video[1] = (0x0F << 8) | RIGHT_ARROW;
        // video[2] = (0x0F << 8) | SPACE;
        // video[3] = (0x0F << 8) | SEVEN;

        // video[0 + 80] = (0x0F << 8) | VERT_RIGHT;
        // video[1 + 80] = (0x0F << 8) | TRIANGLE_RIGHT;
        // video[2 + 80] = (0x0F << 8) | SPACE;
        // video[3 + 80] = (0x0F << 8) | SEVEN;

        // video[0 + 80 * 2] = (0x0F << 8) | VERT_RIGHT;
        // video[1 + 80 * 2] = (0x0F << 8) | GREATER_THAN;
        // video[2 + 80 * 2] = (0x0F << 8) | SPACE;
        // video[3 + 80 * 2] = (0x0F << 8) | SEVEN;

        // video[0 + 80 * 3] = (0x0F << 8) | VERT_RIGHT;
        // video[1 + 80 * 3] = (0x0F << 8) | SPACE;
        // video[2 + 80 * 3] = (0x0F << 8) | LEFT_BRACKET;
        // video[3 + 80 * 3] = (0x0F << 8) | SEVEN;
        // video[4 + 80 * 3] = (0x0F << 8) | RIGHT_BRACKET;

        printk("Please type the 8.3 directory of the kernel you want to boot,\n");
        printk("or enter Q to shut down the device.\n");
        printk("Do not enter drive letters.\n");
        printk("Max length is 255 characters.");

        bool ValidCommand = false;

        char inputBuffer[256] = {0};

        Disk disk(edx & 0xFF, globalResult_16);
        // disk.GetSectors(0, 1, (void*)0x7000); // read the first sector of the disk into memory at 0x7000

        while (!ValidCommand) {
            printk("\n");
            printk("sbl.harukimedia.org# ");

            gets(inputBuffer, 256);
            printk("\n");
            char* exitCode = "Q";
            if (SBL_memcmp(inputBuffer, exitCode, 2) == true) {
                printk("Shutting down the device...\n");
                ShutDownPC();
                printk("Failed to shut down the device (what the fuck)\n");
                hang();
            }
            uint8_t sector[512];
            disk.GetSectors(0, 1, sector);
            MBR* mbr = (MBR*)(sector);

            for (auto a : mbr->Partitions) {
                if (a.isValid() == false) continue;
                if (a.IsExtended()) {
                    // todo: handle extended partitions
                    continue;
                }

                uint8_t vbrSector[512];
                disk.GetSectors(a.StartLBA, 1, vbrSector);
                VBR* vbr = (VBR*)(vbrSector);
                uint8_t* buffer = (uint8_t*)0xF000;
                if (vbr->GetFATType() == FATType::FAT12) {
                    FAT12 fat12(disk, a.StartLBA);
                    auto packet = fat12.ResolvePath(inputBuffer);
                    if (packet.directoryState == DirectoryState::Found) {
                        printk("Found %s.\n", inputBuffer);
                        if (fat12.ReadFile(packet, buffer, packet.size)) {
                            printk("File read successfully.\n");
                            ValidCommand = true;
                        }
                        else printk("Failed to read file %s.\n", inputBuffer);
                    }
                    else {
                        printk("Did not find %s\n", inputBuffer);
                    }
                }
                if (vbr->GetFATType() == FATType::FAT16) {
                    FAT16 fat16(disk, a.StartLBA);
                    auto packet = fat16.ResolvePath(inputBuffer);
                    if (packet.directoryState == DirectoryState::Found) {
                        printk("Found %s.\n", inputBuffer);
                        if (fat16.ReadFile(packet, buffer, packet.size)) {
                            printk("File read successfully.\n");
                            ValidCommand = true;
                        }
                        else {
                            printk("Failed to read file.\n");
                        }
                    }
                    else {
                        printk("Did not find %s\n", inputBuffer);
                    }
                }
                if (vbr->GetFATType() == FATType::FAT32) {
                    FAT32 fat32(disk, a.StartLBA);
                    auto packet = fat32.ResolvePath(inputBuffer);
                    if (packet.directoryState == DirectoryState::Found) {
                        printk("Found %s.\n", inputBuffer);
                        if (fat32.ReadFile(packet, buffer, packet.size)) {
                            printk("File read successfully.\n");
                            ValidCommand = true;
                        }
                        else {
                            printk("Failed to read file.\n");
                        }
                    }
                    else {
                        printk("Did not find %s\n", inputBuffer);
                    }
                }
            }

            printk("Read %s. Request understood and promptly ignored.\n", inputBuffer);
        }



        // printk(VERT_RIGHT);
        // printk(RIGHT_ARROW);
        // printk(VERT_RIGHT);
        // printk(VERT_RIGHT);
        // printk("\n");

        hang(); // if we return from enableLongMode() then something went wrong and we should hang ourselves
    }
    else {
        str1 = "what????????????????";
        index = 0;
        while (str1[index] != '\0') {
            video[index] = (0x0F << 8) | str1[index];
            index++;
        }
        hang();
    }
}

void hang() {
    // #ifdef DEBUG
    //     printk("SBL: hang called.\n");
    // #endif // DEBUG
    // ((uint16_t*)(0xB8000))[0] = (0x0F << 8) | 'A';
    while (1) ;
}