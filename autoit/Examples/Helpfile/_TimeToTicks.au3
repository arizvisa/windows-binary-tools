#include <Date.au3>
#include <MsgBoxConstants.au3>

Local $iSec, $iMin, $iHour
; calculate with time
Local $iStartTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
; calculate 45 minutes later
Local $iEndTicks = $iStartTicks + 45 * 60 * 1000
_TicksToTime($iEndTicks, $iHour, $iMin, $iSec)
MsgBox($MB_SYSTEMMODAL, '', 'New Time:' & $iHour & ":" & $iMin & ":" & $iSec)
