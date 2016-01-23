#include <APIShPathConstants.au3>
#include <WinAPIShPath.au3>

Local $sUrl = 'http://msdn.microsoft.com/en-us/library/ee663300%28VS.85%29.aspx'

ConsoleWrite(_WinAPI_UrlCanonicalize($sUrl, $URL_UNESCAPE) & @CRLF)
