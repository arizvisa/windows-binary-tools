#include <MsgBoxConstants.au3>

Local $oShell = ObjCreate("shell.application")
If IsObj($oShell) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is an object")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not an object")
EndIf
