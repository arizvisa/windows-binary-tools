#include <MsgBoxConstants.au3>

; Add the carriage return charcter to all the line feed characters in the string.
Local $sString = StringAddCR("This is a sentence " & @LF & "with " & Chr(10) & "whitespace.")
MsgBox($MB_SYSTEMMODAL, "", $sString)
