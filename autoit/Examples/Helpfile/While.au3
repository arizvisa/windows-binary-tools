#include <MsgBoxConstants.au3>

Local $i = 0
While $i <= 10
	MsgBox($MB_SYSTEMMODAL, "", "Value of $i is: " & $i)
	$i = $i + 1
WEnd
