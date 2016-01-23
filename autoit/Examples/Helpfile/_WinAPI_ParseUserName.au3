#include <WinAPIShPath.au3>

Local $aData = _WinAPI_ParseUserName('ALX\Alexander')

ConsoleWrite('Domain: ' & $aData[0] & @CRLF)
ConsoleWrite('User:   ' & $aData[1] & @CRLF)
