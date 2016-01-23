#include <WinAPIFiles.au3>

Local Const $sPath1 = 'Test.txt'
Local Const $sPath2 = 'Test\Test.txt'
Local Const $sPath3 = 'C:\Test\Test.txt'

ConsoleWrite($sPath1 & ' => ' & _WinAPI_GetFullPathName($sPath1) & @CRLF)
ConsoleWrite($sPath2 & ' => ' & _WinAPI_GetFullPathName($sPath2) & @CRLF)
ConsoleWrite($sPath3 & ' => ' & _WinAPI_GetFullPathName($sPath3) & @CRLF)
