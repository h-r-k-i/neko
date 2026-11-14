#ifndef DISK_HPP
#define DISK_HPP

/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/include/disk.hpp
 * NAME:        SBL, Stage 3, Disk Driver Header
 * DESCRIPTION: Disk driver, because ifstream isn't a thing here
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        12 November 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include <stdint.h>
#include "suite.hpp"

#ifdef __cplusplus
extern "C" {
#endif
uint16_t GetSector(uint32_t dap, uint32_t drive);
uint16_t GetDriveParameters(uint32_t paramBuffer, uint32_t drive);
#ifdef __cplusplus
}
#endif

inline uint32_t getSegmentOffset(void* ptr);

struct DiskAddressPacket {
    uint8_t size;
    uint8_t reserved;
    uint16_t count;
    uint16_t bufferOffset;
    uint16_t bufferSegment;
    uint32_t lbaLow;
    uint32_t lbaHigh;
} __attribute__((packed));

static_assert(sizeof(DiskAddressPacket) == 0x10, "DiskAddressPacket size must be 16 bytes");

struct DriveParameters {
    uint16_t size;
    uint16_t flags;
    uint32_t cylinders;
    uint32_t heads;
    uint32_t sectorsPerTrack;
    uint64_t totalSectors;
    uint16_t bytesPerSector;
    uint32_t EDDConfigurationParameters;
    uint8_t reserved[36]; // Space used for INT 13 2.0/3.0 which is not relevant for this implementation
} __attribute__((packed));

static_assert(sizeof(DriveParameters) == 0x42, "DriveParameters size must be 66 bytes");

class Disk {
    private:
        uint8_t driveNumber;
        bool initialized;
        DriveParameters params;
    
    public:
        Disk(uint8_t drive, uint16_t& result);
        uint16_t GetSectors(uint64_t lba, uint16_t count, void* buffer);

        // Used for reading a single sector, a process that is supported by all BIOSes.
        // This is done so that I can avoid rewriting my FAT code to handle the whole
        // "0 = success, 1 = failure" thing because they all are written on a virtual
        // disk that only writes one sector at a time and returns a boolean value.
        bool GetSectorLegacy(uint64_t lba, void* buffer) {
            return GetSectors(lba, 1, buffer) == 0;
        }
        // Used for reading 128+ sectors at once, a process that is not supported
        // by certain BIOSes.
        // Also ignores the whole "buffer crossing segment boundaries" thing because it doesn't go over buffers
        uint16_t getSectorsLarge(uint64_t lba, uint64_t count, void* buffer);
};

#endif // DISK_HPP