template "HFS+ Volume Header"
description "Located 1024 bytes from the start of the volume"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// Modified by Jens Kirschner
// 7Safe Information Security Ltd.

// A copy of this volume header, the alternate volume header, is stored starting 1024 bytes before the end of the volume. 

big-endian
sector-aligned
applies_to disk

begin
	char[2]	signature //H+ or HX
	UInt16	version
	Hex 4	attributes //00 00 08 00 set? Volume Inconsistent!
	char[4]	lastMountedVersion //HFSJ if journaled, 10.0 if not; fsck and other tools also possible
	UInt32	journalInfoBlock
 
	AppleDateTime	createDate
	AppleDateTime	modifyDate
	AppleDateTime	backupDate
	AppleDateTime	checkedDate
 
	UInt32	fileCount
	UInt32	folderCount
 
	UInt32	blockSize
	UInt32	totalBlocks
	UInt32	freeBlocks
 
	UInt32	nextAllocation
	UInt32	rsrcClumpSize
	UInt32	dataClumpSize
	UInt32	nextCatalogID
 
	UInt32	writeCount
	Hex 8	encodingsBitmap
 
	section "FinderInfo Array"

	UInt32	"OS Dir ID"
	UInt32	"Finder Dir ID"
	UInt32	"Mount Open Dir"
	UInt32	"OS8/9 Dir ID"
	UInt32	"reserved"
	UInt32	"OS X Dir ID"
	Int64		"Volume ID (Int64)"
	move -8
	Hex 8		"Volume ID (Hex)"
 
	section "AllocationFile DataFork"
	Int64	logicalSize
	UInt32	clumpSize
	UInt32	totalBlocks
	{
	UInt32	startBlock
	UInt32	blockCount
	}[8]

	section "ExtentsOverflowFile DataFork"
	Int64	logicalSize
	UInt32	clumpSize
	UInt32	totalBlocks
	{
	UInt32	startBlock
	UInt32	blockCount
	}[8]

	section "CatalogFile DataFork"
	Int64	logicalSize
	UInt32	clumpSize
	UInt32	totalBlocks
	{
	UInt32	startBlock
	UInt32	blockCount
	}[8]

	section "AttributesFile DataFork"
	Int64	logicalSize
	UInt32	clumpSize
	UInt32	totalBlocks
	{
	UInt32	startBlock
	UInt32	blockCount
	}[8]

	section "StartupFile DataFork"
	Int64	logicalSize
	UInt32	clumpSize
	UInt32	totalBlocks
	{
	UInt32	startBlock
	UInt32	blockCount
	}[8]
end