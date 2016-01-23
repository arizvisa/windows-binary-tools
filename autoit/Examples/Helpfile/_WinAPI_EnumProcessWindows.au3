#include <Array.au3>
#include <WinAPIProc.au3>

Local $aData = _WinAPI_EnumProcessWindows(0, 0)

_ArrayDisplay($aData, '_WinAPI_EnumProcessWindows')
