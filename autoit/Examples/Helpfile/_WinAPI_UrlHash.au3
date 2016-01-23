#include <WinAPIShPath.au3>

Local $sUrl = 'http://www.microsoft.com'

ConsoleWrite(_WinAPI_UrlHash($sUrl) & @CRLF)
