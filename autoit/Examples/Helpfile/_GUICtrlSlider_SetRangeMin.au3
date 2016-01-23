#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Set Range Min", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Range Min
	MsgBox($MB_SYSTEMMODAL, "Information", "Range Min: " & _GUICtrlSlider_GetRangeMin($idSlider))

	; Set Range Min
	_GUICtrlSlider_SetRangeMin($idSlider, 20)

	; Get Range Min
	MsgBox($MB_SYSTEMMODAL, "Information", "Range Min: " & _GUICtrlSlider_GetRangeMin($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
