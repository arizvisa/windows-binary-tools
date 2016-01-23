#include <APIResConstants.au3>
#include <Array.au3>
#include <WinAPIRes.au3>

Local $aData = _WinAPI_EnumResourceNames(@SystemDir & '\shell32.dll', $RT_DIALOG)

_ArrayDisplay($aData, '_WinAPI_EnumResourceNames')
