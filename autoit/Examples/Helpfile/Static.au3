#include <MsgBoxConstants.au3>

; Call the Example function to initialize the Static variable in Local scope.
Example()

; Call the Example function a second time to show that the variable has retained the data we last assigned to it.
Example()

Func Example()
	Local Static $sString = "This is a line of text which is declared using a Static variable in Local scope." & @CRLF & @CRLF & _
			"The variable $sString will now be visible to this function only and until the script closes."
	MsgBox($MB_SYSTEMMODAL, "", $sString)
	$sString = "If using just Local scope this string wouldn't be visible if this function was called multiple times, but since we're using the Static keyword" & @CRLF & _
			"the variable $sString will retain the data last assigned to it."
EndFunc   ;==>Example
