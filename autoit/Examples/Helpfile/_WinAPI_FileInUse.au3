#include <WinAPIFiles.au3>

Local $hFile = FileOpen(@ScriptFullPath)

ConsoleWrite(@ScriptName & ' in use: ' & _WinAPI_FileInUse(@ScriptFullPath) & @CRLF)
FileClose($hFile)
ConsoleWrite(@ScriptName & ' in use: ' & _WinAPI_FileInUse(@ScriptFullPath) & @CRLF)
