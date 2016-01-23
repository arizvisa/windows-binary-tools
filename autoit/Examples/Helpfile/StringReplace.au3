#include <MsgBoxConstants.au3>

; Replace a blank space (' ') with a - (minus) character.
Local $sString = StringReplace("This is a sentence with whitespace.", " ", "-")
Local $iReplacements = @extended
MsgBox($MB_SYSTEMMODAL, "", $iReplacements & " replacements were made and the new string is:" & @CRLF & @CRLF & $sString)
