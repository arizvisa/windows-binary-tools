#include <MsgBoxConstants.au3>

; Retrieve the character position of where the string 'white' first occurs in the sentence.
Local $iPosition = StringInStr("This is a sentence with whitespace.", "white")
MsgBox($MB_SYSTEMMODAL, "", "The search string 'white' first appears at position: " & $iPosition)
