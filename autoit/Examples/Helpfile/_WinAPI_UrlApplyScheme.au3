#include <WinAPIShPath.au3>

Local $sUrl = 'www.microsoft.com'

ConsoleWrite(_WinAPI_UrlApplyScheme($sUrl) & @CRLF)

ConsoleWrite(_WinAPI_UrlApplyScheme('') & @CRLF)
