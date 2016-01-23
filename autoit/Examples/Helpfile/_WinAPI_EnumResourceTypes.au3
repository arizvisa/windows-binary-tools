#include <Array.au3>
#include <WinAPIRes.au3>

Local $aData = _WinAPI_EnumResourceTypes(@SystemDir & '\shell32.dll')

_ArrayDisplay($aData, '_WinAPI_EnumResourceTypes')
