#include <Date.au3>
#include <WinAPIFiles.au3>

Local $hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)
Local $aInfo = _WinAPI_GetFileInformationByHandle($hFile)
If IsArray($aInfo) Then
	For $i = 1 To 3
		If IsDllStruct($aInfo[$i]) Then
			Local $tFILETIME = _Date_Time_FileTimeToLocalFileTime($aInfo[$i])
			$aInfo[$i] = _Date_Time_FileTimeToSystemTime($tFILETIME)
			$aInfo[$i] = _Date_Time_SystemTimeToDateTimeStr($aInfo[$i])
		Else
			$aInfo[$i] = 'Unknown'
		EndIf
	Next
	ConsoleWrite('!Path:          ' & _WinAPI_GetFinalPathNameByHandle($hFile) & @CRLF)
	ConsoleWrite('!Attributes:    0x' & Hex($aInfo[0], 8) & @CRLF)
	ConsoleWrite('!Created:       ' & $aInfo[1] & @CRLF)
	ConsoleWrite('!Accessed:      ' & $aInfo[2] & @CRLF)
	ConsoleWrite('!Modified:      ' & $aInfo[3] & @CRLF)
	ConsoleWrite('!Volume serial: ' & $aInfo[4] & @CRLF)
	ConsoleWrite('!Size:          ' & $aInfo[5] & @CRLF)
	ConsoleWrite('!Links:         ' & $aInfo[6] & @CRLF)
	ConsoleWrite('!ID:            ' & $aInfo[7] & @CRLF)
EndIf
_WinAPI_CloseHandle($hFile)
