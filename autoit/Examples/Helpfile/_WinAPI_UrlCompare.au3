#include <WinAPIShPath.au3>

Local $sUrl1 = 'http://xyz/abc/'
Local $sUrl2 = 'http://xyz/abc'

ConsoleWrite('URLs comparison result: ' & _WinAPI_UrlCompare($sUrl1, $sUrl2) & @CRLF)
