#include <WinAPIShPath.au3>

Local $sUrl1 = 'http://xyz/abc/'
Local $sUrl2 = 'http://xyz/abc'

ConsoleWrite(_WinAPI_UrlCombine($sUrl1, 'bar') & @CRLF)
ConsoleWrite(_WinAPI_UrlCombine($sUrl2, 'bar') & @CRLF)
