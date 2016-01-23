#include <MsgBoxConstants.au3>

If WinActive("[CLASS:Notepad]") Then ; Check if Notepad is currently active.
	MsgBox($MB_SYSTEMMODAL, "", "WinActive" & @CRLF & "Notepad is active.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "WinActive" & @CRLF & "Notepad is not active.")
EndIf
