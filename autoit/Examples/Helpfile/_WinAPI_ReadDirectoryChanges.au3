#include <APIFilesConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

Global $g_sPath = @TempDir & '\~TEST~'

DirCreate($g_sPath)
If Not FileExists($g_sPath) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create folder.')
	Exit
EndIf

OnAutoItExitRegister('OnAutoItExit')

Local $hDirectory = _WinAPI_CreateFileEx($g_sPath, $OPEN_EXISTING, $FILE_LIST_DIRECTORY, BitOR($FILE_SHARE_READ, $FILE_SHARE_WRITE), $FILE_FLAG_BACKUP_SEMANTICS)
If @error Then
	_WinAPI_ShowLastError('', 1)
EndIf

Local $pBuffer = _WinAPI_CreateBuffer(8388608)

Local $aData
While 1
	$aData = _WinAPI_ReadDirectoryChanges($hDirectory, BitOR($FILE_NOTIFY_CHANGE_FILE_NAME, $FILE_NOTIFY_CHANGE_DIR_NAME), $pBuffer, 8388608, 1)
	If Not @error Then
		_ArrayDisplay($aData, '_WinAPI_ReadDirectoryChanges')
	Else
		_WinAPI_ShowLastError('', 1)
	EndIf
WEnd

Func OnAutoItExit()
	DirRemove($g_sPath, 1)
EndFunc   ;==>OnAutoItExit
