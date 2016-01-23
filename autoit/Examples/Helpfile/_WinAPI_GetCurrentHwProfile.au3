#include <WinAPISys.au3>

Local $aData = _WinAPI_GetCurrentHwProfile()
If IsArray($aData) Then
	ConsoleWrite('State: ' & $aData[0] & @CRLF)
	ConsoleWrite('GUID:  ' & $aData[1] & @CRLF)
	ConsoleWrite('Name:  ' & $aData[2] & @CRLF)
EndIf
