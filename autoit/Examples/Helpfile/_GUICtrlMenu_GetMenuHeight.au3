#include <GuiMenu.au3>

Example()

Func Example()
	Local $hWnd, $hMain, $hFile

	; Open Notepad
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)
	$hFile = _GUICtrlMenu_GetItemSubMenu($hMain, 0)

	; Get/Set File menu max height
	Writeln("File menu max height: " & _GUICtrlMenu_GetMenuHeight($hFile))
	_GUICtrlMenu_SetMenuHeight($hFile, 100)
	Writeln("File menu max height: " & _GUICtrlMenu_GetMenuHeight($hFile))
EndFunc   ;==>Example

; Write a line of text to Notepad
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CRLF)
EndFunc   ;==>Writeln
