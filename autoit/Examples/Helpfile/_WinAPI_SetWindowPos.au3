#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	; Assign a Local variable the handle of the NotePad window
	Local $hWnd = WinGetHandle("[CLASS:Notepad]")

	; If the window does not exists, display a message and return False.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Notepad window not found.")
		Return False
	EndIf

	; Assign a Local variable the style of the Notepad window.
	Local $iStyle = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)

	; Remove from the window style the MAXIMIZEBOX, MINIMIZEBOX and SIZEBOX styles.
	$iStyle = BitXOR($iStyle, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX)

	; Set the style of the window.
	_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, $iStyle)

	; Apply the style
	_WinAPI_SetWindowPos($hWnd, $HWND_TOP, 0, 0, 0, 0, BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
EndFunc   ;==>Example
