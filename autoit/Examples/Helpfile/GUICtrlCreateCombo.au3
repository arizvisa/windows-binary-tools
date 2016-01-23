#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 300, 200)

	; Create a combobox control.
	Local $idComboBox = GUICtrlCreateCombo("Item 1", 10, 10, 185, 20)
	Local $idClose = GUICtrlCreateButton("Close", 210, 170, 85, 25)

	; Add additional items to the combobox.
	GUICtrlSetData($idComboBox, "Item 2|Item 3", "Item 2")

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	Local $sComboRead = ""

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idClose
				ExitLoop

			Case $idComboBox
				$sComboRead = GUICtrlRead($idComboBox)
				MsgBox($MB_SYSTEMMODAL, "", "The combobox is currently displaying: " & $sComboRead, 0, $hGUI)

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>Example
