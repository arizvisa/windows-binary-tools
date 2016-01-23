#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Sets the seed to the number 12.
	SRandom(12)

	; Assign a Local variable the random number based on the above seed.
	Local $iRandom1 = Random()

	; Note: You will get the same result each time as the seed is constant.

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iRandom1)
EndFunc   ;==>Example
