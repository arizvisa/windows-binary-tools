#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("Get date", 210, 190)

	Local $idDate = GUICtrlCreateMonthCal("1953/03/25", 10, 10)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idDate
				MsgBox($MB_SYSTEMMODAL, "debug", "calendar clicked")

		EndSwitch
	WEnd

	MsgBox($MB_SYSTEMMODAL, "Date", GUICtrlRead($idDate), 2)
EndFunc   ;==>Example
