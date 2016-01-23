#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 300, 200)

	; Create an animation control.
	Local $idAnimation = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 165, 15, 0, 300)
	Local $idStart = GUICtrlCreateButton("Start", 60, 150, 85, 25)
	Local $idStop = GUICtrlCreateButton("Stop", 160, 150, 85, 25)

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idStart ; Start the animation.
				GUICtrlSetState($idAnimation, $GUI_AVISTART)

			Case $idStop ; Stop the animation.
				GUICtrlSetState($idAnimation, $GUI_AVISTOP)

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>Example
