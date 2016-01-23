#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aDays = StringSplit("Mon,Tues,Wed,Thur,Fri,Sat,Sun", ",") ; Split the string of days using the delimiter "," and the default flag value.
	#cs
		The array returned will contain the following values:
		$aDays[1] = "Mon"
		$aDays[2] = "Tues"
		$aDays[3] = "Wed"
		...
		$aDays[7] = "Sun"
	#ce

	For $i = 1 To $aDays[0] ; Loop through the array returned by StringSplit to display the individual values.
		MsgBox($MB_SYSTEMMODAL, "", "$aDays[" & $i & "] - " & $aDays[$i])
	Next
EndFunc   ;==>Example
