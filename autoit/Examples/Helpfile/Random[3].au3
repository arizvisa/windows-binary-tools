#include <MsgBoxConstants.au3>

; Create a random string of text.

Example()

Func Example()
	Local $sText = ""
	For $i = 1 To Random(5, 20, 1) ; Return an integer between 5 and 20 to determine the length of the string.
		$sText &= Chr(Random(65, 122, 1)) ; Return an integer between 65 and 122 which represent the ASCII characters between a (lower-case) to Z (upper-case).
	Next
	MsgBox($MB_SYSTEMMODAL, "", "The random string of text was: " & $sText) ; Display the string of text.
EndFunc   ;==>Example
