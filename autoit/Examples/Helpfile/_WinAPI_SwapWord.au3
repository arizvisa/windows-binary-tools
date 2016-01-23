#include <WinAPIMisc.au3>

Local $iValue = 0x1122

ConsoleWrite('0x' & Hex($iValue, 4) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapWord($iValue), 4) & @CRLF)
