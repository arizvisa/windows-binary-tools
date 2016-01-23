#include <WinAPIShPath.au3>

Local $aPath[5] = ['c:\path\file', 'c:\', 'c:', 'nodrive', StringFormat('d: %270s', '2')]

For $i = 0 To UBound($aPath) - 2
	ConsoleWrite($aPath[$i] & ' => ' & _WinAPI_PathGetDriveNumber($aPath[$i]) & @CRLF)
Next

Local $iRet = _WinAPI_PathGetDriveNumber($aPath[UBound($aPath) - 1])
ConsoleWrite('TOO LONG STRING : @error = ' & @error & ' => "' & $iRet & '"' & @CRLF)
