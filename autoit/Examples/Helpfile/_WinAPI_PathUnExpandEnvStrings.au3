#include <WinAPIShPath.au3>

Local $sPath = @SystemDir

ConsoleWrite('Before: ' & $sPath & @CRLF)
ConsoleWrite('After : ' & _WinAPI_PathUnExpandEnvStrings($sPath) & @CRLF)
