#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>

Example()

Func Example()
	GUICreate("Marquee Progress Bar", 290, 90, -1, -1) ; An example of starting/stopping a scrolling marquee of a progress bar.
	Local $idProgress = GUICtrlCreateProgress(10, 10, 270, 20, $PBS_MARQUEE)
	Local $idStart = GUICtrlCreateButton("&Start", 10, 60, 70, 25)
	Local $idStop = GUICtrlCreateButton("S&top", 85, 60, 70, 25)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idStart
				GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 1, 50) ; Send the message $PBM_SETMARQUEE and wParam of 1 to start the scrolling marquee.

			Case $idStop
				GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 0, 50) ; Send the message $PBM_SETMARQUEE and wParam of 0 to stop the scrolling marquee.

		EndSwitch
	WEnd
EndFunc   ;==>Example
