template "FAT Directory Entry"

// Template by Stefan Fleischmann
// X-Ways Software Technology AG

// To be applied to a sector of a FAT16 or FAT32 drive
// that contains a directory. Not suitable for LFN
// (long filename) directory entries.

description "Normal/short entry format"
applies_to disk
multiple

begin
	char[8]	"Filename (blank-padded)"
	char[3]	"Extension (blank-padded)"
	hex 1		"0F = LFN entry"
	move		-1
	binary	"Attributes ( - -a-dir-vol-s-h-r)"
	goto		0
	hex 1		"00 = Never used, E5 = Erased"
	move		11
	read-only byte "(reserved)"
	move		1
	DOSDateTime	"Creation date & time"
	move		-5
	byte		"Cr. time refinement in 10-ms units"
	move		2
	DOSDateTime	"Access date (no time!)"
	move		2
	DOSDateTime	"Update date & time"
	move		-6
	uint16	"(FAT 32) High word of cluster #"
	move		4
	uint16	"16-bit cluster #"
	uint32	"File size (zero for a directory)"
end