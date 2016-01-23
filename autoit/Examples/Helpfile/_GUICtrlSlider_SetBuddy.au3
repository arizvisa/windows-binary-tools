#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idInput, $idInput2, $idSlider

	; Create GUI
	GUICreate("Slider Set Buddy", 400, 296)
	$idSlider = GUICtrlCreateSlider(95, 2, 205, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	$idInput = GUICtrlCreateInput("0", 2, 25, 90, 20)
	$idInput2 = GUICtrlCreateInput("0", 2, 25, 90, 20)
	GUISetState(@SW_SHOW)

	; Set buddy to left
	_GUICtrlSlider_SetBuddy($idSlider, True, $idInput)
	; Set buddy to right
	_GUICtrlSlider_SetBuddy($idSlider, False, $idInput2)

	; Get Buddy from the left
	MsgBox($MB_SYSTEMMODAL, "Information", "Buddy Handle: " & _GUICtrlSlider_GetBuddy($idSlider, True))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
