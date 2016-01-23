#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd, $idButton
	$hWnd = GUICreate("test")
	$idButton = GUICtrlCreateButton("button", 0, 0)
	MsgBox($MB_SYSTEMMODAL, "Handle", "Get Dialog Item: " & _WinAPI_GetDlgItem($hWnd, $idButton))
EndFunc   ;==>Example
