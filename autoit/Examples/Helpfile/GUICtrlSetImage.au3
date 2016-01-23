#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI") ; will create a dialog box that when displayed is centered

	GUICtrlCreateButton("my picture button", 10, 20, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 22)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
