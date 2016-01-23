#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("test GUISetTextColor", 100, 100) ; will create a dialog box that when displayed is centered

	GUICtrlSetDefBkColor(0xFF0000) ; will change text color for all defined controls

	GUICtrlCreateLabel("label", 10, 5)

	GUICtrlCreateRadio("radio", 10, 25, 50)
	GUICtrlSetBkColor(-1, 0x0000FF) ; will change text color for specified control

	GUICtrlCreateButton("button", 10, 55)

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
