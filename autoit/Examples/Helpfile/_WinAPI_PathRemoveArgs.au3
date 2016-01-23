#include <APIRegConstants.au3>
#include <WinAPIReg.au3>
#include <WinAPIShPath.au3>

Local $sPath = _WinAPI_AssocQueryString('.txt', $ASSOCSTR_COMMAND)

ConsoleWrite('Command: ' & $sPath & @CRLF)
ConsoleWrite('Path: ' & _WinAPI_PathRemoveArgs($sPath) & @CRLF)
ConsoleWrite('Arguments: ' & _WinAPI_PathGetArgs($sPath) & @CRLF)
