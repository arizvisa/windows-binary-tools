#include <APILocaleConstants.au3>
#include <WinAPILocale.au3>

ConsoleWrite(_WinAPI_GetTimeFormat() & @CRLF)
ConsoleWrite(_WinAPI_GetTimeFormat(0, 0, BitOR($TIME_FORCE24HOURFORMAT, $TIME_NOSECONDS)) & @CRLF)
