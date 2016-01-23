#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 180, 135, -1, -1, -1, $WS_EX_TOPMOST)
Local $idButton = GUICtrlCreateButton('OK', 55, 101, 70, 23)
GUICtrlCreateLabel('AC power:', 10, 14, 90, 14)
GUICtrlCreateLabel('Status:', 10, 34, 70, 14)
GUICtrlCreateLabel('Charge:', 10, 54, 90, 14)
GUICtrlCreateLabel('Time remaining:', 10, 74, 90, 14)
Global $g_aidLabel[4]
For $i = 0 To 3
	$g_aidLabel[$i] = GUICtrlCreateLabel('Unknown', 110, 14 + 20 * $i, 60, 14)
Next
GUISetState(@SW_SHOW)

AdlibRegister('_BatteryStatus', 1000)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $idButton
			ExitLoop
	EndSwitch
WEnd

Func _BatteryStatus()
	Local $aData = _WinAPI_GetSystemPowerStatus()
	If @error Then Return

	If BitAND($aData[1], 128) Then
		$aData[0] = 'Not present'
		For $i = 1 To 3
			$aData[$i] = 'Unknown'
		Next
	Else
		Switch $aData[0]
			Case 0
				$aData[0] = 'Offline'
			Case 1
				$aData[0] = 'Online'
			Case Else
				$aData[0] = 'Unknown'
		EndSwitch
		Switch $aData[2]
			Case 0 To 100
				$aData[2] &= '%'
			Case Else
				$aData[2] = 'Unknown'
		EndSwitch
		Switch $aData[3]
			Case -1
				$aData[3] = 'Unknown'
			Case Else
				Local $H, $M
				$H = ($aData[3] - Mod($aData[3], 3600)) / 3600
				$M = ($aData[3] - Mod($aData[3], 60)) / 60 - $H * 60
				$aData[3] = StringFormat($H & ':%02d', $M)
		EndSwitch
		If BitAND($aData[1], 8) Then
			$aData[1] = 'Charging'
		Else
			Switch BitAND($aData[1], 0xF)
				Case 1
					$aData[1] = 'High'
				Case 2
					$aData[1] = 'Low'
				Case 4
					$aData[1] = 'Critical'
				Case Else
					$aData[1] = 'Unknown'
			EndSwitch
		EndIf
	EndIf
	For $i = 0 To 3
		GUICtrlSetData($g_aidLabel[$i], $aData[$i])
	Next
EndFunc   ;==>_BatteryStatus
