#include <APIRegConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIReg.au3>

Local $hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\AutoIt v3', $KEY_QUERY_VALUE)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf

ConsoleWrite(_WinAPI_GetRegKeyNameByHandle($hKey) & @CRLF)

_WinAPI_RegCloseKey($hKey)
