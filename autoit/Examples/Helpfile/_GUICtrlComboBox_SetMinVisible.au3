#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Set Min Visible", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Get Min Visible
	MsgBox($MB_SYSTEMMODAL, "Information", "Min Visible:" & @TAB & _GUICtrlComboBox_GetMinVisible($idCombo), 3)

	; show drop down
	_GUICtrlComboBox_ShowDropDown($idCombo, True)

	Sleep(500)

	; Set Min Visible
	_GUICtrlComboBox_SetMinVisible($idCombo, 50)

	; show drop down
	_GUICtrlComboBox_ShowDropDown($idCombo)

	Sleep(500)

	_GUICtrlComboBox_ShowDropDown($idCombo, True)

	Sleep(500)

	; Get Min Visible
	MsgBox($MB_SYSTEMMODAL, "Information", "Min Visible:" & @TAB & _GUICtrlComboBox_GetMinVisible($idCombo), 3)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
