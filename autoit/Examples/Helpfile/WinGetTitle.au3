#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the window title of the active window.
	Local $sText = WinGetTitle("[ACTIVE]")

	; Display the window title.
	MsgBox($MB_SYSTEMMODAL, "", $sText)
EndFunc   ;==>Example
