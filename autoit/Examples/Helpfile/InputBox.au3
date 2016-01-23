#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Places the input box in the top left corner displaying the characters as they
	; are typed.
	Local $sAnswer = InputBox("Question", "Where were you born?", "Planet Earth", "", _
			 - 1, -1, 0, 0)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $sAnswer)

	; Asks the user to enter a password.  Don't forget to validate it!
	Local $sPasswd = InputBox("Security Check", "Enter your password.", "", "*")

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $sPasswd)

	; Asks the user to enter a 1 or 2 character response.  The M in the password
	; field indicates that empty string is not accepted and the 2 indicates that the
	; responce will be at most 2 characters long.
	Local $sValue = InputBox("Testing", "Enter the 1 or 2 character code.", "", " M2")

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $sValue)
EndFunc   ;==>Example
