#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

; Create temporary file
Local $sFile = _WinAPI_GetTempFileName(@TempDir)

; Create unique object ID for a file
Local $tGUID = _WinAPI_CreateObjectID($sFile)

ConsoleWrite('GUID: ' & _WinAPI_StringFromGUID($tGUID) & @CRLF)

; Open file by object ID and retrieve its full path
Local $hFile = _WinAPI_OpenFileById(_WinAPI_PathStripToRoot(@TempDir), $tGUID, 0, BitOR($FILE_SHARE_DELETE, $FILE_SHARE_READ, $FILE_SHARE_WRITE))
$sFile = _WinAPI_GetFinalPathNameByHandleEx($hFile)
_WinAPI_CloseHandle($hFile)

ConsoleWrite('Path: ' & StringRegExpReplace($sFile, '\\+.\\', '') & @CRLF)

; Delete file
FileDelete($sFile)
