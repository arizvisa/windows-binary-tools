#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aSel, $idSlider

	; Create GUI
	GUICreate("Slider Set Sel", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Set Sel
	_GUICtrlSlider_SetSel($idSlider, 10, 50)

	; Get Sel
	$aSel = _GUICtrlSlider_GetSel($idSlider)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Sel: %d - %d", $aSel[0], $aSel[1]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
