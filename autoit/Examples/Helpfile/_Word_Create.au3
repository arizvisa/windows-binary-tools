#include <MsgBoxConstants.au3>
#include <Word.au3>

; *****************************************************************************
; Create a new Word object
; *****************************************************************************
_Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_Create Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
If @extended = 1 Then
	MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_Create Example", "MS Word was not running when _Word_Create was called.")
Else
	MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_Create Example", "MS Word was already running when _Word_Create was called.")
EndIf
