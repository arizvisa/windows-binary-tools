#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the position as well as height and width of the active window.
	Local $aPos = WinGetPos("[ACTIVE]")

	; Display the array values returned by WinGetPos.
	MsgBox($MB_SYSTEMMODAL, "", "X-Pos: " & $aPos[0] & @CRLF & _
			"Y-Pos: " & $aPos[1] & @CRLF & _
			"Width: " & $aPos[2] & @CRLF & _
			"Height: " & $aPos[3])
EndFunc   ;==>Example
