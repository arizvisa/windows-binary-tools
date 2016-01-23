#include <WinAPIMisc.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

ConsoleWrite(_WinAPI_StrFromTimeInterval(_WinAPI_GetTickCount()) & @CRLF)
