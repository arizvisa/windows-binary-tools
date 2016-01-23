#include <MsgBoxConstants.au3>

Local $sText = ""
For $i = 65 To 90
	$sText = $sText & Chr($i) ; Or $sText &= Chr($i) can be used as well.
Next
MsgBox($MB_SYSTEMMODAL, "Uppercase alphabet", $sText) ; Display the characters between 65 to 90.
