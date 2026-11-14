#ifndef SUITE_HPP
#define SUITE_HPP

/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/suite.hpp
 * NAME:        SBL, Stage 3, general helper functions || Header
 * DESCRIPTION: Provides general helper functions for the SBL Stage 3 bootloader.
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        12 November 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include <stdint.h>

inline void SBL_memcpy(void* dest, const void* src, uint32_t count) {
    char* d = (char*)dest;
    const char* s = (const char*)src;
    for (uint32_t i = 0; i < count; i++) {
        d[i] = s[i];
    }
}

inline bool SBL_memcmp(const void* a, const void* b, uint32_t count) {
    const char* p1 = (const char*)a;
    const char* p2 = (const char*)b;
    for (uint32_t i = 0; i < count; i++) {
        if (p1[i] != p2[i]) {
            return false;
        }
    }
    return true;
}

inline uint32_t getSegmentOffset(void* ptr) {
    return ((uint32_t)ptr >> 4) << 16 | ((uint32_t)ptr & 0xF);
}

#endif // SUITE_HPP