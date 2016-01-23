#include <WinAPIShPath.au3>

Local $asUrl[3] = ['http://www.microsoft.com', 'htps:\\www.microsoft.com', 'http:www.microsoft.com']

For $i = 0 To 2
	ConsoleWrite(StringFormat('%-27s' & _WinAPI_UrlFixup($asUrl[$i]), $asUrl[$i]) & @CRLF)
Next
