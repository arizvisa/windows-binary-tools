#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the handle of the Notepad window using the classname of Notepad.
	Local $hWnd = WinGetHandle("[CLASS:Notepad]")
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred when trying to retrieve the window handle of Notepad.")
		Exit
	EndIf

	; Display the handle of the Notepad window.
	MsgBox($MB_SYSTEMMODAL, "", $hWnd)

	; Close the Notepad window using the handle returned by WinGetHandle.
	WinClose($hWnd)
EndFunc   ;==>Example
