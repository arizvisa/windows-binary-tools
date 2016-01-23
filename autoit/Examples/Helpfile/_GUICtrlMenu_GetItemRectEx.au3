#include <GuiMenu.au3>

Example()

Func Example()
	Local $hWnd, $hMain, $tRECT

	; Open Notepad
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)

	; Get File menu rectangle
	$tRECT = _GUICtrlMenu_GetItemRectEx($hWnd, $hMain, 0)

	Writeln("File X1: " & DllStructGetData($tRECT, "Left"))
	Writeln("File Y1: " & DllStructGetData($tRECT, "Top"))
	Writeln("File X2: " & DllStructGetData($tRECT, "Right"))
	Writeln("File Y2: " & DllStructGetData($tRECT, "Bottom"))
EndFunc   ;==>Example

; Write a line of text to Notepad
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CRLF)
EndFunc   ;==>Writeln
