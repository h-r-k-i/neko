/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/disk.cpp
 * NAME:        SBL, Stage 3, Disk Driver Implementation
 * DESCRIPTION: see disk.hpp for more information
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        12 November 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "disk.hpp"

Disk::Disk(uint8_t drive, uint16_t& result) : driveNumber(drive), initialized(false), params{} {
    params.size = sizeof(DriveParameters);
    uint16_t res = GetDriveParameters(getSegmentOffset(&params), drive);
    if (res == 0) initialized = true;
    result = res;
}

uint16_t Disk::GetSectors(uint64_t lba, uint16_t count, void* buffer) {
    if (count == 0) return 0; // No sectors to read, so we're done technically.
    if (buffer == nullptr || initialized == false || params.bytesPerSector == 0) return 1; // Invalid parameters
    // Theoretically the maximum amount of sectors that can be read in one call is 65,535
    // (because that's the uint16_t limit for this function) but certain Phoenix BIOSes
    // will reject requests for more than 127 sectors at once.
    // As such, a max read is limited to 127 sectors.
    // - the same developer who straight-up rejected CHS support
    if (count > 127) return 2; // Count exceeds maximum allowed sectors (127)
    if (lba >= params.totalSectors || count > params.totalSectors - lba) return 4; // Requested sectors exceed total sectors on the drive
    DiskAddressPacket dap;
    dap.size = sizeof(DiskAddressPacket);
    dap.reserved = 0;
    dap.count = count;

    uint32_t start = (uint32_t)(uintptr_t)buffer;
    uint32_t bytes = (uint32_t)count * params.bytesPerSector;

    if (start > 0x9FFFF || bytes > 0xA0000 - start) return 5; // Buffer exceeds 1MB limit for real mode addressing

    uint32_t address = getSegmentOffset(buffer);
    if ((address & 0xFFFF) + bytes > 0x10000) return 3; // Buffer crosses segment boundary

    dap.bufferOffset = address & 0xFFFF; // Offset within the segment
    dap.bufferSegment = address >> 16; // Segment address
    dap.lbaLow = lba & 0xFFFFFFFF;
    dap.lbaHigh = lba >> 32;
    uint16_t result = GetSector(getSegmentOffset(&dap), driveNumber);
    return result == 0 ? 0 : result | 0x100; // Return the result code, offset by 256 to avoid clashing with our own error codes, or 0 if successful
}

// Used for reading 128+ sectors at once, a process that is not supported
// by certain BIOSes.
// Also ignores the whole "buffer crossing segment boundaries" thing because it doesn't go over buffers
uint16_t Disk::getSectorsLarge(uint64_t lba, uint64_t count, void* buffer) {
    if (params.bytesPerSector == 0) return 1; // Invalid parameters
    uint16_t SectorsPerRead = 0x8000 / params.bytesPerSector; // 32KB max read size, divided by bytes per sector
    if (SectorsPerRead > 64) SectorsPerRead = 64; // why 64? because 127 is ugly as FUCK and is SHIT
    for (uint64_t i = 0; i < count; i += SectorsPerRead) { 
        uint16_t sectorsToRead = (count - i > SectorsPerRead) ? SectorsPerRead : (uint16_t)(count - i);
        uint16_t result = GetSectors(lba + i, sectorsToRead, (void*)(0x10000));
        if (result != 0) return result; // Return the error code if any read fails
        SBL_memcpy((char*)buffer + i * params.bytesPerSector, (const char*)(0x10000), sectorsToRead * params.bytesPerSector);
    }
    return 0; // All reads were successful
}