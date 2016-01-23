#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd, $tRECT
	$hWnd = GUICreate("test")
	$tRECT = _WinAPI_GetClientRect($hWnd)
	MsgBox($MB_SYSTEMMODAL, "Rect", _
			"Left..: " & DllStructGetData($tRECT, "Left") & @CRLF & _
			"Right.: " & DllStructGetData($tRECT, "Right") & @CRLF & _
			"Top...: " & DllStructGetData($tRECT, "Top") & @CRLF & _
			"Bottom: " & DllStructGetData($tRECT, "Bottom"))
EndFunc   ;==>Example
