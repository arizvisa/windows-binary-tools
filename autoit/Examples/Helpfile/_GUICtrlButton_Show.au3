#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $y = 70, $a_idBtn[6], $a_idRdo[6], $a_idChk[6]

	GUICreate("Buttons", 510, 400)
	GUISetState(@SW_SHOW)

	$a_idBtn[0] = GUICtrlCreateButton("Button1", 10, 10, 90, 50)

	$a_idRdo[0] = GUICtrlCreateRadio("Radio Button1", 120, 10, 120, 25)

	$a_idChk[0] = GUICtrlCreateCheckbox("Check Button1", 260, 10, 120, 25)

	For $x = 1 To 5
		$a_idBtn[$x] = GUICtrlCreateButton("Button" & $x + 1, 10, $y, 90, 50)
		$a_idRdo[$x] = GUICtrlCreateRadio("Radio Button" & $x + 1, 120, $y, 120, 25)
		$a_idChk[$x] = GUICtrlCreateCheckbox("Check Button" & $x + 1, 260, $y, 120, 25)
		$y += 60
	Next

	; Hide the buttons
	For $x = 0 To 5
		_GUICtrlButton_Show($a_idBtn[$x], False)
		_GUICtrlButton_Show($a_idRdo[$x], False)
		_GUICtrlButton_Show($a_idChk[$x], False)
		Sleep(500)
	Next

	; Show the buttons
	For $x = 5 To 0 Step -1
		_GUICtrlButton_Show($a_idChk[$x])
		_GUICtrlButton_Show($a_idRdo[$x])
		_GUICtrlButton_Show($a_idBtn[$x])
		Sleep(500)
	Next

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example
