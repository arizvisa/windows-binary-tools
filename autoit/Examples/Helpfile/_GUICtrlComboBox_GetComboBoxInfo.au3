#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $tInfo, $idCombo

	; Create GUI
	GUICreate("ComboBox Get ComboBox Info", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	If _GUICtrlComboBox_GetComboBoxInfo($idCombo, $tInfo) Then
		MemoWrite("Handle to the ComboBox .....: " & DllStructGetData($tInfo, "hCombo"))
		MemoWrite("Handle to the Edit Box .....: " & DllStructGetData($tInfo, "hEdit"))
		MemoWrite("Handle to the drop-down list: " & DllStructGetData($tInfo, "hList"))
	EndIf

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
