#include <MsgBoxConstants.au3>

Local $sString = "This is a string"
If IsString($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is a string")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not a string")
EndIf
