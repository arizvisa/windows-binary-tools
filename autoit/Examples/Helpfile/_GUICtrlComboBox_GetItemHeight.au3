#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Get Item Height", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Get Item Height (selection field)
	MemoWrite("Item Height (selection field): " & _GUICtrlComboBox_GetItemHeight($idCombo))

	; Get Item Height (list items)
	MemoWrite("Item Height (list items): " & _GUICtrlComboBox_GetItemHeight($idCombo, 0))

	; Set Item Height (selection field)
	_GUICtrlComboBox_SetItemHeight($idCombo, 18)

	; Set Item Height (selection field)
	_GUICtrlComboBox_SetItemHeight($idCombo, 20, 0)

	; Get Item Height (selection field)
	MemoWrite("Item Height (selection field): " & _GUICtrlComboBox_GetItemHeight($idCombo))

	; Get Item Height (list items)
	MemoWrite("Item Height (list items): " & _GUICtrlComboBox_GetItemHeight($idCombo, 0))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
