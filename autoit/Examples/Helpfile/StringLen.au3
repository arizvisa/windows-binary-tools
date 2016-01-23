#include <MsgBoxConstants.au3>

; Retrieve the length of a string.
; If the string is using only ASCII characters, then the length is equal to the size in bytes e.g. 10 characters is 10 bytes.
Local $iLength = StringLen("This is a sentence with whitespace.")
MsgBox($MB_SYSTEMMODAL, "", "The length of this string is " & $iLength & " characters.")
