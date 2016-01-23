#include <Date.au3>
#include <MsgBoxConstants.au3>

; Retrieve the long name
Local $sLongMonthName = _DateToMonth(@MON)

; Retrieve the abbreviated name
Local $sShortMonthName = _DateToMonth(@MON, $DMW_SHORTNAME)

MsgBox($MB_SYSTEMMODAL, "Month of Year", "The month is: " & $sLongMonthName & " (" & $sShortMonthName & ")")
