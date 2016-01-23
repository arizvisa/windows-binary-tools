#include <MsgBoxConstants.au3>

Local $bNumber1 = Number(1 + 2 + 10) ; Returns 13.
Local $bNumber2 = Number("3.14") ; Returns 3.14.
Local $bNumber3 = Number("24/7") ; Returns 24.
Local $bNumber4 = Number("tmp3") ; Returns 0 as this is a string.
Local $bNumber5 = Number("1,000,000") ; Returns 1 as it strips everything after and including the first comma.

MsgBox($MB_SYSTEMMODAL, "", "The following values were converted to a numeric value:" & @CRLF & _
		$bNumber1 & @CRLF & $bNumber2 & @CRLF & $bNumber3 & @CRLF & $bNumber4 & @CRLF & $bNumber5)
