#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate('Example', 300, 150)
	GUISetFont(9, 400, 0, 'Segoe UI')

	Local $idUsername = GUICtrlCreateInput('', 10, 10, 125, 25)
	_GUICtrlEdit_SetCueBanner($idUsername, "Search folder")

	Local $idPassword = GUICtrlCreateInput('', 10, 40, 125, 25)
	_GUICtrlEdit_SetCueBanner($idPassword, "Search...")

	Local $idClose = GUICtrlCreateButton("Close", 210, 120, 85, 25)
	ControlFocus($hGUI, "", $idClose)

	GUISetState(@SW_SHOW, $hGUI)

	MsgBox($MB_SYSTEMMODAL, "", _GUICtrlEdit_GetCueBanner($idPassword))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idClose
				ExitLoop

		EndSwitch
	WEnd

	GUIDelete($hGUI)
EndFunc   ;==>Example
