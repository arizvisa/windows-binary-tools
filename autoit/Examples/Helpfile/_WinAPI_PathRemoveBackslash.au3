#include <WinAPIShPath.au3>

Local $sPath = 'C:\Documents\'

ConsoleWrite('Before: ' & $sPath & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathRemoveBackslash($sPath) & @CRLF)
