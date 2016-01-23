#include <WinAPIShPath.au3>

Local $aPath[7] = ['c:\path\file', 'c:\path', 'c:\path\', 'c:\', 'c:', 'path', StringFormat('Long String %270s', '1')]

For $i = 0 To UBound($aPath) - 2
	ConsoleWrite($aPath[$i] & ' => ' & _WinAPI_PathFindFileName($aPath[$i]) & @CRLF)
Next

Local $iRet = _WinAPI_PathFindFileName($aPath[UBound($aPath) - 1])
ConsoleWrite('@error = ' & @error & ' => "' & $iRet & '"' & @CRLF)
