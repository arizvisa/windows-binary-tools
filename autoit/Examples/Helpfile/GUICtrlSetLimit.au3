#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI limit input 3 chars") ; will create a dialog box that when displayed is centered

	GUICtrlCreateInput("", 10, 20)
	GUICtrlSetLimit(-1, 3) ; to limit the entry to 3 chars

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
