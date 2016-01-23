#include <WinAPISys.au3>

Local $sFile = @ScriptFullPath
Local $hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)

ConsoleWrite('File:   ' & $sFile & @CRLF)
ConsoleWrite('Handle: ' & $hFile & @CRLF)
ConsoleWrite('Type:   ' & _WinAPI_GetObjectNameByHandle($hFile) & @CRLF)

_WinAPI_CloseHandle($hFile)
