#include <WinAPIShPath.au3>

Local $aPath[2] = ['C:\Documents\Test.txt', 'C:\Documents\Test']

For $i = 0 To 1
	ConsoleWrite($aPath[$i] & ' => ' & _WinAPI_PathAddExtension($aPath[$i], '.doc') & @CRLF)
Next
