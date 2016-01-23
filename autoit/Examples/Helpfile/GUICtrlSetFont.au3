#include <GUIConstantsEx.au3>
#include <FontConstants.au3>

Example()

Func Example()
	; Font type to be used for setting the font of the controls.
	Local Const $sFont = "Comic Sans Ms"

	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 300, 200)

	; Create label controls.
	GUICtrlCreateLabel("A string of text underlined", 10, 10, 185, 17)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, $GUI_FONTUNDER, $sFont) ; Set the font of the previous control.

	Local $idLabel2 = GUICtrlCreateLabel("A string of italic text", 10, 30, 185, 17)
	GUICtrlSetFont($idLabel2, 9, $FW_NORMAL,  $GUI_FONTITALIC, $sFont) ; Set the font of the controlID stored in $iLabel2.

	Local $idLabel3 = GUICtrlCreateLabel("A string of text with a strike through", 10, 50, 290, 17)
	GUICtrlSetFont($idLabel3, 9, $FW_NORMAL, $GUI_FONTSTRIKE, $sFont) ; Set the font of the controlID stored in $iLabel3.

	Local $idClose = GUICtrlCreateButton("Close", 210, 170, 85, 25)

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idClose
				ExitLoop

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>Example
