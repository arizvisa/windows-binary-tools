#include <APIGdiConstants.au3>
#include <WinAPIGdi.au3>

Local $i = 0, $aData

While 1
	$aData = _WinAPI_EnumDisplaySettings('', $i)
	If IsArray($aData) Then
		ConsoleWrite($aData[0] & ' x ' & $aData[1] & ' x ' & $aData[2] & ' bit' & @CRLF)
	Else
		ExitLoop
	EndIf
	$i += 1
WEnd

$aData = _WinAPI_EnumDisplaySettings('', $ENUM_CURRENT_SETTINGS)
ConsoleWrite('-------------------------------' & @CRLF)
ConsoleWrite('Current settings: ' & $aData[0] & ' x ' & $aData[1] & ' x ' & $aData[2] & ' bit' & @CRLF)
