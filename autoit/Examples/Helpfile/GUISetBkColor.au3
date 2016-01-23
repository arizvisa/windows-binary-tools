#include <ColorConstantS.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI") ; will create a dialog box that when displayed is centered

	GUISetBkColor($COLOR_RED) ; will change background color

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
