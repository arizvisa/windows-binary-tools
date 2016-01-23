#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIFiles.au3>
#include <WinAPIProc.au3>

Local Const $sTemp = @TempDir & '\Temporary File.txt'

; Check NTFS file system
If StringCompare(DriveGetFileSystem(_WinAPI_PathStripToRoot($sTemp)), 'NTFS') Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'The file must be on an NTFS file system volume.')
	Exit
EndIf

; Enable "SeRestorePrivilege" privilege to perform renaming operation
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
Local $aAdjust
_WinAPI_AdjustTokenPrivileges($hToken, $SE_RESTORE_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)
If @error Or @extended Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'You do not have the required privileges.')
	Exit
EndIf

; Create temporary file
FileWrite($sTemp, '')

ConsoleWrite('Old short name: ' & _WinAPI_PathStripPath(FileGetShortName($sTemp)) & @CRLF)

; Set "TEMP.TXT" short name for the file
Local $hFile = _WinAPI_CreateFileEx($sTemp, $OPEN_EXISTING, BitOR($GENERIC_WRITE, $RIGHTS_DELETE), 0, $FILE_FLAG_BACKUP_SEMANTICS)
_WinAPI_SetFileShortName($hFile, 'TEMP.TXT')
_WinAPI_CloseHandle($hFile)

ConsoleWrite('New short name: ' & _WinAPI_PathStripPath(FileGetShortName($sTemp)) & @CRLF)

; Delete temporary file
FileDelete($sTemp)

; Restore "SeRestorePrivilege" privilege by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)
