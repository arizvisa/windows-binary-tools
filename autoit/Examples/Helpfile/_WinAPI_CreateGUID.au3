#include <WinAPICom.au3>

For $i = 1 To 3
	ConsoleWrite(_WinAPI_CreateGUID() & @CRLF)
Next
