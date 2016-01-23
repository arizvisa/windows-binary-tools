#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd = GUICreate("test")
	Local $tPoint = _WinAPI_GetMousePos()
	Local $tPoint2 = _WinAPI_GetMousePos(True, $hWnd)

	MsgBox($MB_SYSTEMMODAL, "Mouse Pos", _
			"X = " & DllStructGetData($tPoint, "X") & @CRLF & "Y = " & DllStructGetData($tPoint, "Y") & @CRLF & @CRLF & _
			"Client" & @CRLF & "X = " & DllStructGetData($tPoint2, "X") & @CRLF & "Y = " & DllStructGetData($tPoint2, "Y"))
EndFunc   ;==>Example
