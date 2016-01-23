#include <WinAPI.au3>
#include <WinAPIDlg.au3>

Local $sFile = _WinAPI_SaveFileDlg('', @WorkingDir, 'AutoIt v3 Scripts (*.au3)|All Files (*.*)', 1, 'MyScript.au3', '.', BitOR($OFN_PATHMUSTEXIST, $OFN_OVERWRITEPROMPT))

If Not @error Then
	ConsoleWrite($sFile & @CRLF)
EndIf
