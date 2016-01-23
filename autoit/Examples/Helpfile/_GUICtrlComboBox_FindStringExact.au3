#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Find String Exact", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBox_AddString($idCombo, "This is a test")
	_GUICtrlComboBox_AddDir($idCombo, "", $DDL_DRIVES)
	_GUICtrlComboBox_AddString($idCombo, "This is eXact")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Find string
	MsgBox($MB_SYSTEMMODAL, "Information", "Find String: " & _GUICtrlComboBox_FindStringExact($idCombo, "This is eXact"))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
