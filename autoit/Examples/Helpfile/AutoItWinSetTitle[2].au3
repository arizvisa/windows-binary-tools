#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Set the title of the AutoIt Hidden Window.
	AutoItWinSetTitle("My AutoIt Window")

	; Display AutoIt's Hidden Window.
	AutoItWinShow()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example

; Display AutoIt's Hidden Window. Returns the handle of the window.
Func AutoItWinShow()
	Local $hWnd = WinGetHandle(AutoItWinGetTitle()) ; Get the handle of the AutoIt Hidden Window by finding out the title of the AutoIt Hidden Window.
	WinMove($hWnd, "", (@DesktopWidth / 2) - 250, (@DesktopHeight / 2) - 250, 500, 500) ; Move the AutoIt Hidden Window and re-size for a better view.
	WinSetState($hWnd, "", @SW_SHOW) ; Show the AutoIt Hidden Window, normally this is hidden, but in the interest of this example I"m displaying it.
	Return $hWnd
EndFunc   ;==>AutoItWinShow
