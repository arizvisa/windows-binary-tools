#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local Const $sPath = @TempDir & '\Mount\'

Local $sGUID = _WinAPI_GetVolumeNameForVolumeMountPoint(@HomeDrive & '\')

DirCreate($sPath)
_WinAPI_SetVolumeMountPoint($sPath, $sGUID)
MsgBox($MB_SYSTEMMODAL, '', 'The drive (' & StringUpper(@HomeDrive) & ') has been associated with "' & $sPath & '".')
_WinAPI_DeleteVolumeMountPoint($sPath)
DirRemove($sPath)
