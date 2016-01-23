#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hWnd, $hDC
	$hWnd = GUICreate("test")
	$hDC = _WinAPI_GetDC($hWnd)
	MsgBox($MB_SYSTEMMODAL, "Handle", "Display Device: " & $hDC)
	_WinAPI_ReleaseDC($hWnd, $hDC)
EndFunc   ;==>Example
