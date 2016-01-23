#include <MsgBoxConstants.au3>

Local $sFileSystem = DriveGetFileSystem(@HomeDrive & "\") ; Find the file system type of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "File System Type: " & $sFileSystem)
