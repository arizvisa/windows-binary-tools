#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI control tip") ; will create a dialog box that when displayed is centered

	GUICtrlCreateLabel("my label", 10, 20)
	GUICtrlSetTip(-1, "tip of my label")

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
