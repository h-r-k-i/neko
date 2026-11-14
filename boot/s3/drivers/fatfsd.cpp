/*******************************************************************************************
 * 
 * FILENAME:    ./boot/s3/drivers/fatfsd.cpp
 * NAME:        SBL, Stage 3, FAT Filesystem Driver
 * DESCRIPTION: I built this already it's mostly just ripping out the entrails of the
 *              C++ standard library
 * AUTHOR:      Haruki Tokumei, Haruki Media Group
 * DATE:        13 November 2026
 * COPYRIGHT:   Haruki Media Group.
 * LICENSE:     MIT License (./LICENSE)
 *******************************************************************************************/

#include "fatfsd.hpp"

bool FAT::IsValidSFNChar(char c) {
    if (c >= 'A' && c <= 'Z') return true;
    if (c >= '0' && c <= '9') return true;
    switch (c) {
        case '!': case '#': case '$': case '%': case '&':
        case '\'': case '(': case ')': case '-': case '@': case '^':
        case '_': case '{': case '}': case '~': case '`':
        return true;
    }
    return false;
}

bool FAT::IsValidSFNName(const char* name) {
    uint8_t baseLength = 0;
    uint8_t extLength = 0;
    bool hasExtension = false;

    for (size_t i = 0; name[i] != '\0'; i++) {
        char c = name[i];
        if (c == ' ') return false;

        if (c >= 'a' && c <= 'z') c -= 32;
        if (c == '.') {
            if (hasExtension || baseLength == 0) return false;
            hasExtension = true;
            continue;
        }
        if (!IsValidSFNChar(c)) return false;
        if (hasExtension) {
            if (extLength >= 3) return false;
            extLength++;
        }
        else {
            if (baseLength >= 8) return false;
            baseLength++;
        }
    }

    if (baseLength == 0) return false;
    if (hasExtension && extLength == 0) return false;

    return true;
}

DirectoryPacket FAT::WalkDirectory(const char* name, const uint8_t* sector) const {
    DirectoryPacket packet = {
        .cluster = 0,
        .size = 0,
        .isDirectory = false,
        .directoryState = DirectoryState::NotFound
    };
    if (IsValidSFNName(name) == false) return packet;
    uint8_t baseLength = 0;
    uint8_t extLength = 0;
    bool hasExtension = false;
    char shortName[11]; // 8.3 format, padded with spaces
    for (int i = 0; i < 11; i++) shortName[i] = ' ';

    for (size_t i = 0; name[i] != '\0'; i++) {
        char c = name[i];
        if (c >= 'a' && c <= 'z') c -= 32;
        if (c == '.') {
            hasExtension = true;
            continue;
        }
        if (hasExtension) shortName[8 + extLength++] = c;
        else shortName[baseLength++] = c;
    }

    for (uint32_t i = 0; i < BytesPerSector / sizeof(Directory); i++) {
        const Directory* entry = (Directory*)(sector + i * sizeof(Directory));
        if (entry->Name[0] == 0x00) {
            packet.directoryState = DirectoryState::EndOfDirectory;
            return packet; // no more entries and it wasn't found
        }
        if (entry->Name[0] == 0x2E) continue; // skip "." and ".." entries
        if (entry->Name[0] == 0xE5) continue;
        if (entry->Attributes & 0x08) continue; // skip volume label
        if (entry->Attributes == 0x0F) continue; // skip long file
        for (int j = 0; j < 11; j++) if (entry->Name[j] != shortName[j]) goto nextEntry;
        if (entry->Attributes & 0x10) packet.isDirectory = true;
        packet.cluster = entry->FirstCluster | (IsFAT32 ? (uint32_t)(entry->FirstClusterHigh & 0x0FFF) << 16 : 0);
        packet.size = entry->FileSize;
        packet.directoryState = DirectoryState::Found;
        return packet;
        nextEntry:; // awful
    }
    return packet; // not found. this shouldn't be reached normally although if the sector does not include all directory entries it's possible.
}

DirectoryPacket FAT::ResolvePath(const char* path) const {
    DirectoryPacket packet = {
        .cluster = 0,
        .size = 0,
        .isDirectory = true,
        .directoryState = DirectoryState::Found
    };

    if (!path || path[0] != '/')
        return {
            .cluster = 0,
            .size = 0,
            .isDirectory = false,
            .directoryState = DirectoryState::NotFound
        };

    int pathPointer = 0;
    while (true) {
        int nameLength = 0;

        if (path[pathPointer] == '/') pathPointer++;
        if (path[pathPointer] == '\0') return packet;

        char name[13] = {};
        for (int i = 0; path[pathPointer + i] != '\0' && path[pathPointer + i] != '/'; i++) {
            if (i >= 12) return {
                .cluster = 0,
                .size = 0,
                .isDirectory = false,
                .directoryState = DirectoryState::NotFound
            };
            name[i] = path[pathPointer + i];
            nameLength++;
        }

        packet = FindInDirectory(name, packet);
        if (packet.directoryState != DirectoryState::Found) return packet;
        pathPointer += nameLength;

        // End of path
        if (path[pathPointer] == '\0') {
            return packet;
        }

        // Another component follows, so this must be a directory.
        if (!packet.isDirectory) {
            packet.directoryState = DirectoryState::NotFound;
            return packet;
        }
        // Trailing slash
        if (path[pathPointer + 1] == '\0') return packet;
    }
}

bool FAT::ReadFile(DirectoryPacket dir, uint8_t* buffer, size_t bufferSize) const {
    if (dir.directoryState != DirectoryState::Found) return false;
    if (dir.isDirectory) return false;
    if (bufferSize < dir.size) return false;
    if (dir.size == 0) return true; // probably a directory but we dont need to waste time either way
    if (dir.size > 0 && buffer == nullptr) return false;

    uint32_t bytesRead = 0;
    uint32_t cluster = dir.cluster;
    uint32_t clustersVisited = 0;
    while (!IsEndOfChain(cluster) && cluster >= 2 && cluster < ClusterCount + 2) {
        if (++clustersVisited > ClusterCount) return false; // prevent infinite loops in case of a corrupted FAT
        for (int i = 0; i < SectorsPerCluster; i++) {
            if (disk.GetSectors(DataStartLBA + (cluster - 2) * SectorsPerCluster + i, 1, sectorBuffer) != 0) return false;
            uint32_t bytesToCopy = BytesPerSector > (dir.size - bytesRead) ? (dir.size - bytesRead) : BytesPerSector;
            for (uint32_t j = 0; j < bytesToCopy; j++) buffer[bytesRead + j] = sectorBuffer[j];
            bytesRead += bytesToCopy;
            if (bytesRead >= dir.size) return true;
        }
        cluster = GetNextCluster(cluster);
    }

    return bytesRead >= dir.size;
}

DirectoryPacket FAT::FindInDirectory(const char* name, DirectoryPacket dir) const {
    DirectoryPacket packet = {
        .cluster = 0,
        .size = 0,
        .isDirectory = false,
        .directoryState = DirectoryState::NotFound
    };
    if (dir.cluster == 0 && !IsFAT32) {
        // root dir handling is a lot easier lmao
        for (uint32_t i = 0; i < RootDirectorySectors; i++) {
            if (disk.GetSectors(RootDirectoryLBA + i, 1, sectorBuffer) != 0) {
                packet.directoryState = DirectoryState::Bad;
                return packet;
            }
            packet = WalkDirectory(name, sectorBuffer);
            if (packet.directoryState != DirectoryState::NotFound) return packet;
        }
    }
    else {
        uint32_t clustersVisited = 0;
        uint32_t cluster = dir.cluster;
        if (cluster == 0 && IsFAT32) cluster = RootDirectoryCluster; // for FAT32 RootDirectoryLBA is just another fucking dir lmao
        if (cluster < 2 || cluster >= ClusterCount + 2) {
            packet.directoryState = DirectoryState::Bad;
            return packet; // invalid cluster number
        }
        while (!IsEndOfChain(cluster) && cluster >= 2 && cluster < ClusterCount + 2) {
            if (++clustersVisited > ClusterCount || IsBadCluster(cluster) ||
                cluster < 2 || cluster >= ClusterCount + 2) {
                packet.directoryState = DirectoryState::Bad;
                return packet; // prevent infinite loops in case of a corrupted FAT
            }
            for (int i = 0; i < SectorsPerCluster; i++) {
                if (disk.GetSectors(DataStartLBA + (cluster - 2) * SectorsPerCluster + i, 1, sectorBuffer) != 0) {
                    packet.directoryState = DirectoryState::Bad;
                    return packet;
                }
                packet = WalkDirectory(name, sectorBuffer);
                if (packet.directoryState != DirectoryState::NotFound) return packet;
            }
            cluster = GetNextCluster(cluster);
        }
    }
    return packet; // not found
}

FAT12::FAT12(Disk& disk, uint32_t partitionLBA) : FAT(disk, partitionLBA) {
    if (!disk.GetSectorLegacy(partitionLBA, sectorBuffer)) return;
    VBR* vbr = (VBR*)(sectorBuffer);

    BytesPerSector = vbr->bpb.SectorSize;
    SectorsPerCluster = vbr->bpb.SectorsPerCluster;
    SectorsPerFAT = vbr->bpb.SectorsPerFAT16;
    RootEntryCount = vbr->bpb.RootDirEntries;

    FATStartLBA = PartitionLBA + vbr->bpb.ReservedSectors;
    RootDirectoryLBA = FATStartLBA + vbr->bpb.FATCount * SectorsPerFAT;
    RootDirectorySectors = (RootEntryCount * 32 + BytesPerSector - 1) / BytesPerSector;
    DataStartLBA = RootDirectoryLBA + RootDirectorySectors;

    uint32_t totalSectors = vbr->bpb.TotalSectors16 ? vbr->bpb.TotalSectors16 : vbr->bpb.TotalSectors32;
    ClusterCount = (totalSectors - (vbr->bpb.ReservedSectors + vbr->bpb.FATCount * SectorsPerFAT + RootDirectorySectors)) / SectorsPerCluster;

    if (ClusterCount > 4084) {
        BytesPerSector = 0;
        return; // not a FAT12 volume
    }
}

ClusterPacket FAT12::GetFATEntryLocation(uint32_t clusterNumber) const {
    uint32_t fatOffset = clusterNumber + (clusterNumber / 2);
    return {
        .LBA = FATStartLBA + fatOffset / BytesPerSector,
        .offset = (uint16_t)(fatOffset % BytesPerSector),
        .SpansMultipleSectors = (fatOffset % BytesPerSector) == (BytesPerSector - 1)
    };
}

uint32_t FAT12::GetNextCluster(uint32_t clusterNumber) const {
    ClusterPacket packet = GetFATEntryLocation(clusterNumber);
    if (!disk.GetSectorLegacy(packet.LBA, sectorBuffer)) {
        return 0xFF7; // bad cluster
    }
    if (packet.SpansMultipleSectors) {
        if (!disk.GetSectorLegacy(packet.LBA + 1, sectorBuffer + BytesPerSector)) {
            return 0xFF7; // bad cluster
        }
    }
    uint16_t entry = static_cast<uint16_t>(sectorBuffer[packet.offset]) | (static_cast<uint16_t>(sectorBuffer[packet.offset + 1]) << 8);
    if (clusterNumber & 1) entry >>= 4;
    else entry &= 0x0FFF;
    return entry;
}

bool FAT12::IsEndOfChain(uint32_t cluster) const {
    return cluster > 0xFEF;
}

bool FAT12::IsBadCluster(uint32_t cluster) const {
    return cluster == 0xFF7;
}

FAT16::FAT16(Disk& disk, uint32_t partitionLBA) : FAT(disk, partitionLBA) {
    if (disk.GetSectors(partitionLBA, 1, sectorBuffer) != 0) return;
    VBR* vbr = (VBR*)(sectorBuffer);

    BytesPerSector = vbr->bpb.SectorSize;
    SectorsPerCluster = vbr->bpb.SectorsPerCluster;
    SectorsPerFAT = vbr->bpb.SectorsPerFAT16;
    RootEntryCount = vbr->bpb.RootDirEntries;

    FATStartLBA = PartitionLBA + vbr->bpb.ReservedSectors;
    RootDirectoryLBA = FATStartLBA + vbr->bpb.FATCount * SectorsPerFAT;
    RootDirectorySectors = (RootEntryCount * 32 + BytesPerSector - 1) / BytesPerSector;
    DataStartLBA = RootDirectoryLBA + RootDirectorySectors;
    
    uint32_t totalSectors = vbr->bpb.TotalSectors16 ? vbr->bpb.TotalSectors16 : vbr->bpb.TotalSectors32;

    ClusterCount = (totalSectors- (vbr->bpb.ReservedSectors + vbr->bpb.FATCount * SectorsPerFAT + RootDirectorySectors)) / SectorsPerCluster;
    
    if (ClusterCount <= 4084 || ClusterCount >= 65525) {
        BytesPerSector = 0;
        return;
    }
}

ClusterPacket FAT16::GetFATEntryLocation(uint32_t clusterNumber) const {
    uint32_t fatOffset = clusterNumber * 2;
    return {
        .LBA = FATStartLBA + fatOffset / BytesPerSector,
        .offset = (uint16_t)(fatOffset % BytesPerSector),
        .SpansMultipleSectors = false
    };
}

uint32_t FAT16::GetNextCluster(uint32_t clusterNumber) const {
    if (clusterNumber >= ClusterCount + 2) return 0xFFF7;
    ClusterPacket packet = GetFATEntryLocation(clusterNumber);
    if (disk.GetSectors(packet.LBA, 1, sectorBuffer) != 0) return 0xFFF7; // bad cluster
    uint16_t entry = sectorBuffer[packet.offset];
    entry |= (uint16_t)(sectorBuffer[packet.offset + 1]) << 8;
    return entry;
}

bool FAT16::IsEndOfChain(uint32_t cluster) const {
    return cluster > 0xFFEF;
}

bool FAT16::IsBadCluster(uint32_t cluster) const {
    return cluster == 0xFFF7;
}

FAT32::FAT32(Disk& disk, uint32_t partitionLBA) : FAT(disk, partitionLBA) {
    if (!disk.GetSectorLegacy(partitionLBA, sectorBuffer)) return;
    VBR* vbr = (VBR*)(sectorBuffer);

    BytesPerSector = vbr->bpb.SectorSize;
    SectorsPerCluster = vbr->bpb.SectorsPerCluster;
    SectorsPerFAT = vbr->ebr.fat32ebr.SectorsPerFAT32;
    RootEntryCount = vbr->bpb.RootDirEntries;

    FATStartLBA = PartitionLBA + vbr->bpb.ReservedSectors;
    RootDirectoryLBA = FATStartLBA + vbr->bpb.FATCount * SectorsPerFAT;
    RootDirectorySectors = (RootEntryCount * 32 + BytesPerSector - 1) / BytesPerSector;
    DataStartLBA = RootDirectoryLBA + RootDirectorySectors;
    
    uint16_t flags = vbr->ebr.fat32ebr.ExtendedFlags;
    
    if (flags & 0x80) {
        uint8_t activeFAT = flags & 0x0F;
        if (activeFAT >= vbr->bpb.FATCount) {
            BytesPerSector = 0;
            return;
        }
        else FATStartLBA += activeFAT * SectorsPerFAT;
    }
    
    uint32_t totalSectors = vbr->bpb.TotalSectors16 ? vbr->bpb.TotalSectors16 : vbr->bpb.TotalSectors32;

    ClusterCount = (totalSectors - (vbr->bpb.ReservedSectors + vbr->bpb.FATCount * SectorsPerFAT + RootDirectorySectors)) / SectorsPerCluster;
    
    if (ClusterCount < 65525) {
        BytesPerSector = 0;
        return;
    }
    
    RootDirectoryCluster = vbr->ebr.fat32ebr.RootClusterNumber;
    IsFAT32 = true;
}

ClusterPacket FAT32::GetFATEntryLocation(uint32_t clusterNumber) const {
    uint32_t fatOffset = clusterNumber * 4;
    return {
        .LBA = FATStartLBA + fatOffset / BytesPerSector,
        .offset = (uint16_t)(fatOffset % BytesPerSector),
        .SpansMultipleSectors = false
    };
}

uint32_t FAT32::GetNextCluster(uint32_t clusterNumber) const {
    if (clusterNumber >= ClusterCount + 2) return 0x0FFFFFF7;
    ClusterPacket packet = GetFATEntryLocation(clusterNumber);
    if (!disk.GetSectorLegacy(packet.LBA, sectorBuffer)) return 0x0FFFFFF7; // bad cluster
    uint32_t entry = 0;
    for (int i = 0; i < 4; i++) entry |= (uint32_t)(sectorBuffer[packet.offset + i]) << (8 * i);
    return entry & 0x0FFFFFFF;
}

bool FAT32::IsEndOfChain(uint32_t cluster) const {
    return cluster > 0x0FFFFFEF;
}

bool FAT32::IsBadCluster(uint32_t cluster) const {
    return cluster == 0x0FFFFFF7;
}
