#include <APISysConstants.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

Local $a_hObj[2] = [_WinAPI_GetProcessWindowStation(), _WinAPI_GetThreadDesktop(_WinAPI_GetCurrentThreadId())]

For $i = 0 To 1
	If Not $i Then
		ConsoleWrite('-------------------------------' & @CRLF)
	EndIf
	ConsoleWrite('Handle: ' & $a_hObj[$i] & @CRLF)
	ConsoleWrite('Type:   ' & _WinAPI_GetUserObjectInformation($a_hObj[$i], $UOI_TYPE) & @CRLF)
	ConsoleWrite('Name:   ' & _WinAPI_GetUserObjectInformation($a_hObj[$i], $UOI_NAME) & @CRLF)
	ConsoleWrite('-------------------------------' & @CRLF)
Next
