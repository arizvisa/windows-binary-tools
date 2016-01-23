#include <WinAPILocale.au3>

Local $iDuration = (90 * 60 + 14) * 1000 * 1000 * 10

ConsoleWrite(_WinAPI_GetDurationFormat(0, $iDuration, 'hh:mm:ss') & @CRLF)
ConsoleWrite(_WinAPI_GetDurationFormat(0, $iDuration, 'mm:ss') & @CRLF)
ConsoleWrite(_WinAPI_GetDurationFormat(0, $iDuration, 'ss') & @CRLF)
