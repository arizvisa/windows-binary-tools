#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "", "Is the string 42 a digit: " & StringIsDigit("42") & @CRLF & _ ; Returns 1, as the string contains only digit (0-9) characters.
		"Is the string 00 a digit: " & StringIsDigit("00") & @CRLF & _ ; Returns 1, as the string contains only digit (0-9) characters.
		"Is the string 1.0 a digit: " & StringIsDigit("1.0") & @CRLF & _ ; Returns 0, due to the decimal point.
		"Is the number 1.0 a digit: " & StringIsDigit(1.0) & @CRLF & _ ; Returns 1, due to the number to string conversion.
		"Is the string 1+2 a digit: " & StringIsDigit("1+2") & @CRLF) ; Returns 0, as the + (plus) symbol is present in the string.
