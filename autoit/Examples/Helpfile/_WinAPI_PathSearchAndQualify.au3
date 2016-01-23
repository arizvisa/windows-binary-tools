#include <WinAPIShPath.au3>

Local Const $sPath1 = 'C:\\Test\\'
Local Const $sPath2 = 'C:/Test/Test.txt'
Local Const $sPath3 = 'Notepad.exe'

ConsoleWrite($sPath1 & ' => ' & _WinAPI_PathSearchAndQualify($sPath1) & @CRLF)
ConsoleWrite($sPath2 & ' => ' & _WinAPI_PathSearchAndQualify($sPath2) & @CRLF)
ConsoleWrite($sPath3 & ' => ' & _WinAPI_PathSearchAndQualify($sPath3) & @CRLF)
