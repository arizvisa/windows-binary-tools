#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd = GUICreate("Example", 200, 200)
	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", 100)
	DllStructSetData($tPoint, "Y", 160)
	GUISetState(@SW_SHOW)
	Sleep(1000)
	_WinAPI_ClientToScreen($hWnd, $tPoint)
	MsgBox($MB_SYSTEMMODAL, "_WinAPI_ClientToScreen Example", "Screen Cordinates of client's x,y position: 100,160 is: " & @CRLF & _
			"X: " & DllStructGetData($tPoint, "X") & @CRLF & _
			"Y: " & DllStructGetData($tPoint, "Y") & @CRLF)
EndFunc   ;==>Example
