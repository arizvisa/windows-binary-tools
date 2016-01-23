#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Send a command to the edit control of Notepad to find the number of lines. The handle returned by WinWait is used for the "title" parameter of ControlCommand.
	Local $iCount = ControlCommand($hWnd, "", "Edit1", "GetLineCount", "")

	; Display the number of lines.
	MsgBox($MB_SYSTEMMODAL, "", "The number of lines in Notepad are: " & $iCount)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
