#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd
	$hWnd = GUICreate("test")
	MsgBox($MB_SYSTEMMODAL, "Get ClassName", "ClassName of " & $hWnd & ": " & _WinAPI_GetClassName($hWnd))
EndFunc   ;==>Example
