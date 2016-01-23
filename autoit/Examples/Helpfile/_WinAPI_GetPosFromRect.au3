#include <WinAPIGdi.au3>

Local $aPos = _WinAPI_GetPosFromRect(_WinAPI_CreateRectEx(10, 10, 100, 100))

ConsoleWrite('Left:   ' & $aPos[0] & @CRLF)
ConsoleWrite('Top:    ' & $aPos[1] & @CRLF)
ConsoleWrite('Width:  ' & $aPos[2] & @CRLF)
ConsoleWrite('Height: ' & $aPos[3] & @CRLF)
