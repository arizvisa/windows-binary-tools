#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $tRECT, $idSlider

	; Create GUI
	GUICreate("Slider Get Thumb RectEx", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState(@SW_SHOW)

	; Get Thumb Rect
	$tRECT = _GUICtrlSlider_GetThumbRectEx($idSlider)

	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("[%d][%d][%d][%d]", _
			DllStructGetData($tRECT, "Left"), DllStructGetData($tRECT, "Top"), _
			DllStructGetData($tRECT, "Right"), DllStructGetData($tRECT, "Bottom")))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
