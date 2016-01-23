#include <WinAPIShPath.au3>

Local $sPath = @ScriptFullPath

ConsoleWrite('Before: ' & $sPath & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathCompactPathEx($sPath, 40) & @CRLF)
