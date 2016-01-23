#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idSlider

	; Create GUI
	GUICreate("Slider Set Page Size", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Page Size
	MsgBox($MB_SYSTEMMODAL, "Information", "Page Size: " & _GUICtrlSlider_GetPageSize($idSlider))

	; Set Page Size
	_GUICtrlSlider_SetPageSize($idSlider, 4)

	; Get Page Size
	MsgBox($MB_SYSTEMMODAL, "Information", "Page Size: " & _GUICtrlSlider_GetPageSize($idSlider))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
