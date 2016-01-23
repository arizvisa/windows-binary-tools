#include <File.au3>

; List all the files in the current script directory.
Local $aScriptDir = _FileListToArray(@ScriptDir)

; Create a file in the users %TEMP% directory.
Local $sFilePath = @TempDir & "\Examples.txt"

; Write array to a file by passing the file name.
_FileWriteFromArray($sFilePath, $aScriptDir, 1)

; Display the file.
ShellExecute($sFilePath)
