#include <Array.au3>
#include <WinAPILocale.au3>

Local $aData = _WinAPI_EnumUILanguages()

_ArrayDisplay($aData, '_WinAPI_EnumUILanguages')
