#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	WinWait("[CLASS:Notepad]", "", 10)

	; Test if the window exists and display the results.
	If WinExists("[CLASS:Notepad]") Then
		MsgBox($MB_SYSTEMMODAL, "", "Window exists")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Window does not exist")
	EndIf
EndFunc   ;==>Example
