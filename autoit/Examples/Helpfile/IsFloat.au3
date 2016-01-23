#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $bIsFloat1 = IsFloat(3.14159) ; Returns 1
	Local $bIsFloat2 = IsFloat(3.000) ; Returns 0 as the value is an integer i.e. 3
	Local $bIsFloat3 = IsFloat(1 / 2 - 5) ; Returns 1
	Local $bIsFloat4 = IsFloat(1.5e3) ; Returns 0 as 1.5e3 is equal to 1500.
	Local $bIsFloat5 = IsFloat("12.345") ; Returns 0 as the value is a string.

	MsgBox($MB_SYSTEMMODAL, "", "IsFloat: " & @CRLF & _
			$bIsFloat1 & @CRLF & $bIsFloat2 & @CRLF & $bIsFloat3 & @CRLF & $bIsFloat4 & @CRLF & $bIsFloat5)
EndFunc   ;==>Example
