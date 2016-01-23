#include <APIRegConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIReg.au3>
#include <WinAPISys.au3>

Local $aValent[19][4]

; Note that if at least one of the following value names is not found in the specified registry key, the function fails!

; HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

$aValent[0][0] = 'AppData'
$aValent[1][0] = 'Cache'
$aValent[2][0] = 'Cookies'
$aValent[3][0] = 'Desktop'
$aValent[4][0] = 'Favorites'
$aValent[5][0] = 'History'
$aValent[6][0] = 'Local AppData'
$aValent[7][0] = 'My Music'
$aValent[8][0] = 'My Pictures'
$aValent[9][0] = 'My Video'
$aValent[10][0] = 'NetHood'
$aValent[11][0] = 'Personal'
$aValent[12][0] = 'PrintHood'
$aValent[13][0] = 'Programs'
$aValent[14][0] = 'Recent'
$aValent[15][0] = 'SendTo'
$aValent[16][0] = 'Start Menu'
$aValent[17][0] = 'Startup'
$aValent[18][0] = 'Templates'

_ArrayDisplay($aValent, '_WinAPI_RegQueryMultipleValues')

Local $hKey = _WinAPI_RegOpenKey($HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders', $KEY_QUERY_VALUE)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf

Local $pBuffer
_WinAPI_RegQueryMultipleValues($hKey, $aValent, $pBuffer)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), @extended, _WinAPI_GetErrorMessage(@extended))
	Exit
EndIf

_WinAPI_RegCloseKey($hKey)

_ArrayDisplay($aValent, '_WinAPI_RegQueryMultipleValues')

For $i = 0 To UBound($aValent) - 1
	$aValent[$i][2] = DllStructGetData(DllStructCreate('wchar[' & $aValent[$i][1] & ']', $aValent[$i][2]), 1)
Next

_WinAPI_FreeMemory($pBuffer)

_ArrayDisplay($aValent, '_WinAPI_RegQueryMultipleValues')
