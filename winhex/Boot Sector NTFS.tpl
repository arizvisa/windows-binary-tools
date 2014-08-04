template "Boot Sector NTFS"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// To be applied to sector 0 of an NTFS-formatted
// logical drive or to the mirror copy of the boot
// sector, which will be located near the end of
// the partition.

description "Boot sector of an NTFS partition"
applies_to disk
sector-aligned

requires 0x00	"EB" 					// bytes 0 to 2 are
requires 0x02	"90"					// JMP instruction
requires 0x03	"4E 54 46 53 20"	// ID must be "NTFS"
requires 0x1FE	"55 AA"				// "magic" signature

begin
	read-only hex 3	"JMP instruction"			//00
	char[8]				"File system ID"			//03
	uint16				"Bytes per sector"		//0B
	uint8					"Sectors per cluster"	//0D
	uint16				"Reserved sectors"		//0E
	hex 3					"(always zero)"			//10
	read-only hex 2	"(unused)"					//13 
	hex 1					"Media descriptor"		//15
	read-only hex 2	"(unused)"					//16
	uint16				"Sectors per track"		//18
	uint16				"Heads"						//1A
	uint32				"Hidden sectors"			//1C
	read-only hex 4	"(unused)"					//20
	read-only hex 4	"(always 80 00 80 00)"	//24
	int64					"Total sectors"			//28
	int64					"Start C# $MFT"			//30
	int64					"Start C# $MFTMirr"		//38
	int8					"FILE record size indicator"//40
	read-only uint24	"(unused)"
	int8					"INDX buffer size indicator"//44
	read-only uint24	"(unused)"
	hex 4					"32-bit serial number (hex)"
	move -4
	hexadecimal uint32 "32-bit SN (hex, reversed)"
	move -4
	hex 8					"64-bit serial number (hex)"
	uint32				"Checksum"					//50
	goto 0x1FE			//boot load code follows
	read-only hex 2	"Signature (55 AA)"		//1FE
end