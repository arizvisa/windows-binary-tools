#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a first class object of MsgBox and assign to a Local variable.
	Local $hMsgBox = MsgBox

	; Display a MsgBox using the previously assigned variable.
	$hMsgBox($MB_SYSTEMMODAL, "", "This is a sentence with whitespace.")

	; Re-assign the variable $hMsgBox with our user-defined message box function.
	$hMsgBox = MyMsgBox

	; Display a MsgBox that shows $hMsgBox is a function.
	$hMsgBox($MB_SYSTEMMODAL, "", "Check if $hMsgBox is a function or not." & @CRLF & _
			@CRLF & _
			"This will return 1 as the function is a user function: " & IsFunc($hMsgBox))
EndFunc   ;==>Example

; User-defined message box function.
Func MyMsgBox($iFlag, $sTitle, $sText = "")
	Return MsgBox($iFlag, $sTitle, $sText)
EndFunc   ;==>MyMsgBox
