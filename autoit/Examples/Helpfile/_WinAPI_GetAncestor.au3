#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hWnd, $hParent
	$hWnd = GUICreate("test")
	$hParent = _WinAPI_GetAncestor($hWnd, $GA_PARENT)
	MsgBox($MB_SYSTEMMODAL, "Parent", "Get Ancestor of " & $hWnd & ": " & $hParent)
	MsgBox($MB_SYSTEMMODAL, "Root", "Get Ancestor of " & $hParent & ": " & _WinAPI_GetAncestor($hWnd, $GA_ROOT))
	MsgBox($MB_SYSTEMMODAL, "Root Owner", "Get Ancestor of " & $hParent & ": " & _WinAPI_GetAncestor($hWnd, $GA_ROOTOWNER))
EndFunc   ;==>Example
