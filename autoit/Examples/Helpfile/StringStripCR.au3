#include <MsgBoxConstants.au3>

; A string with carriage return characters.
Local $sString = "This is a sentence " & @CR & "with " & Chr(13) & "whitespace."

; Strip all carriage return characters in the string.
Local $sStrippedString = StringStripCR($sString)

; Display the before and after string.
MsgBox($MB_SYSTEMMODAL, "", "Before: " & $sString & @CRLF & @CRLF & "After: " & $sStrippedString)
