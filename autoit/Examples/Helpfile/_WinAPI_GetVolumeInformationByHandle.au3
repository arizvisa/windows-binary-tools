#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hFile = _WinAPI_CreateFile(@ScriptFullPath, 2, 0, 6)
Local $aInfo = _WinAPI_GetVolumeInformationByHandle($hFile)
_WinAPI_CloseHandle($hFile)

ConsoleWrite('Volume name: ' & $aInfo[0] & @CRLF)
ConsoleWrite('File system: ' & $aInfo[4] & @CRLF)
ConsoleWrite('Serial number: ' & $aInfo[1] & @CRLF)
ConsoleWrite('File name length: ' & $aInfo[2] & @CRLF)
ConsoleWrite('Flags: 0x' & Hex($aInfo[3]) & @CRLF)
