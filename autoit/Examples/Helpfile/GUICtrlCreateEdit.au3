#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	GUICreate("My GUI edit") ; will create a dialog box that when displayed is centered

	Local $idMyedit = GUICtrlCreateEdit("First line" & @CRLF, 176, 32, 121, 97, $ES_AUTOVSCROLL + $WS_VSCROLL)

	GUISetState(@SW_SHOW)

	Send("{END}")

	; will be append dont' forget 3rd parameter
	GUICtrlSetData($idMyedit, "Second line", 1)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
	GUIDelete()
EndFunc   ;==>Example
