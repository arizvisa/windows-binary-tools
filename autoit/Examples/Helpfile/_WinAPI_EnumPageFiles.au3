#include <Array.au3>
#include <WinAPISys.au3>

Local $aData = _WinAPI_EnumPageFiles()

_ArrayDisplay($aData, '_WinAPI_EnumPageFiles')
