#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $aState[2] = ['Disabled', 'Enabled']

ConsoleWrite('Aero is: ' & $aState[_WinAPI_DwmIsCompositionEnabled()] & @CRLF)
