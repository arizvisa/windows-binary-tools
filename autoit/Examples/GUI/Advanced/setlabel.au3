; AutoIt Version 3.0.103
; Language:       English
; Author:         Larry Bailey
; Email:          psichosis@tvn.net
; Date: January 11, 2005
;
; Script Function
; Creates a simple GUI showing the use of
; a label, a combobox and a button
; Selecting an item from the combobox
; and clicking the button updates the label text

#include <GuiConstantsEx.au3>

_Main()

Func _Main()
	Local $idLabel_1, $idCombo_2, $idButton1, $iMsg, $sData

	; Create the GUI window and controls
	GUICreate("MyGUI", 191, 157, (@DesktopWidth - 191) / 2, (@DesktopHeight - 157) / 2)
	$idLabel_1 = GUICtrlCreateLabel("Label1", 30, 40, 131, 21, 0x1000)
	$idCombo_2 = GUICtrlCreateCombo("", 30, 60, 130, 21)
	GUICtrlSetData($idCombo_2, "Item1|Item2|Item3|Item4|Item5")
	$idButton1 = GUICtrlCreateButton("Set Label", 30, 90, 130, 20)

	; Run the GUI until it is closed
	GUISetState()
	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				ExitLoop
				;When button is pressed, label text is changed
				;to combobox value
			Case $iMsg = $idButton1
				$sData = GUICtrlRead($idCombo_2)
				GUICtrlSetData($idLabel_1, $sData)
		EndSelect
	WEnd
	Exit
EndFunc   ;==>_Main
