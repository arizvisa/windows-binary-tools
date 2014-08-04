template "FAT Directory Entry"

// Template by Roger Röhrig and Stefan Fleischmann

// To be applied to a sector of a VFAT (FAT16 or FAT32)
// drive that contains a directory. Only suitable for
// LFN (long filename) directory entries.

description "Long entry format"
applies_to disk
requires 11 0F
multiple

begin
   hex 1			"Sequence number"
	char16[5]	"Filename (5 chars, FF-padded)"
	goto 14
	char16[6]	"Filename (next 6 chars)"
	goto 28
	char16[2]	"Filename (next 2 chars)"
	goto 11
	hex 1			"0F = LFN entry"
	move			-1
	binary		"Attributes ( - -a-dir-vol-s-h-r)"
	read-only byte "(reserved)"
	hex 1			"SFN checksum"
	goto 26
	uint16		"16-bit cluster # (always 0)"
	move 4
end