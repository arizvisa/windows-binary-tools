#include <WinAPIMisc.au3>

Local $iValue = Int('0x1111111122222222')

ConsoleWrite('0x' & Hex(_WinAPI_HiDWord($iValue)) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_LoDWord($iValue)) & @CRLF)
