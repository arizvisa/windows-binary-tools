#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve memory details about the current process.
	Local $aMemory = ProcessGetStats()

	; If $aMemory is an array then display the following details about the process.
	If IsArray($aMemory) Then
		MsgBox($MB_SYSTEMMODAL, "", "WorkingSetSize: " & $aMemory[0] & @CRLF & _
				"PeakWorkingSetSize: " & $aMemory[1])
	Else
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred.")
	EndIf
EndFunc   ;==>Example
