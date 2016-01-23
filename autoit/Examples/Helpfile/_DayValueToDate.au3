#include <Date.au3>
#include <MsgBoxConstants.au3>

; Julian date of today.
Local $sJulDate = _DateToDayValue(@YEAR, @MON, @MDAY)
MsgBox($MB_SYSTEMMODAL, "", "Todays Julian date is: " & $sJulDate)

; 14 days ago calculation.
Local $Y, $M, $D
$sJulDate = _DayValueToDate($sJulDate - 14, $Y, $M, $D)
MsgBox($MB_SYSTEMMODAL, "", "14 days ago:" & $M & "/" & $D & "/" & $Y & "  (" & $sJulDate & ")")
