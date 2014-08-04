template "Ext2/Ext3 Directory Entry"

// Template by Eoghan Casey
// Revised by Jens Kirschner on Sep 29, 2004

// To be applied to a sector of a Ext2 drive
// that contains a directory starting with the
// first inode entry. This template only displays
// allocated files - deleted filenames are not displayed

description "Locates the Inode for a given filename"
applies_to disk
multiple

begin
	uint32	"Inode"
	uint16	"Entry length"
	uint8		"Name length"
	uint8		"Type (1=file 2=dir 7=sym.link)"
	char[Name length]	"File name"
	goto		0
	move		"Entry length"
end