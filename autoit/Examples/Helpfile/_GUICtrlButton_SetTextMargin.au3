#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $y = 70, $a_idBtn[6], $aMargins

	GUICreate("Buttons", 510, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	$a_idBtn[0] = GUICtrlCreateButton("Button1", 10, 10, 90, 50)
	_GUICtrlButton_SetTextMargin($a_idBtn[0], 10, 5, 10, 5)

	For $x = 1 To 5
		$a_idBtn[$x] = GUICtrlCreateButton("Button" & $x + 1, 10, $y, 90, 50)
		$y += 60
	Next

	For $x = 0 To 5
		$aMargins = _GUICtrlButton_GetTextMargin($a_idBtn[$x])
		MemoWrite("Button" & $x + 1 & " Margins:" & @CRLF & @TAB & _
				"Left.: " & $aMargins[0] & @TAB & "Top...: " & $aMargins[1] & @CRLF & @TAB & _
				"Right: " & $aMargins[2] & @TAB & "Bottom: " & $aMargins[3] & @CRLF)
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
