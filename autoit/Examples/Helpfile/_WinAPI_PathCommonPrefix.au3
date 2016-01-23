#include <WinAPIShPath.au3>

Local $sPath1 = 'C:\Documents\Test.txt'
Local $sPath2 = 'C:\Documents\Archive\Sample.txt'

ConsoleWrite('Path1 : ' & $sPath1 & @CRLF)
ConsoleWrite('Path2 : ' & $sPath2 & @CRLF)
ConsoleWrite('Prefix: ' & _WinAPI_PathCommonPrefix($sPath1, $sPath2) & @CRLF)
