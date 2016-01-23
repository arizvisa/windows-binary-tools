#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ProgressConstants.au3>
#include <Timers.au3>
#include <WindowsConstants.au3>

Global $g_idMemo, $g_hStatus, $g_idProgress, $g_iPercent = 0, $g_iDirection = 1
Global $g_iTimer1, $g_iTimer2

_Example_Events()

Func _Example_Events()
	Local $hGUI, $idChange, $iWait = 10, $idState
	Local $aParts[3] = [75, 330, -1]

	$hGUI = GUICreate("Timers Using WM_TIMER Events", 400, 320)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 226, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	$idState = GUICtrlCreateButton("Start Progress Bar", 70, 270, 100, 25)
	$idChange = GUICtrlCreateButton("Change", 215, 270, 90, 25)
	GUICtrlSetState($idChange, $GUI_DISABLE)
	$g_hStatus = _GUICtrlStatusBar_Create($hGUI, $aParts)
	_GUICtrlStatusBar_SetText($g_hStatus, "Timers")
	_GUICtrlStatusBar_SetText($g_hStatus, @TAB & @TAB & StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC), 2)
	$g_idProgress = GUICtrlCreateProgress(0, 0, -1, -1, $PBS_SMOOTH)
	GUICtrlSetColor($g_idProgress, 0xff0000)
	_GUICtrlStatusBar_EmbedControl($g_hStatus, 1, GUICtrlGetHandle($g_idProgress))
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_TIMER, "WM_TIMER")

	$g_iTimer1 = _Timer_SetTimer($hGUI, 1000)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idState
				If GUICtrlRead($idState) = "Start Progress Bar" Then
					$g_iTimer2 = _Timer_SetTimer($hGUI, $iWait) ; create timer
					If @error Or $g_iTimer2 = 0 Then ContinueLoop
					GUICtrlSetData($idState, "Stop Progress Bar")
					GUICtrlSetState($idChange, $GUI_ENABLE)
				Else
					GUICtrlSetState($idChange, $GUI_DISABLE)
					_Timer_KillTimer($hGUI, $g_iTimer2)
					GUICtrlSetData($idState, "Start Progress Bar")
				EndIf

			Case $idChange
				If $iWait = 10 Then
					$iWait = 250
				Else
					$iWait = 10
				EndIf
				MemoWrite("Timer for _UpdateProgressBar set at: " & $iWait & " milliseconds")
				$g_iTimer2 = _Timer_SetTimer($hGUI, $iWait, "", $g_iTimer2) ; reuse timer with different interval
		EndSwitch
	WEnd

	ConsoleWrite("Killed All Timers? " & _Timer_KillAllTimers($hGUI) & @CRLF)
	GUIDelete()
EndFunc   ;==>_Example_Events

; Timer Events
Func WM_TIMER($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	Switch _Timer_GetTimerID($wParam)
		Case $g_iTimer1
			_UpdateStatusBarClock()
		Case $g_iTimer2
			_UpdateProgressBar()
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_TIMER

Func _UpdateStatusBarClock()
	_GUICtrlStatusBar_SetText($g_hStatus, @TAB & @TAB & StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC), 2)
EndFunc   ;==>_UpdateStatusBarClock

Func _UpdateProgressBar()
	$g_iPercent += 5 * $g_iDirection
	GUICtrlSetData($g_idProgress, $g_iPercent)
	If $g_iPercent = 100 Or $g_iPercent = 0 Then $g_iDirection *= -1
	If $g_iPercent = 100 Then
		GUICtrlSetColor($g_idProgress, 0xff0000)
	ElseIf $g_iPercent = 0 Then
		GUICtrlSetColor($g_idProgress, 0x0000ff)
	EndIf
EndFunc   ;==>_UpdateProgressBar

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
