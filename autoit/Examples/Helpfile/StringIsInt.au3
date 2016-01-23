#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "", "Is the string +42 an integer: " & StringIsInt("+42") & @CRLF & _ ; Returns 1, due to the + (plus) symbol being at the beginning of the string.
		"Is the string -00 an integer: " & StringIsInt("-00") & @CRLF & _ ; Returns 1, due to the - (minus) symbol being at the beginning of the string.
		"Is the string 1.0 an integer: " & StringIsInt("1.0") & @CRLF & _ ; Returns 0, due to the decimal point.
		"Is the number 1.0 an integer: " & StringIsInt(1.0) & @CRLF & _ ; Returns 1, due to the number to string conversion.
		"Is the string 1+2 an integer: " & StringIsInt("1+2") & @CRLF) ; Returns 0, as the + (plus) symbol is not at the beginning of the string.
