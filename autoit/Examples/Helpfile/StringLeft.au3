#include <MsgBoxConstants.au3>

Local $sString = StringLeft("This is a sentence with whitespace.", 5) ; Retrieve 5 characters from the left of the string.
MsgBox($MB_SYSTEMMODAL, "", "The 5 leftmost characters are: " & $sString)
