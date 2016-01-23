#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd = GUICreate("test")
	Local $iX = _WinAPI_GetMousePosX()
	Local $iX2 = _WinAPI_GetMousePosX(True, $hWnd)
	Local $iY = _WinAPI_GetMousePosY()
	Local $iY2 = _WinAPI_GetMousePosY(True, $hWnd)

	MsgBox($MB_SYSTEMMODAL, "Mouse Pos", "X = " & $iX & @CRLF & "Y = " & $iY & @CRLF & @CRLF & _
			"Client" & @CRLF & "X = " & $iX2 & @CRLF & "Y = " & $iY2)
EndFunc   ;==>Example
