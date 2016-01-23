#include <Array.au3>
#include <WinAPISys.au3>

Local $aData = _WinAPI_EnumDesktops(_WinAPI_GetProcessWindowStation())

_ArrayDisplay($aData, '_WinAPI_EnumDesktops')
