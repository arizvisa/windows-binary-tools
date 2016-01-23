#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "", "Is the string 42 a hexadecimal digit: " & StringIsXDigit("42") & @CRLF & _ ; Returns 1, as the string contains only hexadecimal (0-9, A-F) characters.
		"Is the string 00 a hexadecimal digit: " & StringIsXDigit("00") & @CRLF & _ ; Returns 1, as the string contains only hexadecimal (0-9, A-F) characters.
		"Is the string 1.0 a hexadecimal digit: " & StringIsXDigit("1.0") & @CRLF & _ ; Returns 0, due to the decimal point.
		"Is the number 1.0 a hexadecimal digit: " & StringIsXDigit(1.0) & @CRLF & _ ; Returns 1, due to the number to string conversion.
		"Is the string 'A string' a hexadecimal digit: " & StringIsXDigit("A string.") & @CRLF) ; Returns 0, due to the string containing whitespace.
