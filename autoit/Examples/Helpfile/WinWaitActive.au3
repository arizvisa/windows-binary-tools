Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	WinWaitActive("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds to display the Notepad window.
	Sleep(2000)

	; Close the Notepad window using the classname of Notepad.
	WinClose("[CLASS:Notepad]")
EndFunc   ;==>Example
