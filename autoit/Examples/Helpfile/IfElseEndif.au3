#include <MsgBoxConstants.au3>

Local $sString = ""
If $sString > 0 Then
	MsgBox($MB_SYSTEMMODAL, "", "Value is positive.")
ElseIf $sString < 0 Then
	MsgBox($MB_SYSTEMMODAL, "", "Value is negative.")
Else
	If StringIsXDigit($sString) Then
		MsgBox($MB_SYSTEMMODAL, "", "Value might be hexadecimal!")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Value is a string.")
	EndIf
EndIf
