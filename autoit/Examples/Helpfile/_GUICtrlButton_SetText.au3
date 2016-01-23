#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $y = 70, $a_idBtn[6], $iRand

	GUICreate("Buttons", 510, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	$a_idBtn[0] = GUICtrlCreateButton("Button1", 10, 10, 90, 50)

	For $x = 1 To 5
		$a_idBtn[$x] = GUICtrlCreateButton("Button" & $x + 1, 10, $y, 90, 50)
		$y += 60
	Next

	$iRand = Random(0, 5, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Setting Button" & $iRand + 1 & " Text")
	_GUICtrlButton_SetText($a_idBtn[$iRand], "New Text" & $iRand + 1)

	For $x = 0 To 5
		MemoWrite("$a_idBtn[" & $x & "] Text: " & _GUICtrlButton_GetText($a_idBtn[$x]))
	Next

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
