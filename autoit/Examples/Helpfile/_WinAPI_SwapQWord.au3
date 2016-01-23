#include <WinAPI.au3>
#include <WinAPIMisc.au3>

Local $iValue = _WinAPI_MakeQWord(0x55667788, 0x11223344)

ConsoleWrite('0x' & Hex($iValue) & @CRLF)
ConsoleWrite('0x' & Hex(_WinAPI_SwapQWord($iValue)) & @CRLF)
