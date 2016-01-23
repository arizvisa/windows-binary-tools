#include <APIRegConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIReg.au3>

Local $aPrivileges[2] = [$SE_BACKUP_NAME, $SE_RESTORE_NAME]

; Enable "SeBackupPrivilege" and "SeRestorePrivilege" privileges to save and restore registry hive
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
Local $aAdjust
_WinAPI_AdjustTokenPrivileges($hToken, $aPrivileges, $SE_PRIVILEGE_ENABLED, $aAdjust)
If @error Or @extended Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'You do not have the required privileges.')
	Exit
EndIf

; Save "HKEY_CURRENT_USER\Software\AutoIt v3" to reg.dat
Local $hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\AutoIt v3', $KEY_READ)
If _WinAPI_RegSaveKey($hKey, @TempDir & '\reg.dat', 1) Then
	MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', '"HKEY_CURRENT_USER\Software\AutoIt v3" has been saved to reg.dat.')
Else
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), '', _WinAPI_GetErrorMessage(@extended))
EndIf
_WinAPI_RegCloseKey($hKey)

; Restore "HKEY_CURRENT_USER\Software\AutoIt v3" to "HKEY_CURRENT_USER\Software\AutoIt v3 (Duplicate)"
$hKey = _WinAPI_RegCreateKey($HKEY_CURRENT_USER, 'Software\AutoIt v3 (Duplicate)', $KEY_WRITE)
If _WinAPI_RegRestoreKey($hKey, @TempDir & '\reg.dat') Then
	MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), '', '"HKEY_CURRENT_USER\Software\AutoIt v3" has been restored to "HKEY_CURRENT_USER\Software\AutoIt v3 (Duplicate)".')
Else
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), '', _WinAPI_GetErrorMessage(@extended))
EndIf
_WinAPI_RegCloseKey($hKey)

; Restore "SeBackupPrivilege" and "SeRestorePrivilege" privileges by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)

FileDelete(@TempDir & '\reg.dat')
