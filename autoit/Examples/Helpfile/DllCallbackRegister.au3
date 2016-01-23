#include <MsgBoxConstants.au3>

; Create callback function.
Local $hHandle = DllCallbackRegister("_EnumWindowsProc", "int", "hwnd;lparam")

; Call EnumWindows.
DllCall("user32.dll", "int", "EnumWindows", "ptr", DllCallbackGetPtr($hHandle), "lparam", 10)

; Delete callback function.
DllCallbackFree($hHandle)

; Callback Procedure
Func _EnumWindowsProc($hWnd, $lParam)
	; If the Title is empty or if the window is not visible then continue enumeration.
	If WinGetTitle($hWnd) = "" Or BitAND(WinGetState($hWnd), 2) = 0 Then Return 1

	Local $iRes = MsgBox(BitOR($MB_SYSTEMMODAL, $MB_OKCANCEL), _
			WinGetTitle($hWnd), "$hWnd=" & $hWnd & @CRLF & _
			"$lParam=" & $lParam & @CRLF & _
			"$hWnd(type)=" & VarGetType($hWnd))

	If $iRes <> $IDOK Then Return 0 ; Cancel/Close button clicked, return 0 to stop enumeration.

	Return 1 ; Return 1 to continue enumeration.
EndFunc   ;==>_EnumWindowsProc
