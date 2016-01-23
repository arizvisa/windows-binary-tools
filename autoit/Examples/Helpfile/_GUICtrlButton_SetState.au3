#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idRdo, $idRdo2, $idChk, $idChk2, $idChk3, $idBtn, $idBtn2

	GUICreate("Buttons", 400, 400)
	$g_idMemo = GUICtrlCreateEdit("", 119, 10, 276, 374, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")

	$idBtn = GUICtrlCreateButton("Button1", 10, 10, 90, 25)
	_GUICtrlButton_SetState($idBtn)

	$idBtn2 = GUICtrlCreateButton("Button2", 10, 60, 90, 25)

	$idRdo = GUICtrlCreateRadio("Radio1", 10, 110, 90, 25)
	_GUICtrlButton_SetFocus($idRdo)

	$idRdo2 = GUICtrlCreateRadio("Radio2", 10, 170, 90, 25)
	_GUICtrlButton_SetCheck($idRdo2)

	$idChk = GUICtrlCreateCheckbox("Check1", 10, 230, 90, 25, BitOR($BS_AUTO3STATE, $BS_NOTIFY))
	_GUICtrlButton_SetCheck($idChk, $BST_INDETERMINATE)

	$idChk2 = GUICtrlCreateCheckbox("Check2", 10, 290, 90, 25, BitOR($BS_AUTO3STATE, $BS_NOTIFY))

	$idChk3 = GUICtrlCreateCheckbox("Check3", 10, 350, 90, 25, BitOR($BS_AUTO3STATE, $BS_NOTIFY))
	_GUICtrlButton_SetCheck($idChk3, $BST_CHECKED)

	GUISetState(@SW_SHOW)

	MemoWrite("Button1 status:" & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idBtn), True))
	MemoWrite("Button2 status:" & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idBtn2), True))
	MemoWrite("Radio1 status: " & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idRdo)))
	MemoWrite("Radio2 status: " & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idRdo2)))
	MemoWrite("Check1 status: " & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idChk)))
	MemoWrite("Check2 status: " & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idChk2)))
	MemoWrite("Check3 status: " & @CRLF & "--------------------------------" & _
			_ExplainState(_GUICtrlButton_GetState($idChk3)))

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

Func _ExplainState($iState, $bPushButton = False)
	Local $sText = ""
	If Not $bPushButton And Not $iState Then Return _
			@CRLF & "Indicates the button is cleared. Same as a return value of zero." & @CRLF
	If BitAND($iState, $BST_CHECKED) = $BST_CHECKED Then _
			$sText &= @CRLF & "Indicates the button is checked." & @CRLF
	If BitAND($iState, $BST_FOCUS) = $BST_FOCUS Then _
			$sText &= @CRLF & "Specifies the focus state. A nonzero value indicates that the button has the keyboard focus." & @CRLF
	If BitAND($iState, $BST_INDETERMINATE) = $BST_INDETERMINATE Then _
			$sText &= @CRLF & "Indicates the button is grayed because the state of the button is indeterminate." & @CRLF
	If $bPushButton Then
		If BitAND($iState, $BST_PUSHED) = $BST_PUSHED Then
			$sText &= @CRLF & "Specifies the highlight state." & @CRLF
		Else
			$sText &= @CRLF & "Specifies not highlighted state." & @CRLF
		EndIf
	EndIf
	Return $sText
EndFunc   ;==>_ExplainState
