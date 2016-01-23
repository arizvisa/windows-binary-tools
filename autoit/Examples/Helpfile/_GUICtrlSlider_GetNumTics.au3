#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Get Num Tics", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Num Tics
	MsgBox($MB_SYSTEMMODAL, "Information", "Num Tics: " & _GUICtrlSlider_GetNumTics($idSlider))

	; Set Tic Freq
	_GUICtrlSlider_SetTicFreq($idSlider, 1)

	; Get Num Tics
	MsgBox($MB_SYSTEMMODAL, "Information", "Num Tics: " & _GUICtrlSlider_GetNumTics($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
