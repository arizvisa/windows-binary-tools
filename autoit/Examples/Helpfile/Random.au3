#include <MsgBoxConstants.au3>

; Flip a coin.
Example()

Func Example()
	If Random(0, 1, 1) Then ; Return an integer between 0 and 1.
		MsgBox($MB_SYSTEMMODAL, "", "The side of the coin was: Heads") ; If the random integer was 1 then heads was thrown.
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The side of the coin was: Tails") ; If the random integer was 0 then tails was thrown.
	EndIf
EndFunc   ;==>Example
