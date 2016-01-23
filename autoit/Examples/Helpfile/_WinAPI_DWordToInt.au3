#include <WinAPIMisc.au3>

Local $iValue = 4294967295

ConsoleWrite(_WinAPI_DWordToInt($iValue) & @CRLF)
