#include <Array.au3>
#include <WinAPIFiles.au3>

Local $aData = _WinAPI_EnumFiles(@SystemDir, 1, '*.ax;*.cpl;*.dll;*.drv;*.exe;*.ocx;*.scr')

_ArrayDisplay($aData, '_WinAPI_EnumFiles')
