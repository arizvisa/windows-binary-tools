#include <WinAPIFiles.au3>

Local $sText, $iType, $aDrive = DriveGetDrive('CDROM')
If IsArray($aDrive) Then
	For $i = 1 To $aDrive[0]
		$sText = 'Unknown'
		$iType = _WinAPI_GetCDType($aDrive[$i])
		If Not @error Then
			Switch $iType
				Case 0x0000
					$sText = 'No media'
				Case 0x0008
					$sText = 'CD-ROM'
				Case 0x0009
					$sText = 'CD-R'
				Case 0x000A
					$sText = 'CD-RW'
				Case 0x0010
					$sText = 'DVD-ROM'
				Case 0x0011
					$sText = 'DVD-R SR'
				Case 0x0012
					$sText = 'DVD-RAM'
				Case 0x0013
					$sText = 'DVD-RW RO'
				Case 0x0014
					$sText = 'DVD-RW SR'
				Case 0x0015
					$sText = 'DVD-R DL'
				Case 0x0016
					$sText = 'DVD-R DL JR'
				Case 0x0017
					$sText = 'DVD-RW DL'
				Case 0x0018
					$sText = 'DVD-DDR'
				Case 0x001A
					$sText = 'DVD+RW'
				Case 0x001B
					$sText = 'DVD+R'
				Case 0x0040
					$sText = 'BD-ROM'
				Case 0x0041
					$sText = 'BD-R SRM'
				Case 0x0042
					$sText = 'BD-R RRM'
				Case 0x0043
					$sText = 'BD-RE'
				Case 0x0050
					$sText = 'HD DVD-ROM'
				Case 0x0051
					$sText = 'HD DVD-R'
				Case 0x0052
					$sText = 'HD DVD-RAM'
				Case 0x0053
					$sText = 'HD DVD-RW'
				Case 0x0058
					$sText = 'HD DVD-R DL'
				Case 0x005A
					$sText = 'HD DVD-RW DL'
			EndSwitch
		EndIf
		ConsoleWrite(StringUpper($aDrive[$i]) & ' => ' & $sText & @CRLF)
	Next
EndIf
