#include <WinAPIGdi.au3>

Local Const $RGB = 0xFF8040

Local $R = _WinAPI_GetRValue($RGB)
Local $G = _WinAPI_GetGValue($RGB)
Local $B = _WinAPI_GetBValue($RGB)

ConsoleWrite('Red:   0x' & Hex($R, 2) & @CRLF)
ConsoleWrite('Green: 0x' & Hex($G, 2) & @CRLF)
ConsoleWrite('Blue:  0x' & Hex($B, 2) & @CRLF)
ConsoleWrite('---------------' & @CRLF)
ConsoleWrite('RGB:   0x' & Hex(_WinAPI_RGB($R, $G, $B), 6) & @CRLF)
