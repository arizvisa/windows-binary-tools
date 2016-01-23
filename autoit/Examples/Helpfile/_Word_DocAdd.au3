#include <MsgBoxConstants.au3>
#include <Word.au3>

Local $oWord = _Word_Create()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Add a new empty document
; *****************************************************************************
_Word_DocAdd($oWord)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAdd Example", "Error creating a new Word document." _
		 & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocAdd Example", "A new empty document has successfully been added.")
