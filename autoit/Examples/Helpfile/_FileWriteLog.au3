; Open the logfile in write mode.

#include <File.au3>

Local $hFile = FileOpen(@ScriptDir & "\Example.log", 1)

_FileWriteLog($hFile, "Text 1") ; Write to the logfile passing the filehandle returned by FileOpen.
FileClose($hFile) ; Close the filehandle to release the file.
