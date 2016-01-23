#include <WinAPI.au3>
#include <WinAPIFiles.au3>

Local $aDrive = DriveGetDrive('ALL')

If IsArray($aDrive) Then
	Local $sText
	For $i = 1 To $aDrive[0]
		If _WinAPI_IsWritable($aDrive[$i]) Then
			$sText = 'Writable'
		Else
			If @error Then
				$sText = 'No media'
				If @extended Then $sText &= ' ( @error=' & @error & ' LastError=' & _WinAPI_GetLastErrorMessage() & ')'
			Else
				$sText = 'Not writable'
			EndIf
		EndIf
		ConsoleWrite(StringUpper($aDrive[$i]) & ' => ' & $sText & @CRLF)
	Next
EndIf
