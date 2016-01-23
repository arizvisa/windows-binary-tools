#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

; Check the drive type for C:\
Local $sInfo = DriveGetType("C:\")
MsgBox($MB_SYSTEMMODAL, "", "Drive Type: " & $sInfo)

; Check the SSD status for C:\
$sInfo = DriveGetType("C:\", $DT_SSDSTATUS)
MsgBox($MB_SYSTEMMODAL, "", "Drive SSD: " & $sInfo)

; Check the SSD status for disk 0
$sInfo = DriveGetType(0, $DT_SSDSTATUS)
MsgBox($MB_SYSTEMMODAL, "", "Drive SSD: " & $sInfo)

; Check the bus type status for disk 0
$sInfo = DriveGetType(0, $DT_BUSTYPE)
MsgBox($MB_SYSTEMMODAL, "", "Drive Bus: " & $sInfo)
