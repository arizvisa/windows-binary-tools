#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)

ConsoleWrite(_WinAPI_GetFinalPathNameByHandleEx($hFile) & @CRLF)
ConsoleWrite(_WinAPI_GetFinalPathNameByHandleEx($hFile, $VOLUME_NAME_GUID) & @CRLF)
ConsoleWrite(_WinAPI_GetFinalPathNameByHandleEx($hFile, $VOLUME_NAME_NT) & @CRLF)
ConsoleWrite(_WinAPI_GetFinalPathNameByHandleEx($hFile, $VOLUME_NAME_NONE) & @CRLF)

_WinAPI_CloseHandle($hFile)
