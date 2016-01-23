#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the PID of Notepad using the window handle returned by WinWait.
	Local $iPID = WinGetProcess($hWnd)

	; Display the PID of the window.
	MsgBox($MB_SYSTEMMODAL, "", "The PID is: " & $iPID)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
