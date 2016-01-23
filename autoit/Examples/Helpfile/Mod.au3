#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the number 18.
	Local $iNb = 18

	; If the mudulus operation of $iNb by 2 equals to 0 then $iNb is even.
	If Mod($iNb, 2) = 0 Then
		MsgBox($MB_SYSTEMMODAL, "", $iNb & " is an even number.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", $iNb & " is an odd number.")
	EndIf

	; Assign a Local variable the modulus operation of 4 by 7.
	Local $iMod1 = Mod(4, 7) ; 4%7 = 4 because the divisor > dividend

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iMod1)

	; Assign a Local variable the modulus operation of 1 by 3/4.
	Local $iMod2 = Mod(1, 3 / 4) ; 1%(3/4) = 0.25 because the divisor is a float

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iMod2)
EndFunc   ;==>Example
