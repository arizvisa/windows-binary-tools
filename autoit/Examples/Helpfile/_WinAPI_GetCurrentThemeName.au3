#include <APIThemeConstants.au3>
#include <WinAPITheme.au3>

Local $aData = _WinAPI_GetCurrentThemeName()
If IsArray($aData) Then
	ConsoleWrite('File:    ' & $aData[0] & @CRLF)
	ConsoleWrite('Color:   ' & $aData[1] & @CRLF)
	ConsoleWrite('Size:    ' & $aData[2] & @CRLF)
	ConsoleWrite('Name:    ' & _WinAPI_GetThemeDocumentationProperty($aData[0], $SZ_THDOCPROP_CANONICALNAME) & @CRLF)
	ConsoleWrite('Display: ' & _WinAPI_GetThemeDocumentationProperty($aData[0], $SZ_THDOCPROP_DISPLAYNAME) & @CRLF)
	ConsoleWrite('Tooltip: ' & _WinAPI_GetThemeDocumentationProperty($aData[0], $SZ_THDOCPROP_TOOLTIP) & @CRLF)
	ConsoleWrite('Author:  ' & _WinAPI_GetThemeDocumentationProperty($aData[0], $SZ_THDOCPROP_AUTHOR) & @CRLF)
EndIf
