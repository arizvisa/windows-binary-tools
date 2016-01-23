#include <MsgBoxConstants.au3>

Example(Default, Default)

Func Example($vParam1 = Default, $vParam2 = "Two", $vParam3 = Default)
	If $vParam1 = Default Then $vParam1 = "One" ; If the Default keyword is used, the assign the variable as "One"
	If $vParam3 = Default Then $vParam3 = "Three" ; If the Default keyword is used, the assign the variable as "Three"

	; Display the following parameters passed to the function.
	MsgBox($MB_SYSTEMMODAL, "Paramaters", "1 = " & $vParam1 & @CRLF & _
			"2 = " & $vParam2 & @CRLF & _
			"3 = " & $vParam3)
EndFunc   ;==>Example
