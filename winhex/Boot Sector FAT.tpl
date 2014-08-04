template "Boot Sector FAT"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// Boot sector format for MSDOS 4.0 onwards (incl. Windows 9x)
// To be applied to sector 0 of a FAT12/FAT16-formatted logical drive.

description "BIOS parameter block (BPB) and more"
applies_to disk
sector-aligned

requires 0x0	"EB"	// JMP instruction will usually be EB xx 90
requires 0x2	"90"	// (though older drives may use E9 xx xx)
requires 0x1FE "55 AA"

begin
	read-only hex 3 "JMP instruction"
	char[8]	"OEM"

	section	"BIOS Parameter Block"
	uint16	"Bytes per sector"
	uint8		"Sectors per cluster"
	uint16	"Reserved sectors"
	uint8		"Number of FATs"
	uint16	"Root entries"
	uint16	"Sectors (under 32 MB)"
	hex 1		"Media descriptor (hex)"
	uint16	"Sectors per FAT"
	uint16	"Sectors per track"
	uint16	"Heads"
	uint32	"Hidden sectors"
	uint32	"Sectors (over 32 MB)"
	endsection

	hex 1		"BIOS drive (hex, HD=8x)"
	read-only uint8 "(Unused)"
	hex 1		"Ext. boot signature (29h)"
	uint32	"Volume serial number (decimal)"
	move -4
	hex 4		"Volume serial number (hex)"
	char[11] "Volume label"
	char[8]	"File system"

	goto		0x1FE
	read-only hex 2 "Signature (55 AA)"
end