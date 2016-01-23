#include <MsgBoxConstants.au3>

Local $sSerial = DriveGetSerial(@HomeDrive & "\") ; Find the serial number of the home drive, generally this is the C:\ drive.
MsgBox($MB_SYSTEMMODAL, "", "Serial Number: " & $sSerial)
