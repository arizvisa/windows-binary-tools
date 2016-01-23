#include <Array.au3>
#include <WinAPISys.au3>

Local $aInfo[25][2] = _
		[['Power button', 0], _
		['Sleep button', 0], _
		['Lid switch', 0], _
		['S1', 0], _
		['S2', 0], _
		['S3', 0], _
		['S4', 0], _
		['S5', 0], _
		['HIBERFIL.SYS', 0], _
		['Wake', 0], _
		['Video display dimming', 0], _
		['APM BIOS', 0], _
		['UPS', 0], _
		['Thermal zones', 0], _
		['Throttling', 0], _
		['Throttling min level', 0], _
		['Throttling max level', 0], _
		['Hibernation', 0], _
		['HDD power down', 0], _
		['Batteries', 0], _
		['Batteries short-term', 0], _
		['AC lowest wake state', 0], _
		['Lid lowest wake state', 0], _
		['RTC lowest wake state', 0], _
		['Minimum device wake state', 0]]
Local $aData = _WinAPI_GetPwrCapabilities()

If @error Then
	For $i = 0 To UBound($aInfo) - 1
		$aInfo[$i][1] = $aData[$i]
	Next
Else
	Exit
EndIf

_ArrayDisplay($aInfo, '_WinAPI_GetPwrCapabilities')
