#include <Date.au3>
#include <MsgBoxConstants.au3>

; Add 5 days to today
Local $sNewDate = _DateAdd('d', 5, _NowCalcDate())
MsgBox($MB_SYSTEMMODAL, "", "Today + 5 days:" & $sNewDate)

; Subtract 2 weeks from today
$sNewDate = _DateAdd('w', -2, _NowCalcDate())
MsgBox($MB_SYSTEMMODAL, "", "Today minus 2 weeks: " & $sNewDate)

; Add 15 minutes to current time
$sNewDate = _DateAdd('n', 15, _NowCalc())
MsgBox($MB_SYSTEMMODAL, "", "Current time +15 minutes: " & $sNewDate)

; Calculated eventlogdate which returns second since 1970/01/01 00:00:00
$sNewDate = _DateAdd('s', 1087497645, "1970/01/01 00:00:00")
MsgBox($MB_SYSTEMMODAL, "", "Date: " & $sNewDate)
