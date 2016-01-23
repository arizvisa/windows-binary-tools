#include <WinAPISys.au3>

Local $tWINDOWINFO = _WinAPI_GetWindowInfo(_WinAPI_GetDesktopWindow())

ConsoleWrite('Left:   ' & DllStructGetData($tWINDOWINFO, 'rWindow', 1) & @CRLF)
ConsoleWrite('Top:    ' & DllStructGetData($tWINDOWINFO, 'rWindow', 2) & @CRLF)
ConsoleWrite('Right:  ' & DllStructGetData($tWINDOWINFO, 'rWindow', 3) & @CRLF)
ConsoleWrite('Bottom: ' & DllStructGetData($tWINDOWINFO, 'rWindow', 4) & @CRLF)
