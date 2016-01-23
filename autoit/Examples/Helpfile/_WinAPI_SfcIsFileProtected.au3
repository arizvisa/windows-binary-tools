#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

MsgBox($MB_SYSTEMMODAL, "Title", 'File Protection Status = ' & _WinAPI_SfcIsFileProtected(@WindowsDir & "\explorer.exe"))
