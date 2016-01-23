#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd
	$hWnd = GUICreate("test")
	MsgBox($MB_SYSTEMMODAL, "Client", "Client Width: " & _WinAPI_GetClientWidth($hWnd))
EndFunc   ;==>Example
