#include <MsgBoxConstants.au3>

; Roll a die.

Example()

Func Example()
	MsgBox($MB_SYSTEMMODAL, "", "The die landed on number " & Random(1, 6, 1) & ".") ; Return an integer between 1 and 6.
EndFunc   ;==>Example
