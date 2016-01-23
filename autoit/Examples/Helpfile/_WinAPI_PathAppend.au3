#include <WinAPIShPath.au3>

Local $sPath1 = 'C:\Documents\Text'
Local $sPath2 = '..\Test.txt'

ConsoleWrite('Path1 : ' & $sPath1 & @CRLF)
ConsoleWrite('Path2 : ' & $sPath2 & @CRLF)
ConsoleWrite('Result: ' & _WinAPI_PathAppend($sPath1, $sPath2) & @CRLF)
