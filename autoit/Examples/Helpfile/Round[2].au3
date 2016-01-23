#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable an Array which will contain the rounded numbers.
	Local $aRound[5]

	$aRound[0] = Round(-1.582, 1) ; Returns -1.6.
	$aRound[1] = Round(3.1415, 9) ; Returns 3.1415
	$aRound[2] = Round(123.5, -1) ; Returns 120.
	$aRound[3] = Round(123.5) ; Returns 124.
	$aRound[4] = Round(50) ; Returns 50.

	; Display the results.
	For $i = 0 To UBound($aRound) - 1
		MsgBox($MB_SYSTEMMODAL, "", "Round" & $i & ": " & $aRound[$i] & @CRLF)
	Next
EndFunc   ;==>Example
