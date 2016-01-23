#include <APILocaleConstants.au3>
#include <Array.au3>
#include <WinAPILocale.au3>

Local $aData = _WinAPI_EnumSystemLocales($LCID_INSTALLED)

_ArrayDisplay($aData, '_WinAPI_EnumSystemLocales')
