#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Set Range Max", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Range Max
	MsgBox($MB_SYSTEMMODAL, "Information", "Range Max: " & _GUICtrlSlider_GetRangeMax($idSlider))

	; Set Range Max
	_GUICtrlSlider_SetRangeMax($idSlider, 50)

	; Get Range Max
	MsgBox($MB_SYSTEMMODAL, "Information", "Range Max: " & _GUICtrlSlider_GetRangeMax($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
