template "NTFS FILE Record"

// X-Ways Software Technology AG
// To be applied to the NTFS Master File Table's (MFT's) FILE records.
// Proceeding to adjacent records does not work correctly if the
// number or types of attributes are different.

description "To be applied to records in the Master File Table"
applies_to disk
sector-aligned
multiple

begin
	char[4]	"Signature: FILE"
	uint16	"Offset to update sequence"
	uint16	"Update sequence size in words"
	int64		"Logfile sequence number"
	uint16	"Use/deletion count"
	uint16 	"Hard-link count"
	uint16	"Offset to the first attribute"
	hexadecimal uint16 Flags
	uint32	"Logical size of this record"
	uint32	"Physical size of the record"
	int64		"Base record (0: itself)"
	uint16	"ID of next attribute"
	IfGreater "Offset to the first attribute" 55
		move 2
		uint32 "ID of this FILE record"
	EndIf
	goto "Offset to update sequence"
	hex 2		"Update sequence number"
	//Update Sequence Array -> disregarded here
	goto "Offset to the first attribute"

	{
		endsection

		hexadecimal uint32 "Attribute type"
		IfEqual "Attribute type" 4294967295
			ExitLoop
		EndIf
		uint16 "Length of the attribute"
		move 2
		uint8 "1=non-resident"
		move 5
		uint16 "Attribut ID"
		move -16

		IfEqual "Attribute type" 16 //Attribute type 0x10: Standard Information
			move 24
			FileTime "Creation in UTC"
			FileTime "Modification in UTC"
			FileTime "Record change in UTC"
			FileTime "Last access in UTC"
			hexadecimal uint32 Flags
			move -60
		EndIf
		IfEqual "Attribute type" 48 //Attribute type 0x30: Filename
			move 24
			uint32	"Parent FILE record"
			move 2
			uint16	"Parent use/del. count"
			FileTime "Creation in UTC"
			FileTime "Modification in UTC"
			FileTime "Record change in UTC"
			FileTime "Last access in UTC"
			move 0x18
			uint8 "Namelen"
			uint8 "Namespace"
			char16[Namelen] "Filename"
			move -90
			move (Namelen*(-2))
		EndIf
		move "Length of the attribute"

		IfEqual "Length of the attribute" 0
			ExitLoop
		EndIf
	}[16] //arbitrary number to avoid infinite loops
	
	Goto 0
	Move "Physical size of the record"
end