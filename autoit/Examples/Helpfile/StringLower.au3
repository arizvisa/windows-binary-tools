#include <MsgBoxConstants.au3>

Local $sString = StringLower("This is a string") ; Convert the following string to lowercase.
MsgBox($MB_SYSTEMMODAL, "", "StringLower returned: " & $sString)
