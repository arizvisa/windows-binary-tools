#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()

	GUICreate("slider", 220, 100, 100, 200)
	GUISetBkColor(0x00E0FFFF) ; will change background color

	Local $idSlider1 = GUICtrlCreateSlider(10, 10, 200, 20)
	GUICtrlSetLimit(-1, 200, 0) ; change min/max value
	Local $idButton = GUICtrlCreateButton("Value?", 75, 70, 70, 20)
	GUISetState(@SW_SHOW)
	GUICtrlSetData($idSlider1, 45) ; set cursor

	Local $idMsg
	; Loop until the user exits.
	Do
		$idMsg = GUIGetMsg()

		If $idMsg = $idButton Then
			MsgBox($MB_SYSTEMMODAL, "slider1", GUICtrlRead($idSlider1), 2)
		EndIf
	Until $idMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
