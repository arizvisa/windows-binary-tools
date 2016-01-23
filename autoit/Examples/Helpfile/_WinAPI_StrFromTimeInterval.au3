#include <WinAPIMisc.au3>
#include <WinAPISys.au3>

ConsoleWrite(_WinAPI_StrFromTimeInterval(_WinAPI_GetTickCount()) & @CRLF)

ConsoleWrite('"' & _WinAPI_StrFromTimeInterval(-1, 0) & '" @error = ' & @error & ' @extended = 0x' & Hex(@extended) & @CRLF)
