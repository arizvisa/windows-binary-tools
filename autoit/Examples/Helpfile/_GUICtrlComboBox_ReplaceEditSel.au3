#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Replace Edit Sel", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Set Edit Text
	_GUICtrlComboBox_SetEditText($idCombo, "Old Edit Text")

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	Sleep(500)

	; Set selected text in edit box
	_GUICtrlComboBox_SetEditSel($idCombo, 0, -1)

	Sleep(500)

	; Replace the text in the edit box
	_GUICtrlComboBox_ReplaceEditSel($idCombo, "New Edit Text")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
