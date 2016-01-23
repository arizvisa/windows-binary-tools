#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aRange, $idSlider

	; Create GUI
	GUICreate("Slider Set Range", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Range
	$aRange = _GUICtrlSlider_GetRange($idSlider)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Range: %d - %d", $aRange[0], $aRange[1]))

	; Set Range
	_GUICtrlSlider_SetRange($idSlider, 20, 50)

	; Get Range
	$aRange = _GUICtrlSlider_GetRange($idSlider)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Range: %d - %d", $aRange[0], $aRange[1]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
