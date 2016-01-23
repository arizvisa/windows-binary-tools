#include <WinAPIGdi.au3>
#include <WinAPISys.au3>

Local $tPos = _WinAPI_GetMousePos()
Local $hMonitor = _WinAPI_MonitorFromPoint($tPos)

Local $aData = _WinAPI_GetMonitorInfo($hMonitor)
If IsArray($aData) Then
	ConsoleWrite('Handle:      ' & $hMonitor & @CRLF)
	ConsoleWrite('Rectangle:   ' & DllStructGetData($aData[0], 1) & ', ' & DllStructGetData($aData[0], 2) & ', ' & DllStructGetData($aData[0], 3) & ', ' & DllStructGetData($aData[0], 4) & @CRLF)
	ConsoleWrite('Work area:   ' & DllStructGetData($aData[1], 1) & ', ' & DllStructGetData($aData[1], 2) & ', ' & DllStructGetData($aData[1], 3) & ', ' & DllStructGetData($aData[1], 4) & @CRLF)
	ConsoleWrite('Primary:     ' & $aData[2] & @CRLF)
	ConsoleWrite('Device name: ' & $aData[3] & @CRLF)
EndIf
