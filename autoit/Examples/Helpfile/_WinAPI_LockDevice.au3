#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local $aDrive = DriveGetDrive('CDROM')

If IsArray($aDrive) Then
	_WinAPI_LockDevice($aDrive[1], 1)
	MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper($aDrive[1]) & ') is locked.')
	_WinAPI_LockDevice($aDrive[1], 0)
	MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper($aDrive[1]) & ') is unlocked.')
EndIf
