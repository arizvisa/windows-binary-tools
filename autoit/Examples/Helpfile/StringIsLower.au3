#include <MsgBoxConstants.au3>

Local $sString = "lowercase" ; Check whether this string contains only lowercase characters.
If StringIsLower($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is a lowercase string")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not a lowercase string")
EndIf
