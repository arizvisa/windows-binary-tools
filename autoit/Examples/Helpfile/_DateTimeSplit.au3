#include <Date.au3>
#include <MsgBoxConstants.au3>

Local $aMyDate, $aMyTime
_DateTimeSplit("2005/01/01 14:30", $aMyDate, $aMyTime)

For $x = 1 To $aMyDate[0]
	MsgBox($MB_SYSTEMMODAL, $x, $aMyDate[$x])
Next
For $x = 1 To $aMyTime[0]
	MsgBox($MB_SYSTEMMODAL, $x, $aMyTime[$x])
Next
