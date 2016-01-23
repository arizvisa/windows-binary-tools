#include <Array.au3>
#include <WinAPIGdi.au3>

Local $aPos, $aData = _WinAPI_EnumDisplayMonitors()

If IsArray($aData) Then
	ReDim $aData[$aData[0][0] + 1][5]
	For $i = 1 To $aData[0][0]
		$aPos = _WinAPI_GetPosFromRect($aData[$i][1])
		For $j = 0 To 3
			$aData[$i][$j + 1] = $aPos[$j]
		Next
	Next
EndIf

_ArrayDisplay($aData, '_WinAPI_EnumDisplayMonitors')
