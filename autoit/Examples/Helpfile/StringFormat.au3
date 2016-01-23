Example()

Func Example()
	Local $iInt_Unsigned = 43951789
	Local $iInt_Negative = -43951789

	ConsoleWrite(@CRLF & "Numeric Formats" & @CRLF)

	PrintFormat($iInt_Unsigned, "%d", "standard positive integer with no sign", 1) ; 43951789
	PrintFormat($iInt_Negative, "%d", "standard negative integer with sign", 1) ; -43951789
	PrintFormat($iInt_Unsigned, "%i", "standard integer", 1) ; 43951789
	PrintFormat($iInt_Unsigned, "%09i", "9 digits with leading zero", 1) ; 043951789
	PrintFormat($iInt_Unsigned, "%e", "scientific notation") ; 4.395179e+007
	PrintFormat($iInt_Unsigned, "%u", "unsigned integer with positive integer", 1) ; 43951789
	PrintFormat($iInt_Negative, "%u", "unsigned integer with negative integer", 1) ; 4251015507
	PrintFormat($iInt_Unsigned, "%f", "floating point") ; 43951789.000000
	PrintFormat($iInt_Unsigned, "%.2f", "floating point with 2 digits after decimal point", 1) ; 43951789.00
	PrintFormat($iInt_Unsigned, "%o", "octal", 1) ; 247523255
	PrintFormat($iInt_Unsigned, "%s", "string", 1) ; 43951789
	PrintFormat($iInt_Unsigned, "%x", "hexadecimal (lower-case)", 1) ; 29ea6ad
	PrintFormat($iInt_Unsigned, "%X", "hexadecimal (upper-case)", 1) ; 29EA6AD
	PrintFormat($iInt_Unsigned, "%+d", "sign specifier on a positive integer", 1) ; +43951789
	PrintFormat($iInt_Negative, "%+d", "sign specifier on a negative integer", 1) ; -43951789

	Local $sString = "string"
	Local $sString_Long = "longstring"

	ConsoleWrite(@CRLF & "String Formats - [ ] used to show beginning/end of string" & @CRLF)

	PrintFormat($sString, "[%s]", "standard string", 1) ; [string]
	PrintFormat($sString, "[%10s]", "10 chars right justified with added spaces") ; [    string]
	PrintFormat($sString, "[%-10s]", "10 chars left justified with added spaces") ; [string    ]
	PrintFormat($sString_Long, "[%10.8s]", "right justified but precision 8 so truncated") ; [  longer s]
	PrintFormat($sString_Long, "[%-10.8s]", "left justifed but precision 8 so truncated") ; [longer s  ]
	PrintFormat($sString, "[%010s]", "10 chars with leading zero") ; [0000string]

	ConsoleWrite(@CRLF & "Date Format - each % uses a new parameter" & @CRLF)

	ConsoleWrite('"%02i\%02i\%04i" 0n (1, 9, 2013) => ' & StringFormat("%02i\%02i\%04i", 1, 9, 2013) & @CRLF & @CRLF)
EndFunc   ;==>Example

Func PrintFormat($vVar, $sFormat, $sExplan, $iTab = 0)
	ConsoleWrite('"' & $sFormat & '" on ' & $vVar & @TAB & ' => ' & StringFormat($sFormat, $vVar))
	If $iTab Then ConsoleWrite(@TAB)
	ConsoleWrite(@TAB & " ; " & $sExplan & @CRLF)
EndFunc   ;==>PrintFormat
