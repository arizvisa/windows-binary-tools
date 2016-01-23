#include <MsgBoxConstants.au3>

Local $iLife = 42
If IsNumber($iLife) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not a number")
EndIf
