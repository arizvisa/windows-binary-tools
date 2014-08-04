template "Boot Sector FAT32"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// To be applied to sector 0 of a FAT32-formatted logical drive.

description "BIOS parameter block (BPB) and more"
applies_to disk
sector-aligned

requires 0x02	"90"
requires 0x52	"46 41 54 33 32" // ="FAT32" at offset 52
requires 0x1FE "55 AA"

begin
	read-only hex 3 "JMP instruction"
	char[8]	"OEM"

	section	"BIOS Parameter Block"
	uint16	"Bytes per sector"
	uint8		"Sectors per cluster"
	uint16	"Reserved sectors"
	uint8		"Number of FATs"
	uint16	"Root entries (unused)"
	uint16	"Sectors (on small volumes)"
	hex 1		"Media descriptor (hex)"
	uint16	"Sectors per FAT (small vol.)"
	uint16	"Sectors per track"
	uint16	"Heads"
	uint32	"Hidden sectors"
	uint32	"Sectors (on large volumes)"
	
	section	"FAT32 Section"
	uint32	"Sectors per FAT"
	uint16	"Extended flags"
	move -2
	uint_flex "7" "FAT mirroring disabled?"
	move -2
	uint16	"Version (usually 0)"
	uint32	"Root dir 1st cluster"
	uint16	"FSInfo sector"
	uint16	"Backup boot sector"
	read-only hex 12 "(Reserved)"
	endsection
	
	hex 1		"BIOS drive (hex, HD=8x)"
	read-only uint8 (Unused)
	hex 1		"Ext. boot signature (29h)"
	uint32	"Volume serial number (decimal)"
	move -4
	hex 4		"Volume serial number (hex)"
	char[11] "Volume label"
	char[8]	"File system"
	endsection

	goto		0x1FE
	read-only hex 2 "Signature (55 AA)"
end