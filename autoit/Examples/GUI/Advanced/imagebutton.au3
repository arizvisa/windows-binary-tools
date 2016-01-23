#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	Local $idButton1, $idButton2, $idButton3, $idButton4
	Local $idButton5, $idButtonclose

	GUICreate("test", 240, 180)
	$idButton1 = GUICtrlCreateButton("1", 0, 0, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 5)
	$idButton2 = GUICtrlCreateButton("2", 40, 00, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 7)
	$idButton3 = GUICtrlCreateButton("3", 80, 00, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 22)
	$idButton4 = GUICtrlCreateButton("4", 120, 0, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 23)
	$idButton5 = GUICtrlCreateButton("5", 160, 0, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 32)
	$idButtonclose = GUICtrlCreateButton("close", 200, 0, 40, 40, $BS_ICON)
	GUICtrlSetImage(-1, "shell32.dll", 28)
	GUISetState()

	; Run the GUI until the dialog is closed
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton1
				;
			Case $idButton2
				;
			Case $idButton3
				;
			Case $idButton4
				;
			Case $idButton5
				;
			Case $idButtonclose
				ExitLoop
			Case Else
		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>_Main
