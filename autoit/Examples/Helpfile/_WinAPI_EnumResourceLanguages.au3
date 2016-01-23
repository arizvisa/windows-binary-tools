#include <APIResConstants.au3>
#include <Array.au3>
#include <WinAPIRes.au3>

Local $aData = _WinAPI_EnumResourceLanguages(@SystemDir & '\shell32.dll', $RT_DIALOG, 1003)

_ArrayDisplay($aData, '_WinAPI_EnumResourceLanguages')
