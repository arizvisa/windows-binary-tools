#include <APIRegConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIReg.au3>

Local $hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Run', $KEY_READ)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf
Local $iCount = _WinAPI_RegQueryInfoKey($hKey)
Local $aKey[$iCount[2]]
For $i = 0 To UBound($aKey) - 1
	$aKey[$i] = _WinAPI_RegEnumValue($hKey, $i)
Next

_WinAPI_RegCloseKey($hKey)

_ArrayDisplay($aKey, '_WinAPI_RegEnumValue')
