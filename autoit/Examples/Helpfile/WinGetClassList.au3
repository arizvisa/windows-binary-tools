#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the classlist of the Notepad window using the handle returned by WinWait.
	Local $sClassList = WinGetClassList($hWnd)

	; Display the classlist.
	MsgBox($MB_SYSTEMMODAL, "", $sClassList)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
