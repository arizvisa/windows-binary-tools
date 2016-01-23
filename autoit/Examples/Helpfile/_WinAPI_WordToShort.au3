#include <WinAPIMisc.au3>

Local $iValue = 65535

ConsoleWrite(_WinAPI_WordToShort($iValue) & @CRLF)
