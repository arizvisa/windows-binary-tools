#include <APIFilesConstants.au3>
#include <WinAPIFiles.au3>

Local $iBus, $sText, $aDrive = DriveGetDrive('ALL')
For $i = 1 To $aDrive[0]
	$iBus = _WinAPI_GetDriveBusType($aDrive[$i])
	Switch $iBus
		Case $DRIVE_BUS_TYPE_UNKNOWN
			$sText = 'UNKNOWN'
		Case $DRIVE_BUS_TYPE_SCSI
			$sText = 'SCSI'
		Case $DRIVE_BUS_TYPE_ATAPI
			$sText = 'ATAPI'
		Case $DRIVE_BUS_TYPE_ATA
			$sText = 'ATA'
		Case $DRIVE_BUS_TYPE_1394
			$sText = '1394'
		Case $DRIVE_BUS_TYPE_SSA
			$sText = 'SSA'
		Case $DRIVE_BUS_TYPE_FIBRE
			$sText = 'FIBRE'
		Case $DRIVE_BUS_TYPE_USB
			$sText = 'USB'
		Case $DRIVE_BUS_TYPE_RAID
			$sText = 'RAID'
		Case $DRIVE_BUS_TYPE_ISCSI
			$sText = 'ISCSI'
		Case $DRIVE_BUS_TYPE_SAS
			$sText = 'SAS'
		Case $DRIVE_BUS_TYPE_SATA
			$sText = 'SATA'
		Case $DRIVE_BUS_TYPE_SD
			$sText = 'SD'
		Case $DRIVE_BUS_TYPE_MMC
			$sText = 'MMC'
	EndSwitch
	ConsoleWrite(StringUpper($aDrive[$i]) & ' => ' & $sText & @CRLF)
Next
