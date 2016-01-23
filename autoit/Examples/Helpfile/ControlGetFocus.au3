#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the control that has keyboard focus in Notepad. The handle returned by WinWait is used for the "title" parameter of ControlGetFocus.
	Local $sControl = ControlGetFocus($hWnd)

	; Display the control that has keyboard focus.
	MsgBox($MB_SYSTEMMODAL, "", "The control that has keyboard focus in Notepad is: " & $sControl)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
