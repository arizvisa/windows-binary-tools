#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Set Thumb Length", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_FIXEDLENGTH))
	GUISetState(@SW_SHOW)

	; Get Thumb Length
	MsgBox($MB_SYSTEMMODAL, "Information", "Thumb Length: " & _GUICtrlSlider_GetThumbLength($idSlider))

	; Set Thumb Length
	_GUICtrlSlider_SetThumbLength($idSlider, 10)

	; Get Thumb Length
	MsgBox($MB_SYSTEMMODAL, "Information", "Thumb Length: " & _GUICtrlSlider_GetThumbLength($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
