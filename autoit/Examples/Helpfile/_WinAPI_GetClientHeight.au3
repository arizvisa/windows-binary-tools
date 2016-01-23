#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd
	$hWnd = GUICreate("test")
	MsgBox($MB_SYSTEMMODAL, "Client", "Client Height: " & _WinAPI_GetClientHeight($hWnd))
EndFunc   ;==>Example
