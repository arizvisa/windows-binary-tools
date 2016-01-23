#include <MsgBoxConstants.au3>

Local $sString = "   " & @CRLF & @CRLF & Chr(11) & @TAB & " " & @CRLF ; Check whether this string contains only whitespace characters.
If StringIsSpace($sString) Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable contains only whitespace characters.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "The variable does not contain whitespace characters.")
EndIf
