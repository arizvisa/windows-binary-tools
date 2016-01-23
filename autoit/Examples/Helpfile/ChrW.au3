#include <MsgBoxConstants.au3>

Local $sText = ""
For $i = 256 To 512
	$sText = $sText & ChrW($i) ; Or $sText &= ChrW($i) can be used as well.
Next
MsgBox($MB_SYSTEMMODAL, "Unicode chars 256 to 512", $sText) ; Display the unicode characters between 256 to 512.
