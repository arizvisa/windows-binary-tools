#include <MsgBoxConstants.au3>

Local $sString = StringTrimRight("This is a sentence with whitespace.", 5) ; Remove the 5 rightmost characters from the string.
MsgBox($MB_SYSTEMMODAL, "", $sString)
