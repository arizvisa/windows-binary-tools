#include <GuiMenu.au3>

Example()

Func Example()
	Local $hWnd, $hMain, $aRect

	; Open Notepad
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; Get File menu rectangle
	$aRect = _GUICtrlMenu_GetItemRect($hWnd, $hMain, 0)

	Writeln("File X1: " & $aRect[0])
	Writeln("File Y1: " & $aRect[1])
	Writeln("File X2: " & $aRect[2])
	Writeln("File Y2: " & $aRect[3])
EndFunc   ;==>Example

; Write a line of text to Notepad
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CRLF)
EndFunc   ;==>Writeln
