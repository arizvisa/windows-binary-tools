#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 420, 200, -1, -1, -1, $WS_EX_ACCEPTFILES)

	; Create a label and set the state as drop accepted.
	Local $idLabel = GUICtrlCreateLabel("Drop a file on this label.", 10, 10, 400, 40, $WS_BORDER)
	GUICtrlSetState($idLabel, $GUI_DROPACCEPTED)

	; Create an input and set the state as drop accepted.
	Local $idInput = GUICtrlCreateInput("", 10, 60, 400, 22)
	GUICtrlSetState($idInput, $GUI_DROPACCEPTED)

	Local $idOK = GUICtrlCreateButton("OK", 310, 170, 85, 25)

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idOK
				ExitLoop

			Case $GUI_EVENT_DROPPED
				; If the value of @GUI_DropId is $idLabel, then set the label of the dragged file.
				If @GUI_DropId = $idLabel Then GUICtrlSetData($idLabel, @GUI_DragFile)

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>Example
