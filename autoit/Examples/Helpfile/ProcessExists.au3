#include <MsgBoxConstants.au3>

If ProcessExists("notepad.exe") Then ; Check if the Notepad process is running.
	MsgBox($MB_SYSTEMMODAL, "", "Notepad is running")
Else
	MsgBox($MB_SYSTEMMODAL, "", "Notepad is not running")
EndIf
