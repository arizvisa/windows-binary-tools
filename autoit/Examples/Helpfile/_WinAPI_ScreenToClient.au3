#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd = GUICreate("Example", 200, 200)
	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", 641)
	DllStructSetData($tPoint, "Y", 459)
	GUISetState(@SW_SHOW)
	Sleep(1000)
	_WinAPI_ScreenToClient($hWnd, $tPoint)
	MsgBox($MB_SYSTEMMODAL, "_WinAPI_ClientToScreen Example", "Screen Cordinates of 641,459 is x,y position of client: " & @CRLF & _
			"X: " & DllStructGetData($tPoint, "X") & @CRLF & _
			"Y: " & DllStructGetData($tPoint, "Y") & @CRLF)
EndFunc   ;==>Example
