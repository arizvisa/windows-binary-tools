#include <WinAPIShPath.au3>

Local $sPath = @ScriptFullPath

$sPath = _WinAPI_UrlCreateFromPath($sPath)
ConsoleWrite($sPath & @CRLF)

$sPath = _WinAPI_PathCreateFromUrl($sPath)
ConsoleWrite($sPath & @CRLF)
