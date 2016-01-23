#include <WinAPI.au3>
#include <WinAPIDlg.au3>

; Single file selection (returns the fully qualified path)
Local $sFile = _WinAPI_OpenFileDlg('', @WorkingDir, 'AutoIt v3 Scripts (*.au3)|All Files (*.*)', 1, '', '', BitOR($OFN_PATHMUSTEXIST, $OFN_FILEMUSTEXIST, $OFN_HIDEREADONLY))
If Not @error Then
	ConsoleWrite($sFile & @CRLF)
EndIf

; Multiple file selection (returns an array)
$sFile = _WinAPI_OpenFileDlg('', @WorkingDir, 'AutoIt v3 Scripts (*.au3)|All Files (*.*)', 1, '', '', BitOR($OFN_PATHMUSTEXIST, $OFN_FILEMUSTEXIST, $OFN_HIDEREADONLY, $OFN_ALLOWMULTISELECT, $OFN_EXPLORER))
If Not @error Then
	ConsoleWrite('--------------------------------------------------' & @CRLF)
	For $i = 1 To $sFile[0]
		ConsoleWrite($sFile[$i] & @CRLF)
	Next
EndIf
