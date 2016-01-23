#include <MsgBoxConstants.au3>

Local $sLabel = DriveGetLabel(@HomeDrive & "\") ; Find the volume label of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "Volume Label: " & $sLabel)
