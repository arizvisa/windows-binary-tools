#include <WinAPIFiles.au3>

Local $aData, $aDrive = DriveGetDrive('FIXED')
Local $aList[10]

For $i = 0 To UBound($aDrive) - 1
	$aList[$i] = ''
Next
If IsArray($aDrive) Then
	For $i = 1 To $aDrive[0]
		$aData = _WinAPI_GetDriveNumber($aDrive[$i])
		If IsArray($aData) Then
			$aList[$aData[1]] &= StringUpper($aDrive[$i]) & ' '
		EndIf
	Next
EndIf
For $i = 0 To UBound($aDrive) - 1
	If $aList[$i] Then
		ConsoleWrite('Drive' & $i & ' => ' & $aList[$i] & @CRLF)
	EndIf
Next
