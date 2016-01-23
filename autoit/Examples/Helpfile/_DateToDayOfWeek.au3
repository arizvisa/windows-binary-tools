#include <Date.au3>
#include <MsgBoxConstants.au3>

; Week day number for a given date
Local $iWeekday = _DateToDayOfWeek(@YEAR, @MON, @MDAY)
; Should be equal to @WDAY
MsgBox($MB_SYSTEMMODAL, "", "Todays WeekdayNumber is: " & $iWeekday)
MsgBox($MB_SYSTEMMODAL, "", "Today is a : " & _DateDayOfWeek($iWeekday))
