#include <WinAPIFiles.au3>

Local $aDrive = DriveGetDrive('ALL')

If IsArray($aDrive) Then
	For $i = 1 To $aDrive[0]
		ConsoleWrite(StringUpper($aDrive[$i]) & ' => ' & _WinAPI_QueryDosDevice($aDrive[$i]) & @CRLF)
	Next
EndIf
