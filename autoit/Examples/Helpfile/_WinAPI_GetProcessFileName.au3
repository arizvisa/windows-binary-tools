#include <WinAPIProc.au3>

Local $iID = ProcessExists('SciTE.exe')

If $iID Then
	ConsoleWrite(_WinAPI_GetProcessFileName($iID) & @CRLF)
EndIf
