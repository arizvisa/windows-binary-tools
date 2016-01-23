#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWin = _WinAPI_GetDesktopWindow()
	MsgBox($MB_SYSTEMMODAL, "", WinGetTitle($hWin))
	MsgBox($MB_SYSTEMMODAL, "", $hWin)
EndFunc   ;==>Example
