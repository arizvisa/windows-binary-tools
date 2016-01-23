#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idRdo, $idRdo2, $idChk

	GUICreate("Buttons", 400, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")

	$idRdo = GUICtrlCreateRadio("Radio1", 10, 10, 90, 50)

	$idRdo2 = GUICtrlCreateRadio("Radio2", 10, 60, 90, 50)
	_GUICtrlButton_SetCheck($idRdo2)
	_GUICtrlButton_SetFocus($idRdo2) ; set focus, shows this doesn't affect _GUICtrlButton_GetCheck

	$idChk = GUICtrlCreateCheckbox("Check1", 10, 120, 90, 50, BitOR($BS_AUTO3STATE, $BS_NOTIFY))
	_GUICtrlButton_SetCheck($idChk, $BST_INDETERMINATE)

	GUISetState(@SW_SHOW)

	MemoWrite("$idRdo checked status.: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($idRdo)) & @CRLF)
	MemoWrite("$idRdo2 checked status: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($idRdo2)) & @CRLF)
	MemoWrite("$idChk checked status.: " & @CRLF & @TAB & _ExplainCheckState(_GUICtrlButton_GetCheck($idChk)) & @CRLF)

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

Func _ExplainCheckState($iState)
	Switch $iState
		Case $BST_CHECKED
			Return "Button is checked."
		Case $BST_INDETERMINATE
			Return "Button is grayed, indicating an indeterminate state (applies only if the button has the $BS_3STATE or $BS_AUTO3STATE style)."
		Case $BST_UNCHECKED
			Return "Button is cleared"
	EndSwitch
EndFunc   ;==>_ExplainCheckState
