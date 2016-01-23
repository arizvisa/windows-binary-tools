#include <MsgBoxConstants.au3>

Local $sString = "UPPERCASESTRING" ; Check whether this string contains only uppercase characters.
If StringIsUpper($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is an uppercase string")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not an uppercase string")
EndIf
