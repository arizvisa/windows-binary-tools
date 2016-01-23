#include <WinAPIDiag.au3>

Local $iError = _WinAPI_NtStatusToDosError(0xC0000023) ; STATUS_BUFFER_TOO_SMALL

ConsoleWrite($iError & ' - ' & _WinAPI_GetErrorMessage($iError) & @CRLF)
