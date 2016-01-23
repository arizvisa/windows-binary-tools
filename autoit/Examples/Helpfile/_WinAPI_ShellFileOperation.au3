#include <APIShellExConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIShellEx.au3>

; Create temporary file
Local $sTemp = _WinAPI_GetTempFileName(@TempDir)

ShellExecute('::{645FF040-5081-101B-9F08-00AA002F954E}')

; Delete file to Recycle Bin
If FileExists($sTemp) Then
	_WinAPI_ShellFileOperation($sTemp, '', $FO_DELETE, BitOR($FOF_ALLOWUNDO, $FOF_NO_UI))
EndIf
