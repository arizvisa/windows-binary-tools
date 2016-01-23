#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("put cursor over label", 300, 100)
	GUICtrlCreateLabel("label", 125, 40)
	GUICtrlSetCursor(-1, 4)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
