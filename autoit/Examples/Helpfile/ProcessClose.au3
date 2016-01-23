Example()

Func Example()
	; Run Notepad
	Local $iPID = Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	WinWait("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad process using the PID returned by Run.
	ProcessClose($iPID)
EndFunc   ;==>Example
