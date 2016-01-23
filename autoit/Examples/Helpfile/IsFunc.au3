#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a first class object of MsgBox and assign to a Local variable.
	Local $hMsgBox = MsgBox

	; Display a MsgBox using the previously assigned variable.
	$hMsgBox($MB_SYSTEMMODAL, "", "This is a sentence with whitespace.")

	; Display a MsgBox that shows $hMsgBox is a native function.
	$hMsgBox($MB_SYSTEMMODAL, "", "Check if $hMsgBox is a function or not." & @CRLF & _
			@CRLF & _
			"This will return 2 as the function is native: " & IsFunc($hMsgBox))
EndFunc   ;==>Example
