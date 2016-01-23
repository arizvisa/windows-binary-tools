#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $aRect, $idCombo

	; Create GUI
	GUICreate("ComboBox Get Dropped Control Rect", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Get Dropped Control Rect
	$aRect = _GUICtrlComboBox_GetDroppedControlRect($idCombo)

	MemoWrite("X coordinate of the upper left corner ......: " & $aRect[0])
	MemoWrite("Y coordinate of the upper left corner ......: " & $aRect[1])
	MemoWrite("X coordinate of the lower right corner .....: " & $aRect[2])
	MemoWrite("Y coordinate of the lower right corner .....: " & $aRect[3])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
