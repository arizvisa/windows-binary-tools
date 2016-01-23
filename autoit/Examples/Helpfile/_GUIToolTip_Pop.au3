#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton(" Button ", 30, 32, 130, 28)
	; Local $hButton = GUICtrlGetHandle($idButton)

	Local $hToolTip = _GUIToolTip_Create($hGUI, $TTS_BALLOON)
	Local $aPos = MouseGetPos()

	_GUIToolTip_AddTool($hToolTip, 0, " ", 0, 0, 0, 0, 0, 0)

	_GUIToolTip_SetTitle($hToolTip, 'Mouse Coordinates', $TTI_INFO)
	GUISetState(@SW_SHOW)
	; Find the mouse's position to use as the starting point for tracking
	_GUIToolTip_TrackPosition($hToolTip, $aPos[0], $aPos[1])
	_GUIToolTip_TrackActivate($hToolTip, True, 0, 0)
	Local $hTimer = TimerInit()
	While 1
		; Read the mouse position
		$aPos = MouseGetPos()
		; Use the position of the mouse to set the location of the tooltip
		_GUIToolTip_TrackPosition($hToolTip, $aPos[0], $aPos[1])
		_GUIToolTip_UpdateTipText($hToolTip, 0, 0, "X: " & $aPos[0] & " Y: " & $aPos[1])

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				; ...
		EndSwitch
		; 3 seconds after starting, this will remove the tool from displaying
		If TimerDiff($hTimer) >= 3000 Then
			_GUIToolTip_Pop($hToolTip)
		EndIf
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
