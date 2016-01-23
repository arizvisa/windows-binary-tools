#include <GUIConstantsEx.au3>

Example()

Func Example()
	Opt("GUICoordMode", 2) ; relative to cell mode

	GUICreate("My GUI Set Coord", 200, 100)
	GUICtrlCreateCheckbox("Check #1", 20, 10, 75)
	GUICtrlCreateCheckbox("Notify #2", 10, -1) ; next cell in the line

	GUISetCoord(20, 60)

	GUICtrlCreateButton("OK #3", -1, -1)
	GUICtrlCreateButton("Cancel #4", 10, -1)
	GUICtrlSetState(-1, $GUI_FOCUS)

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example
