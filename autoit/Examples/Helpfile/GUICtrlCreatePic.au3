#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	GUICreate("My GUI picture", 350, 300, -1, -1, $WS_SIZEBOX + $WS_SYSMENU) ; will create a dialog box that when displayed is centered

	GUISetBkColor(0xE0FFFF)
	Local $idPic = GUICtrlCreatePic("..\GUI\mslogo.jpg", 50, 50, 200, 50)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	; resize the control
	GUICtrlSetPos($idPic, 50, 50, 200, 100)

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()

		If $idMsg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	GUIDelete()
EndFunc   ;==>Example
