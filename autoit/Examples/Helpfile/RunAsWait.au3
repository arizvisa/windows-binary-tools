#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Change the username and password to the appropriate values for your system.
	Local $sUserName = "Username"
	Local $sPassword = "Password"

	; Run Notepad and wait for the Notepad process to close. Notepad is run under the user previously specified.
	Local $iReturn = RunAsWait($sUserName, @ComputerName, $sPassword, $RUN_LOGON_NOPROFILE, "notepad.exe")

	; Display the return code of the Notepad process.
	MsgBox($MB_SYSTEMMODAL, "", "The return code from Notepad was: " & $iReturn)
EndFunc   ;==>Example
