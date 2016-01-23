#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Example()

Func Example()
	GUICreate("My GUI style") ; will create a dialog box that when displayed is centered

	GUICtrlCreateLabel("my label which will split on several lines", 10, 20, 100, 100)
	GUICtrlSetStyle(-1, $SS_RIGHT)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
