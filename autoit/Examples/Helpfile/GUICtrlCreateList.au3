#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sMESSAGE = "The following buttons have been clicked"

	GUICreate("My GUI list") ; will create a dialog box that when displayed is centered

	Local $idAdd = GUICtrlCreateButton("Add", 64, 32, 75, 25)
	Local $idClear = GUICtrlCreateButton("Clear", 64, 72, 75, 25)
	Local $idMylist = GUICtrlCreateList("buttons that have been clicked", 176, 32, 121, 97)
	GUICtrlSetLimit(-1, 200) ; to limit horizontal scrolling
	GUICtrlSetData(-1, $sMESSAGE)
	Local $idClose = GUICtrlCreateButton("my closing button", 64, 160, 175, 25)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idAdd
				GUICtrlSetData($idMylist, "You clicked button No1|")
			Case $idClear
				GUICtrlSetData($idMylist, "")
			Case $idClose
				MsgBox($MB_SYSTEMMODAL, "", "the closing button has been clicked", 2)
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>Example
