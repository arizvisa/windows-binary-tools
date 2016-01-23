#include <WinAPIShPath.au3>

Local $sPath = 'C:\Documents\Test.txt'

ConsoleWrite('Before: ' & $sPath & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathRemoveExtension($sPath) & @CRLF)
