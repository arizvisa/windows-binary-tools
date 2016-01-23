#include <APIThemeConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>
#include <WinAPITheme.au3>

Global Const $BP_PUSHBUTTON = 1
Global Const $PBS_NORMAL = 1
Global Const $PBS_HOT = 2

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hTheme = _WinAPI_OpenThemeData(0, 'Button')
Local $iVal = _WinAPI_GetThemeTransitionDuration($hTheme, $BP_PUSHBUTTON, $PBS_NORMAL, $PBS_HOT, $TMT_TRANSITIONDURATIONS)
_WinAPI_CloseThemeData($hTheme)

ConsoleWrite('Transition from "Hot" to "Normal" state: ' & $iVal & ' ms' & @CRLF)
