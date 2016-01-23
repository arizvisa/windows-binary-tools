#include <WinAPIFiles.au3>

Local Const $sFile = @ScriptFullPath

ConsoleWrite('Localtion:    ' & $sFile & @CRLF)
ConsoleWrite('Size:         ' & FileGetSize($sFile) & @CRLF)
ConsoleWrite('Size on disk: ' & _WinAPI_GetFileSizeOnDisk($sFile) & @CRLF)
