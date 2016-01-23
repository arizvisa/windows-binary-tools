#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "", "Is the string 1.5 a floating point number: " & StringIsFloat("1.5") & @CRLF & _ ; Returns 1, due to the decimal point.
		"Is the string 7. a floating point number: " & StringIsFloat("7.") & @CRLF & _ ; Returns 1, due to the decimal point.
		"Is the string 3/4 a floating point number: " & StringIsFloat("3/4") & @CRLF & _ ; Returns 0, as the string 3 / (forward slash) 4 is not a floating point number.
		"Is the number 1.0 a floating point number: " & StringIsFloat(1.0) & @CRLF & _ ; Returns 1, due to the number to string conversion as well as the decimal point.
		"Is the string 2 a floating point number: " & StringIsFloat("2") & @CRLF) ; Returns 0, due to 2 being an integer.
