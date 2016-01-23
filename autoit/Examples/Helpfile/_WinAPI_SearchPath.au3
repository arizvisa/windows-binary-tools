#include <WinAPIFiles.au3>

Local $sFile = 'Notepad.exe'

ConsoleWrite(_WinAPI_SearchPath($sFile) & @CRLF)
ConsoleWrite(_WinAPI_SearchPath($sFile, @SystemDir) & @CRLF)
