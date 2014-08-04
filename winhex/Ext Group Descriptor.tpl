template "Ext2/Ext3 Group Descriptor"

// Created by Jens Kirschner on Sep 29, 2004
// X-Ways Software Technology AG

description "Locates the meta blocks for a block group"
applies_to disk
sector-aligned
multiple

begin
	uint32	"Block bitmap block"
	uint32	"Inode bitmap block"
	uint32	"Inode table block"
	uint16	"Free blocks count"
	uint16	"Free Inodes count"
	uint16	"Directories count"
	uint16	"Padding"	
	hex 12	"Reserved"
end
