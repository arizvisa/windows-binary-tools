#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI (GetControlState)")
	Local $idCheckbox = GUICtrlCreateCheckbox("checkbox", 10, 10)
	GUICtrlSetState(-1, 1) ; checked

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	MsgBox($MB_SYSTEMMODAL, "state", StringFormat("GUICtrlRead=%d\nGUICtrlGetState=%d", GUICtrlRead($idCheckbox), GUICtrlGetState($idCheckbox)))
EndFunc   ;==>Example
