#include <MsgBoxConstants.au3>

Local $tStruct = DllStructCreate("wchar[256]")
If IsDllStruct($tStruct) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable is a dll structure")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable is not a dll structure")
EndIf
