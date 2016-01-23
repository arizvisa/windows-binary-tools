#include <MsgBoxConstants.au3>

Local $sString = "This is a sentence with whitespace." ; Check whether this string contains only alphanumeric characters.
If StringIsAlNum($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable contains only alphanumeric characters.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable does not contain alphanumeric characters.")
EndIf
