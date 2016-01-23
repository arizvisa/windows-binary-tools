#include <MsgBoxConstants.au3>

Local $sString = String(10) ; The expression passed to String will return a string representation, currently 10 is a number.
MsgBox($MB_SYSTEMMODAL, "", "$sString contains the value: " & $sString & " and IsString returns: " & IsString($sString))
