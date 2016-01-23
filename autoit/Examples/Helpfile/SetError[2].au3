#include <MsgBoxConstants.au3>

Local $sReturn = Example()

; Display the return value, @error and @extended value.
MsgBox($MB_SYSTEMMODAL, "", "Return value = " & $sReturn & @CRLF & _
		"Value of @error is: " & @error & @CRLF & _
		"Value of @extended is: " & @extended)

Func Example()
	Return SetError(3, 10, "Some return value") ; Set @error to 3, @extended to 10 and return the string "Some return value."
EndFunc   ;==>Example
