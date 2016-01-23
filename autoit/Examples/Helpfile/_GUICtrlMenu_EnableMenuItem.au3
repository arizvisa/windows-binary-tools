#include <GuiMenu.au3>

Example()

Func Example()
	Local $hWnd, $hMain

	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; Disable/Gray Help menu
	_GUICtrlMenu_EnableMenuItem($hMain, 4, 3)
EndFunc   ;==>Example
