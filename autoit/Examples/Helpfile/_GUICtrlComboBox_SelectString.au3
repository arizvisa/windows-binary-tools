#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Select String", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296, BitOR($CBS_SIMPLE, $CBS_DISABLENOSCROLL, $WS_VSCROLL))
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	; Add string
	_GUICtrlComboBox_AddString($idCombo, "This string has been added")
	; Add files
	_GUICtrlComboBox_AddDir($idCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBox_EndUpdate($idCombo)

	; select string
	_GUICtrlComboBox_SelectString($idCombo, "This")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
