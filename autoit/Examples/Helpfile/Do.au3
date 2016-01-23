#include <MsgBoxConstants.au3>

Local $i = 0
Do
	MsgBox($MB_SYSTEMMODAL, "", "The value of $i is: " & $i) ; Display the value of $i.
	$i = $i + 1 ; Or $i += 1 can be used as well.
Until $i = 10 ; Increase the value of $i until it equals the value of 10.
