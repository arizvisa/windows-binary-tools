#include <Array.au3>
#include <WinAPIProc.au3>

Local $aData = _WinAPI_EnumChildProcess(_WinAPI_GetParentProcess())

_ArrayDisplay($aData, '_WinAPI_EnumChildProcess')
