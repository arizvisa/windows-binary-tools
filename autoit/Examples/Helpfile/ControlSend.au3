Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds.
	Sleep(2000)

	; Send a string of text to the edit control of Notepad. The handle returned by WinWait is used for the "title" parameter of ControlSend.
	ControlSend($hWnd, "", "Edit1", "This is some text")

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)

	; Now a screen will pop up and ask to save the changes, the classname of the window is called
	; "#32770" and simulating the "TAB" key to move to the second button in which the "ENTER" is simulated to not "save the file"
	WinWaitActive("[CLASS:#32770]")
	Sleep(500)
	Send("{TAB}{ENTER}")
EndFunc   ;==>Example
