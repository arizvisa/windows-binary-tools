#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the window text of the active window.
	Local $sText = WinGetText("[ACTIVE]")

	; Display the window text.
	MsgBox($MB_SYSTEMMODAL, "", $sText)
EndFunc   ;==>Example
