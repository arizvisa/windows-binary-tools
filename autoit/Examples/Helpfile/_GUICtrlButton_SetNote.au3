#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

; Note the controlID from these button(s) can NOT be read with GUICtrlRead

Example()

Func Example()
	Local $hGUI

	$hGUI = GUICreate("Buttons", 400, 400)
	$g_idMemo = GUICtrlCreateEdit("", 10, 65, 390, 325, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")

	Local $hBtn = _GUICtrlButton_Create($hGUI, "Button1", 10, 10, 160, 40, BitOR($BS_COMMANDLINK, $BS_DEFPUSHBUTTON, $BS_PUSHLIKE))
	_GUICtrlButton_SetNote($hBtn, "This is a test of Vista")

	GUISetState(@SW_SHOW)

	MemoWrite("Note: " & _GUICtrlButton_GetNote($hBtn))
	MemoWrite("Note Length: " & _GUICtrlButton_GetNoteLength($hBtn))
	MemoWrite("Button Text: " & _GUICtrlButton_GetText($hBtn))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
