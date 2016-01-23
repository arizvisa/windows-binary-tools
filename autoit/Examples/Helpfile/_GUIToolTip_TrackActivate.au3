#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $hToolTip = _GUIToolTip_Create(0, $TTS_BALLOON)
	; Add tool to the ToolTip control, not using a control or the GUI to link it to
	_GUIToolTip_AddTool($hToolTip, 0, " ", 0, 0, 0, 0, 0, $TTF_SUBCLASS)

	_GUIToolTip_SetTitle($hToolTip, 'Mouse position', $TTI_INFO)
	GUISetState(@SW_SHOW)

	_GUIToolTip_TrackActivate($hToolTip, True, 0, 0)
	Local $aPos, $iOldaPos0, $iOldaPos1
	While 1
		Sleep(10)
		$aPos = MouseGetPos()
		If $aPos[0] <> $iOldaPos0 Or $aPos[1] <> $iOldaPos1 Then
			_GUIToolTip_TrackPosition($hToolTip, $aPos[0] + 10, $aPos[1] + 20)
			_GUIToolTip_UpdateTipText($hToolTip, 0, 0, "X: " & $aPos[0] & " Y: " & $aPos[1])
			$iOldaPos0 = $aPos[0]
			$iOldaPos1 = $aPos[1]
		EndIf
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
