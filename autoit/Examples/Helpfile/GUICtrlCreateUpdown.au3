#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	GUICreate("My GUI UpDown", -1, -1, -1, -1, $WS_SIZEBOX)

	Local $idInput = GUICtrlCreateInput("2", 10, 10, 50, 20)
	GUICtrlCreateUpdown($idInput)

	; Attempt to resize input control
	GUICtrlSetPos($idInput, 10, 10, 100, 40)

	GUISetState(@SW_SHOW)

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()

		Switch $idMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	MsgBox($MB_SYSTEMMODAL, "Updown", GUICtrlRead($idInput))
EndFunc   ;==>Example
