#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

Local $iColor = _WinAPI_DwmGetColorizationColor()
Local $iBlend = @extended

ConsoleWrite('Color for glass composition: 0x' & Hex($iColor) & @CRLF)
ConsoleWrite('Transparency: ' & (Not $iBlend) & @CRLF)
