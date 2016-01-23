#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.1' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later.')
	Exit
EndIf

Local $tRECT = _WinAPI_ShellNotifyIconGetRect(WinGetHandle(AutoItWinGetTitle()), 1)

Local $aPos
If Not @error Then
	$aPos = _WinAPI_GetPosFromRect($tRECT)
	MouseMove($aPos[0] + 12, $aPos[1] + 12)
	MouseClick('left')
	While 1
		Sleep(1000)
	WEnd
EndIf
