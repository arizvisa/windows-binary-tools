#include <MsgBoxConstants.au3>

Local $sString = "This is a sentence with whitespace." ; Check whether this string contains only ASCII characters.
If StringIsASCII($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable contains ASCII characters.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable does not contain ASCII characters.")
EndIf
