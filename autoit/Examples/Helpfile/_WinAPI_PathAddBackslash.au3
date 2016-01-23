#include <WinAPIShPath.au3>

Local $aPath[2] = ['C:\Documents\', 'C:\Documents']

For $i = 0 To 1
	ConsoleWrite($aPath[$i] & ' => ' & _WinAPI_PathAddBackslash($aPath[$i]) & @CRLF)
Next
