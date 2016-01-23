#include <WinAPIGdi.au3>

ConsoleWrite('RGB: 0x' & Hex(_WinAPI_ColorHLSToRGB(20, 120, 240), 6) & @CRLF)
