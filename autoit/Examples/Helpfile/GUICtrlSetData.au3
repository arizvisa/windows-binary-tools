#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI") ; will create a dialog box that when displayed is centered

	GUICtrlCreateCombo("", 10, 10)

	GUICtrlSetData(-1, "item1|item2|item3", "item3")

	GUISetState(@SW_SHOW) ; will display an empty dialog box with a combo control with focus on

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
