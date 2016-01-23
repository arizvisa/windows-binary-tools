#include <APIShPathConstants.au3>
#include <WinAPIShPath.au3>

Local $sUrl = 'http://social.msdn.microsoft.com/search/en-us?query=UrlGetPart'

ConsoleWrite('Scheme: ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_SCHEME) & @CRLF)
ConsoleWrite('Host:   ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_HOSTNAME) & @CRLF)
ConsoleWrite('Query:  ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_QUERY) & @CRLF & @CRLF)

$sUrl = 'http://social.msdn.microsoft.com/search/en-ust'

ConsoleWrite('Scheme: ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_SCHEME) & @CRLF)
ConsoleWrite('Host:   ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_HOSTNAME) & @CRLF)
ConsoleWrite('Query:  ' & _WinAPI_UrlGetPart($sUrl, $URL_PART_QUERY) & ' @error = ' & @error & ' @extended = 0x' & Hex(@extended) & @CRLF)
