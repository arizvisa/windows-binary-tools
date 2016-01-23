#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Delete String", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add drives
	_GUICtrlComboBox_AddDir($idCombo, "", $DDL_DRIVES, False)

	;Delete string
	MsgBox($MB_SYSTEMMODAL, "Information", "Deleting string at index 1")
	_GUICtrlComboBox_DeleteString($idCombo, 1)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
