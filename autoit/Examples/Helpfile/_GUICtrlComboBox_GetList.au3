#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $aList, $idCombo
	Opt("GUIDataSeparatorChar", ",") ; set seperator char to char we want to use

	; Create GUI
	GUICreate("ComboBox Get List", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_AddDir($idCombo, "", $DDL_DRIVES, False)

	; Get List
	$aList = StringSplit(_GUICtrlComboBox_GetList($idCombo), ",")
	For $x = 1 To $aList[0]
		MemoWrite($aList[$x])
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
