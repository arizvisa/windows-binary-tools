#include <MsgBoxConstants.au3>

Local $bBoolean = True
If IsBool($bBoolean) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is boolean")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not boolean")
EndIf
