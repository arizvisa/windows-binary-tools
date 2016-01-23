#include <MsgBoxConstants.au3>

Local $sString = StringUpper("This is a string") ; Convert the following string to uppercase.
MsgBox($MB_SYSTEMMODAL, "", "StringUpper returned: " & $sString)
