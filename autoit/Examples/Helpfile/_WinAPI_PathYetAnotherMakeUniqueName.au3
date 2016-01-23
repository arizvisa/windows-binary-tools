#include <WinAPIShPath.au3>

DirRemove(@TempDir & '\Temp', 1)
DirCreate(@TempDir & '\Temp')
For $i = 1 To 4
	FileClose(FileOpen(_WinAPI_PathYetAnotherMakeUniqueName(@TempDir & '\Temp\My File.txt'), 2))
Next
ShellExecute(@TempDir & '\Temp')
