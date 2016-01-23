#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a first class object of MsgBox and assign to a Local variable.
	Local $hMsgBox = MsgBox

	; Display a MsgBox using the previously assigned variable.
	$hMsgBox($MB_SYSTEMMODAL, "", "This is a sentence with whitespace.")

	; Display a MsgBox that shows the function name $hMsgBox.
	$hMsgBox($MB_SYSTEMMODAL, "", "The function name of $hMsgBox is: " & FuncName($hMsgBox))
EndFunc   ;==>Example
