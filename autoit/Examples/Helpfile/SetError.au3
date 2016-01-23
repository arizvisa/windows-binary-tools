#include <MsgBoxConstants.au3>

Local $fResult = myDiv(5, 0)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Error", "Division by Zero")
Else
	MsgBox($MB_SYSTEMMODAL, "Result", $fResult)
EndIf
Exit

Func myDiv($iDividend, $iDivisor)
	If $iDividend = 0 And $iDivisor = 0 Then
		SetError(2) ; Indeterminate form 0/0.
	ElseIf $iDivisor = 0 Then
		SetError(1) ; Plain division by zero.
	EndIf
	Return $iDividend / $iDivisor
EndFunc   ;==>myDiv
