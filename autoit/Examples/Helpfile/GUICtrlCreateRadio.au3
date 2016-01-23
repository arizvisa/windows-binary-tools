#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI radio") ; will create a dialog box that when displayed is centered

	Local $idRadio1 = GUICtrlCreateRadio("Radio 1", 10, 10, 120, 20)
	Local $idRadio2 = GUICtrlCreateRadio("Radio 2", 10, 40, 120, 20)
	GUICtrlSetState($idRadio2, $GUI_CHECKED)

	GUISetState(@SW_SHOW) ; will display an  dialog box with 1 checkbox

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()
		Select
			Case $idMsg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $idMsg = $idRadio1 And BitAND(GUICtrlRead($idRadio1), $GUI_CHECKED) = $GUI_CHECKED
				MsgBox($MB_SYSTEMMODAL, 'Info:', 'You clicked the Radio 1 and it is Checked.')
			Case $idMsg = $idRadio2 And BitAND(GUICtrlRead($idRadio2), $GUI_CHECKED) = $GUI_CHECKED
				MsgBox($MB_SYSTEMMODAL, 'Info:', 'You clicked on Radio 2 and it is Checked.')
		EndSelect
	WEnd
EndFunc   ;==>Example
