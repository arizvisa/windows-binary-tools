#include <WinAPIMisc.au3>

Local $iValue = 0x00FA0000

ConsoleWrite('0x' & Hex(_WinAPI_LongMid($iValue, 16, 4)) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_LongMid($iValue, 20, 4)) & @CRLF)
