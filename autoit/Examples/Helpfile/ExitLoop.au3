#include <MsgBoxConstants.au3>

Local $iSum = 0, $iAns = 0

While 1 ;use infinite loop since ExitLoop will get called
	$iAns = InputBox("Running total=" & $iSum, _
			"	Enter a positive number.  (A negative number exits)")
	If $iAns < 0 Then ExitLoop
	$iSum = $iSum + $iAns
WEnd

MsgBox($MB_SYSTEMMODAL, "", "The sum was: " & $iSum)
