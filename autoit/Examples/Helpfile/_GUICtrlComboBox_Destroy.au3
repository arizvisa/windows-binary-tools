#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hCombo

	; Create GUI
	$hGUI = GUICreate("(UDF Created) ComboBox Destroy", 400, 296)
	$hCombo = _GUICtrlComboBox_Create($hGUI, "", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBox_EndUpdate($hCombo)

	; Destroy ComboBox
	MsgBox($MB_SYSTEMMODAL, "Information", "Destroy ComboBox")
	MsgBox($MB_SYSTEMMODAL, "Information", "Destroyed: " & _GUICtrlComboBox_Destroy($hCombo))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
