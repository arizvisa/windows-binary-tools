#include <APILocaleConstants.au3>
#include <Array.au3>
#include <WinAPILocale.au3>

Local $aData = _WinAPI_EnumSystemGeoID()

If IsArray($aData) Then
	For $i = 1 To $aData[0]
		$aData[$i] = _WinAPI_GetGeoInfo($aData[$i], $GEO_FRIENDLYNAME)
	Next
EndIf

_ArrayDisplay($aData, '_WinAPI_EnumSystemGeoID')
