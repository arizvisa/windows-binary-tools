#include <WinAPIMisc.au3>

Local $iValue = 0x11223344

ConsoleWrite('0x' & Hex($iValue) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapDWord($iValue)) & @CRLF)
