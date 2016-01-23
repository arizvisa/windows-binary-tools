#include <Array.au3>
#include <WinAPIProc.au3>

Local $aInfo, $aData = _WinAPI_EnumDeviceDrivers()
If IsArray($aData) Then
	Dim $aInfo[$aData[0]][3]
	For $i = 1 To $aData[0]
		$aInfo[$i - 1][0] = $aData[$i]
		$aInfo[$i - 1][1] = _WinAPI_GetDeviceDriverBaseName($aData[$i])
		$aInfo[$i - 1][2] = _WinAPI_GetDeviceDriverFileName($aData[$i])
	Next
EndIf

_ArrayDisplay($aInfo, '_WinAPI_EnumDeviceDrivers')
