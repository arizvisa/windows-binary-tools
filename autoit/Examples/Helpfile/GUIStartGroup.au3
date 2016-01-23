#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Opt("GUICoordMode", 1)

	GUICreate("Radio Box Grouping Demo", 400, 280)

	; Create the controls
	Local $idButton_1 = GUICtrlCreateButton("B&utton 1", 30, 20, 120, 40)
	GUICtrlCreateGroup("Group 1", 30, 90, 165, 160)
	GUIStartGroup()
	Local $idRadio_1 = GUICtrlCreateRadio("Radio &0", 50, 120, 70, 20)
	Local $idRadio_2 = GUICtrlCreateRadio("Radio &1", 50, 150, 60, 20)
	Local $idRadio_3 = GUICtrlCreateRadio("Radio &2", 50, 180, 60, 20)
	GUIStartGroup()
	Local $idRadio_4 = GUICtrlCreateRadio("Radio &A", 120, 120, 70, 20)
	Local $idRadio_5 = GUICtrlCreateRadio("Radio &B", 120, 150, 60, 20)
	Local $idRadio_6 = GUICtrlCreateRadio("Radio &C", 120, 180, 60, 20)
	GUIStartGroup()
	Local $idInput_1 = GUICtrlCreateInput("Input 1", 200, 20, 160, 30)
	Local $idInput_2 = GUICtrlCreateInput("Input 2", 200, 70, 160, 30)

	; Set the defaults (radio buttons clicked, default button, etc)
	GUICtrlSetState($idRadio_1, $GUI_CHECKED)
	GUICtrlSetState($idRadio_6, $GUI_CHECKED)
	GUICtrlSetState($idButton_1, $GUI_FOCUS + $GUI_DEFBUTTON)

	; Init our vars that we will use to keep track of radio events
	Local $iRadioVal1 = 0 ; We will assume 0 = first radio button selected, 2 = last button
	Local $iRadioVal2 = 2

	GUISetState(@SW_SHOW)

	Local $idMsg
	; In this message loop we use variables to keep track of changes to the radios, another
	; way would be to use GUICtrlRead() at the end to read in the state of each control.  Both
	; methods are equally valid
	While 1
		$idMsg = GUIGetMsg()
		Select
			Case $idMsg = $GUI_EVENT_CLOSE
				ExitLoop

			Case $idMsg = $idButton_1
				MsgBox($MB_SYSTEMMODAL, "", "Radio " & $iRadioVal1 & @CRLF & "Radio " & Chr($iRadioVal2 + Asc("A")) & @CRLF & GUICtrlRead($idInput_1) & @CRLF & GUICtrlRead($idInput_2))

			Case $idMsg = $idRadio_1 Or $idMsg = $idRadio_2 Or $idMsg = $idRadio_3
				$iRadioVal1 = $idMsg - $idRadio_1

			Case $idMsg = $idRadio_4 Or $idMsg = $idRadio_5 Or $idMsg = $idRadio_6
				$iRadioVal2 = $idMsg - $idRadio_4

		EndSelect
	WEnd

	GUIDelete()
EndFunc   ;==>Example
