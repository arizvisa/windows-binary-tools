#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the arcCosine of 0.5.
	Local $fArcCos1 = ACos(0.5)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fArcCos1 & " rad.")

	; Assign a Local constant variable the approximate PI number.
	Local Const $PI = 3.141592653589793

	; Assign a Local variable the formula to switch from radian to degree (equals to one radian in degree).
	Local $fRadToDeg = 180 / $PI

	; Assign a Local variable a number in degree.
	Local $fArcCos2 = $fRadToDeg * ACos(-1)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fArcCos2 & " deg.")
EndFunc   ;==>Example
