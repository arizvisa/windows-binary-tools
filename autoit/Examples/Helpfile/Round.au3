#include <MsgBoxConstants.au3>

Local $iRound1 = Round(-1.582, 1) ; Returns -1.6.
Local $iRound2 = Round(3.1415, 9) ; No change is made.
Local $iRound3 = Round(123.5, -1) ; Returns 120

MsgBox($MB_SYSTEMMODAL, "", "The following values were rounded: " & @CRLF & _
		$iRound1 & @CRLF & $iRound2 & @CRLF & $iRound3)
