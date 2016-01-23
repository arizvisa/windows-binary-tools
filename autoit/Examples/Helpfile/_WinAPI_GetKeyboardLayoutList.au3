#include <APILocaleConstants.au3>
#include <Array.au3>
#include <WinAPILocale.au3>
#include <WinAPISys.au3>

Local $aData = _WinAPI_GetKeyboardLayoutList()
If IsArray($aData) Then
	For $i = 1 To $aData[0]
		$aData[$i] = '0x' & Hex($aData[$i]) & ' (' & _WinAPI_GetLocaleInfo(BitAND($aData[$i], 0xFFFF), $LOCALE_SENGLANGUAGE) & ')'
	Next
EndIf

_ArrayDisplay($aData, '_WinAPI_GetKeyboardLayoutList')
