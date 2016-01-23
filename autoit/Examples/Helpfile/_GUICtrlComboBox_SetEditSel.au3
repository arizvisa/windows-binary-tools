#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>

Global $g_idMemo

Example()

Func Example()
	Local $aSel, $idCombo

	; Create GUI
	GUICreate("ComboBox Set Edit Sel", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Select Item
	_GUICtrlComboBox_SetCurSel($idCombo, 2)

	; Set Edit Sel
	_GUICtrlComboBox_SetEditSel($idCombo, 0, 4)

	; Get Edit Sel
	$aSel = _GUICtrlComboBox_GetEditSel($idCombo)
	MemoWrite(StringFormat("Edit Sel: %d - %d", $aSel[0], $aSel[1]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
