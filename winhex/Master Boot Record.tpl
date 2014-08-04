template "Master Boot Record"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// To be applied to sector 0 of a physical hard disk.

description "Contains partition table"
applies_to disk
sector-aligned
requires 510 "55 AA"

begin
	read-only hex 440 "Master bootstrap loader code"

	// Addition by Daniel B. Sedory:
	big-endian hexadecimal uint32 "Windows disk signature"
	move -4
	hexadecimal uint32 "Same reversed"
	// This SN is created by any NT-type OS (NT, 2000, XP,
	// 2003) and used in the Windows Registry.

	move 2

	numbering 1

	{
	section	"Partition Table Entry #~"
	hex 1		"80 = active partition"
	uint8		"Start head"
	uint_flex "5,4,3,2,1,0" "Start sector"
	move -4
	uint_flex "7,6,15,14,13,12,11,10,9,8" "Start cylinder"
	move -2
	hex 1		"Partition type indicator (hex)"
	uint8		"End head"
	uint_flex "5,4,3,2,1,0" "End sector"
	move -4
	uint_flex "7,6,15,14,13,12,11,10,9,8" "End cylinder"
	move -2
	uint32	"Sectors preceding partition ~"
	uint32	"Sectors in partition ~"
	} [4]

	endsection
	read-only hex 2 "Signature (55 AA)"
end