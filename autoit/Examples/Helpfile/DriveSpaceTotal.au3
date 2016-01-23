#include <MsgBoxConstants.au3>

Local $iTotalSpace = DriveSpaceTotal(@HomeDrive & "\") ; Find the total disk space of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "Total Space: " & $iTotalSpace & " MB")
