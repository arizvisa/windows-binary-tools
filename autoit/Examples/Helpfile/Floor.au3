#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable an array containing the numbers.
	Local $aNumber[8] = [4.8, 4.5, 4.3, 4, -4.8, -4.5, -4.3, -4]

	; Assign a Local variable a string which will contain the results.
	Local $sResults = ""

	; Loop through the array: calculate the floor and format the result.
	For $i = 0 To 7
		$sResults &= "Floor(" & $aNumber[$i] & ") = " & Floor($aNumber[$i]) & @CRLF & ($i = 3 ? @CRLF : "")
	Next

	; Display the results.
	MsgBox($MB_SYSTEMMODAL, "", $sResults)
EndFunc   ;==>Example
