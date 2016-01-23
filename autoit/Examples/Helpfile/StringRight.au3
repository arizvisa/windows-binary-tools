#include <MsgBoxConstants.au3>

Local $sString = StringRight("This is a sentence with whitespace.", 5) ; Retrieve 5 characters from the right of the string.
MsgBox($MB_SYSTEMMODAL, "", "The 5 rightmost characters are: " & $sString)
