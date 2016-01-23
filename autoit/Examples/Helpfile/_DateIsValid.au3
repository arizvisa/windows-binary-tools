#include <Date.au3>
#include <MsgBoxConstants.au3>

Local $sDate = @YEAR & "/" & @MON & "/" & @MDAY

If _DateIsValid($sDate) Then
	MsgBox($MB_SYSTEMMODAL, "Valid Date", "The specified date is valid.")
Else
	MsgBox($MB_SYSTEMMODAL, "Valid Date", "The specified date is invalid.")
EndIf
