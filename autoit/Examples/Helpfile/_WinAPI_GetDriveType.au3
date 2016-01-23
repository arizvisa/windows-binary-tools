#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Find the drive type of the home drive, generally this is the C:\ drive.
	Local $iTypeOfDrive = _WinAPI_GetDriveType(@HomeDrive) ; For example C:

	; Create a variable to hold the display message.
	Local $sMessage = ""
	Switch $iTypeOfDrive
		Case $DRIVE_UNKNOWN
			$sMessage = "The drive type cannot be determined."
		Case $DRIVE_NO_ROOT_DIR
			$sMessage = "The root path is invalid."
		Case $DRIVE_REMOVABLE
			$sMessage = "The drive is removable media."
		Case $DRIVE_FIXED
			$sMessage = "The drive is a fixed drive."
		Case $DRIVE_REMOTE
			$sMessage = "The drive is a remote (network) drive."
		Case $DRIVE_CDROM
			$sMessage = "The drive is a CD-ROM drive."
		Case $DRIVE_RAMDISK
			$sMessage = "The drive is a RAM disk."
	EndSwitch

	; Display the message about the drive type.
	MsgBox($MB_SYSTEMMODAL, "", $sMessage)
EndFunc   ;==>Example
