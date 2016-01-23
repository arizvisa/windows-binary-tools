Example()

Func Example()
	; Simulate the key combination Win + R to open the Run dialogue window.
	Send("#r")

	; Wait 10 seconds for the Run dialogue window to appear.
	WinWait("Run", "", 10)

	; Simulate entering notepad.exe and pressing the 'ENTER' key.
	Send("notepad.exe{Enter}")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Simulate entering the following string and pressing the 'F5' key to input the date and time into edit control of Notepad.
	Send("Today's time/date is {F5}")

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)

	; Now a screen will pop up and ask to save the changes, the classname of the window is called
	; "#32770" and simulating the "TAB" key to move to the second button in which the "ENTER" is simulated to not "save the file"
	WinWaitActive("[CLASS:#32770]")
	Sleep(500)
	Send("{TAB}{ENTER}")
EndFunc   ;==>Example
