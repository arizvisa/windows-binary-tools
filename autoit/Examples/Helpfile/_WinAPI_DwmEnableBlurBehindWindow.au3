#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)

GUISetBkColor(0)

; Create the "sheet of glass" effect for the specified region. You must call this function whenever DWM composition is toggled.
_WinAPI_DwmGetColorizationColor()
Local $hRgn = _WinAPI_CreateEllipticRgn(_WinAPI_CreateRectEx(50, 50, 300, 300))
_WinAPI_DwmEnableBlurBehindWindow($hForm, 1, 0, $hRgn)
If $hRgn Then
	_WinAPI_DeleteObject($hRgn)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
