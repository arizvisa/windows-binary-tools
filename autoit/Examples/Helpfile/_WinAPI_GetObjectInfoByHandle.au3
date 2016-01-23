#include <WinAPISys.au3>

Local $sFile = @ScriptFullPath
Local $hFile = _WinAPI_CreateFile($sFile, 2, 0, 6)
If @error Then Exit

Local $aInfo = _WinAPI_GetObjectInfoByHandle($hFile)
If IsArray($aInfo) Then
	ConsoleWrite('File:       ' & $sFile & @CRLF)
	ConsoleWrite('Handle:     ' & $hFile & @CRLF)
	ConsoleWrite('Attributes: 0x' & Hex($aInfo[0]) & @CRLF)
	ConsoleWrite('Access:     0x' & Hex($aInfo[1]) & @CRLF)
	ConsoleWrite('Handles:    ' & $aInfo[2] & @CRLF)
	ConsoleWrite('Pointers:   ' & $aInfo[3] & @CRLF)
EndIf

_WinAPI_CloseHandle($hFile)
