#include <WinAPI.au3>
#include <WinAPIFiles.au3>

Local $hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)

ConsoleWrite('Handle: ' & $hFile & @CRLF)
ConsoleWrite('ID:     ' & _WinAPI_GetFileID($hFile) & @CRLF)

_WinAPI_CloseHandle($hFile)
