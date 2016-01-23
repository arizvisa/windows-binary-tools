#include <WinAPILocale.au3>

Local $sNumber = '123456789'

ConsoleWrite(_WinAPI_GetNumberFormat(0, $sNumber) & @CRLF)
ConsoleWrite(_WinAPI_GetNumberFormat(0, $sNumber, _WinAPI_CreateNumberFormatInfo(0, 1, 3, '', ',', 1)) & @CRLF)
