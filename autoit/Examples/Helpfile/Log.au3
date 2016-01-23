#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the natural logarithm of 1000.
	Local $fLog1 = Log(1000)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fLog1)

	; Assign a Local variable the base-10 natural logarithm of 1000.
	Local $fLog2 = Log10(1000)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $fLog2)
EndFunc   ;==>Example

; User-defined function for common log
Func Log10($fNb)
	Return Log($fNb) / Log(10) ; 10 is the base
EndFunc   ;==>Log10
