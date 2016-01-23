#include <APILocaleConstants.au3>
#include <APIResConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPILocale.au3>
#include <WinAPIRes.au3>
#include <WinAPISys.au3>

Local $hInstance = _WinAPI_LoadLibraryEx(@ScriptDir & '\Extras\Resources.dll', $LOAD_LIBRARY_AS_DATAFILE)
If Not $hInstance Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', @ScriptDir & '\Extras\Resources.dll not found.')
	Exit
EndIf

; Get the language (locale) identifier for the current process
Local $iPrev
If _WinAPI_GetVersion() >= '6.0' Then
	$iPrev = _WinAPI_GetThreadUILanguage()
Else
	$iPrev = _WinAPI_GetThreadLocale()
EndIf

; Why is the resource name for the string with ID = 6000 is 376? 6000 / 16 + 1 = 376
Local $aData = _WinAPI_EnumResourceLanguages($hInstance, $RT_STRING, 376)
If Not @error Then
	For $i = 1 To $aData[0]
		If _WinAPI_GetVersion() >= '6.0' Then
			_WinAPI_SetThreadUILanguage($aData[$i])
		Else
			_WinAPI_SetThreadLocale($aData[$i])
		EndIf
		ConsoleWrite(StringFormat('%-10s - %s', _WinAPI_GetLocaleInfo($aData[$i], $LOCALE_SENGLANGUAGE), _WinAPI_LoadString($hInstance, 6000)) & @CRLF)
	Next
EndIf

; Restore the previous language for the current process
If _WinAPI_GetVersion() >= '6.0' Then
	_WinAPI_SetThreadUILanguage($iPrev)
Else
	_WinAPI_SetThreadLocale($iPrev)
EndIf
