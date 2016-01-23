#include <Math.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iVar = Int(InputBox("Odd or Even", "Enter a number:")) ; Parse as an integer.
	Local $iResult = _MathCheckDiv($iVar, 2) ; Divide the number by 2.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "You did not enter a valid number")
	Else
		Switch $iResult
			Case -1
				MsgBox($MB_SYSTEMMODAL, "", "You did not enter a valid number")
			Case $MATH_ISNOTDIVISIBLE
				MsgBox($MB_SYSTEMMODAL, "", "Number is odd")
			Case $MATH_ISDIVISIBLE
				MsgBox($MB_SYSTEMMODAL, "", "Number is even")
			Case Else
				MsgBox($MB_SYSTEMMODAL, "", "Could not parse")
		EndSwitch
	EndIf
EndFunc   ;==>Example
