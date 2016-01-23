#include <AutoItConstants.au3>

Example()

Func Example()
	; Change the username and password to the appropriate values for your system.
	Local $sUserName = "Username"
	Local $sPassword = "Password"

	; Run Notepad with the window maximized. Notepad is run under the user previously specified.
	Local $iPID = RunAs($sUserName, @ComputerName, $sPassword, $RUN_LOGON_NOPROFILE, "notepad.exe", "", @SW_SHOWMAXIMIZED)

	; Wait 10 seconds for the Notepad window to appear.
	WinWait("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad process using the PID returned by RunAs.
	ProcessClose($iPID)
EndFunc   ;==>Example
