#include <MsgBoxConstants.au3>

Example()

Func Example()
	; The values are the same so the expression is True
	MsgBox($MB_SYSTEMMODAL, "Result: 1=1", (1 = 1) ? "True!" : "False!")
	; The values are not the same so the expression is False
	MsgBox($MB_SYSTEMMODAL, "Result: 1=2", (1 = 2) ? "True!" : "False!")
EndFunc   ;==>Example
