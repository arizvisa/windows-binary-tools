#include <MsgBoxConstants.au3>

Local $sString = "This is a sentence with whitespace." ; Check whether this string contains only alphabetic characters.
If StringIsAlpha($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable contains only alphabetic characters.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable does not contain alphabetic characters.")
EndIf
