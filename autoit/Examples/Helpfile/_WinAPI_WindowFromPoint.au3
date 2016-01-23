#include <WinAPI.au3>

HotKeySet("{ESC}", "Close") ; Set ESC as a hotkey to exit the script.

Global $g_tStruct = DllStructCreate($tagPOINT) ; Create a structure that defines the point to be checked.

Example()

Func Example()
	Local $hWnd

	While 1
		ToolTip("")
		Position() ; Update the X and Y elements with the X and Y co-ordinates of the mouse.
		$hWnd = _WinAPI_WindowFromPoint($g_tStruct) ; Retrieve the window handle.
		ToolTip($hWnd) ; Set the tooltip with the handle under the mouse pointer.
		Sleep(100)
	WEnd
EndFunc   ;==>Example

Func Position()
	DllStructSetData($g_tStruct, "x", MouseGetPos(0))
	DllStructSetData($g_tStruct, "y", MouseGetPos(1))
EndFunc   ;==>Position

Func Close()
	Exit
EndFunc   ;==>Close
