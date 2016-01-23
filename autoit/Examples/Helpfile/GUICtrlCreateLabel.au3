#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI") ; will create a dialog box that when displayed is centered

	GUISetHelp("notepad.exe") ; will run notepad if F1 is typed
	Local $iOldOpt = Opt("GUICoordMode", 2)

	Local $iWidthCell = 70
	GUICtrlCreateLabel("Line 1 Cell 1", 10, 30, $iWidthCell) ; first cell 70 width
	GUICtrlCreateLabel("Line 2 Cell 1", -1, 0) ; next line
	GUICtrlCreateLabel("Line 3 Cell 2", 0, 0) ; next line and next cell
	GUICtrlCreateLabel("Line 3 Cell 3", 0, -1) ; next cell same line
	GUICtrlCreateLabel("Line 4 Cell 1", -3 * $iWidthCell, 0) ; next line Cell1

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	$iOldOpt = Opt("GUICoordMode", $iOldOpt)
EndFunc   ;==>Example
