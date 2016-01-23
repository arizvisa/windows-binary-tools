#include <APILocaleConstants.au3>
#include <WinAPILocale.au3>

ConsoleWrite(_WinAPI_GetDateFormat() & @CRLF)
ConsoleWrite(_WinAPI_GetDateFormat(0, 0, $DATE_LONGDATE) & @CRLF)
ConsoleWrite(_WinAPI_GetDateFormat(0, 0, 0, 'dddd dd, yyyy') & @CRLF)
