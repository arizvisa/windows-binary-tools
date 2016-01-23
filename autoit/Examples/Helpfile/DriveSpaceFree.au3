#include <MsgBoxConstants.au3>

Local $iFreeSpace = DriveSpaceFree(@HomeDrive & "\") ; Find the free disk space of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "Free Space: " & $iFreeSpace & " MB")
