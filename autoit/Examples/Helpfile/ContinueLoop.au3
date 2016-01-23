#include <MsgBoxConstants.au3>

; Display all the numbers for 1 to 10 but skip displaying  7.
For $i = 1 To 10
	If $i = 7 Then
		ContinueLoop ; Skip displaying the message box when $i is equal to 7.
	EndIf
	MsgBox($MB_SYSTEMMODAL, "", "The value of $i is: " & $i)
Next
