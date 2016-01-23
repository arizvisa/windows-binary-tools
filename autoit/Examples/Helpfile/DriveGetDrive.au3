#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Local $aArray = DriveGetDrive($DT_ALL)
If @error Then
	; An error occurred when retrieving the drives.
	MsgBox($MB_SYSTEMMODAL, "", "It appears an error occurred.")
Else
	For $i = 1 To $aArray[0]
		; Show all the drives found and convert the drive letter to uppercase.
		MsgBox($MB_SYSTEMMODAL, "", "Drive " & $i & "/" & $aArray[0] & ":" & @CRLF & StringUpper($aArray[$i]))
	Next
EndIf
