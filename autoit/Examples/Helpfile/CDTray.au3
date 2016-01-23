#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

; Get List of all CDRom's
Local $aCDRom = DriveGetDrive($DT_CDROM)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "No CDRom found.")
	Exit
EndIf

; Open the CD tray of the first CDRom
CDTray($aCDRom[1], $CDTRAY_OPEN)
Sleep(2000)
CDTray($aCDRom[1], $CDTRAY_CLOSED) ; does not work on laptop-style cd trays that can only be closed manually.

