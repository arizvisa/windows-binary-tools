#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>

Local $hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 130, 48, 48)
Local $tSIZE = _WinAPI_GetIconDimension($hIcon)
_WinAPI_DestroyIcon($hIcon)

ConsoleWrite(DllStructGetData($tSIZE, 'X') & ' x ' & DllStructGetData($tSIZE, 'Y') & @CRLF)
