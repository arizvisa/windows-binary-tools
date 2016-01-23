#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIFiles.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

Local Const $sFile = @ScriptFullPath

; Enable "SeBackupPrivilege" and "SeRestorePrivilege" privileges to perform backup and restore operation
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
Local $aAdjust, $aPrivileges[2] = [$SE_BACKUP_NAME, $SE_RESTORE_NAME]
_WinAPI_AdjustTokenPrivileges($hToken, $aPrivileges, $SE_PRIVILEGE_ENABLED, $aAdjust)
If @error Or @extended Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'You do not have the required privileges.')
	Exit
EndIf

; Create a memory buffer where to store the backup data
Local $iBytes = 4096 + FileGetSize($sFile)
Local $pBuffer = _WinAPI_CreateBuffer($iBytes)

; Back up a file, including the security information
Local $pContext = 0
Local $hFile = _WinAPI_CreateFileEx($sFile, $OPEN_EXISTING, $GENERIC_READ)
If Not _WinAPI_BackupRead($hFile, $pBuffer, $iBytes, $iBytes, $pContext, 1) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to back up a file.')
	Exit
EndIf
_WinAPI_BackupReadAbort($pContext)
_WinAPI_CloseHandle($hFile)

; Restore a file (.bak) and the ACL data
$pContext = 0
$hFile = _WinAPI_CreateFileEx(_WinAPI_PathRenameExtension($sFile, '.bak'), $CREATE_ALWAYS, BitOR($GENERIC_WRITE, $WRITE_DAC, $WRITE_OWNER))
If Not _WinAPI_BackupWrite($hFile, $pBuffer, $iBytes, $iBytes, $pContext, 1) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to restore a file.')
	Exit
EndIf
_WinAPI_BackupWriteAbort($pContext)
_WinAPI_CloseHandle($hFile)

; Free the used memory
_WinAPI_FreeMemory($pBuffer)

; Restore "SeBackupPrivilege" and "SeRestorePrivilege" privileges by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)
