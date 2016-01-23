Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds.
	Sleep(2000)

	; Move the edit control of Notepad using the handle returned by WinWait.
	ControlMove($hWnd, "", "Edit1", 0, 0, 150, 150)

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
