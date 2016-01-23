#include <MsgBoxConstants.au3>

Local $sStatus = DriveStatus(@HomeDrive & "\") ; Find the status of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "Status: " & $sStatus)
