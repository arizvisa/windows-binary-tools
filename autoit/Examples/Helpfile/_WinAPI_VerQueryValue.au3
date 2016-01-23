#include <Array.au3>
#include <WinAPIRes.au3>
#include <WinAPISys.au3>

Local $pData = 0
If Not _WinAPI_GetFileVersionInfo(@SystemDir & '\shell32.dll', $pData) Then
	Exit
EndIf

Local $aData = _WinAPI_VerQueryValue($pData)

_ArrayDisplay($aData, '_WinAPI_VerQueryValue')

_WinAPI_FreeMemory($pData)
