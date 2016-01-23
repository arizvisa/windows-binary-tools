#include <Timers.au3>

Global $g_iMsecs = 0, $g_sResult = '', $g_sCDdrv

_Example_TimeOut()

Func _Example_TimeOut()
	$g_sCDdrv = DriveGetDrive("CDROM")
	$g_sCDdrv = $g_sCDdrv[1]

	Local $hGUI = GUICreate("", 140, 64, -1, -1, 0)
	GUICtrlCreateLabel("Insert a CD into the tray", 8, 8, 115, 17)
	GUISetState(@SW_SHOW)

	Local $iIDtimer = _Timer_SetTimer($hGUI, 1000, "Check_mounted") ; create timer
	While $g_sResult = ''
		Sleep(200)
	WEnd

	_Timer_KillTimer($hGUI, $iIDtimer)
	MsgBox(0, '', $g_sResult, 5)

	ConsoleWrite("Killed All Timers? " & _Timer_KillAllTimers($hGUI) & @CRLF) ; must be False as all timer have already been killed
	GUIDelete($hGUI)
EndFunc   ;==>_Example_TimeOut

Func Check_mounted($hWnd, $iMsg, $iIDtimer, $iTime)
	#forceref $hWnd, $iMsg, $iIDTimer,$iTime
	$g_sResult = ''
	If FileExists($g_sCDdrv & '\') Then
		$g_sResult = DriveGetLabel($g_sCDdrv) & ' inserted' & @CRLF
		$g_sResult &= 'on drive ' & $g_sCDdrv
	Else
		$g_iMsecs += 1000
		If $g_iMsecs = 10000 Then
			$g_sResult = 'timed out'
		EndIf
	EndIf
EndFunc   ;==>Check_mounted
