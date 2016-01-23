#include <APIShellExConstants.au3>
#include <WinAPIShellEx.au3>

_WinAPI_ShellSetSettings($SSF_SHOWEXTENSIONS, Not _WinAPI_ShellGetSettings($SSF_SHOWEXTENSIONS))

ConsoleWrite('Hide extensions for known file types: ' & (Not _WinAPI_ShellGetSettings($SSF_SHOWEXTENSIONS)) & @CRLF)
