#include <APIRegConstants.au3>
#include <WinAPIReg.au3>
#include <WinAPIShPath.au3>

Local $sPath = _WinAPI_AssocQueryString('.txt', $ASSOCSTR_COMMAND)
ConsoleWrite('Command: ' & $sPath & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($sPath) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($sPath) & @CRLF & @CRLF)

$sPath = '1 2 3'
ConsoleWrite('Command: ' & $sPath & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($sPath) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($sPath) & @CRLF & @CRLF)

$sPath = StringFormat('very long string %260s', "1")
ConsoleWrite('Command: ' & $sPath & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($sPath) & @CRLF)
ConsoleWrite('Arguments: "' & _WinAPI_PathGetArgs($sPath) & '"' & @CRLF & @CRLF)
