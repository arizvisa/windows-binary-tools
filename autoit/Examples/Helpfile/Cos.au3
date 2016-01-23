#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local constant variable the approximate PI number.
	Local Const $PI = 3.141592653589793

	; Assign a Local variable the cosine of PI / 4 (equals to Sqrt(2) / 2).
	Local $fCos1 = Cos($PI / 4)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fCos1)

	; Assign a Local variable the formula to switch from radian to degree (equals to one degree in radian).
	Local $fDegToRad = $PI / 180

	; Assign a Local variable the cosine of 90 degrees (firstly converted to radians).
	Local $fCos2 = Cos(90 * $fDegToRad)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fCos2)
EndFunc   ;==>Example
