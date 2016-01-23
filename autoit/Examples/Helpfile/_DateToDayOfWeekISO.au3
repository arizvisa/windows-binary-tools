#include <Date.au3>
#include <MsgBoxConstants.au3>

; ISO week day number for a given date 1 = Monday - 7 = Sunday
Local $iWeekday = _DateToDayOfWeekISO(@YEAR, @MON, @MDAY)
; NOT equal to @WDAY
MsgBox($MB_SYSTEMMODAL, "", "Today's ISO week day number is: " & $iWeekday)
