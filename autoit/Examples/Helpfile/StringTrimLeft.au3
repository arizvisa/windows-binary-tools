#include <MsgBoxConstants.au3>

Local $sString = StringTrimLeft("This is a sentence with whitespace.", 5) ; Remove the 5 leftmost characters from the string.
MsgBox($MB_SYSTEMMODAL, "", $sString)
