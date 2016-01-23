#include <APISysConstants.au3>
#include <Array.au3>
#include <WinAPISys.au3>

Local $tText, $aData = _WinAPI_EnumRawInputDevices()

If IsArray($aData) Then
	ReDim $aData[$aData[0][0] + 1][3]
	$tText = DllStructCreate('wchar[256]')
	For $i = 1 To $aData[0][0]
		If _WinAPI_GetRawInputDeviceInfo($aData[$i][0], $tText, 256, $RIDI_DEVICENAME) Then
			$aData[$i][2] = DllStructGetData($tText, 1)
		Else
			$aData[$i][2] = ''
		EndIf
	Next

EndIf

_ArrayDisplay($aData, '_WinAPI_EnumRawInputDevices')
