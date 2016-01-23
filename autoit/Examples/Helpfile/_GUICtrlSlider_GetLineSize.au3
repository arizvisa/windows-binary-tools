#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Get Line Size", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Line Size
	MsgBox($MB_SYSTEMMODAL, "Information", "Line Size: " & _GUICtrlSlider_GetLineSize($idSlider))

	; Set Line Size
	_GUICtrlSlider_SetLineSize($idSlider, 4)

	; Get Line Size
	MsgBox($MB_SYSTEMMODAL, "Information", "Line Size: " & _GUICtrlSlider_GetLineSize($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
