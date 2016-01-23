#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI get date", 200, 200, 800, 200)
	Local $idDate = GUICtrlCreateDate("1953/04/25", 10, 10, 185, 20)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	MsgBox($MB_SYSTEMMODAL, "Date", GUICtrlRead($idDate))
	GUIDelete()
EndFunc   ;==>Example
