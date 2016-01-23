#include <Date.au3>
#include <MsgBoxConstants.au3>

If _DateIsLeapYear(@YEAR) Then
	MsgBox($MB_SYSTEMMODAL, "Leap Year", "This year is a leap year.")
Else
	MsgBox($MB_SYSTEMMODAL, "Leap Year", "This year is not a leap year.")
EndIf
