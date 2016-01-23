Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Set the state of the Notepad window to "hide".
	WinSetState($hWnd, "", @SW_HIDE)

	; Wait for 2 seconds.
	Sleep(2000)

	; Set the state of the Notepad window to "show".
	WinSetState($hWnd, "", @SW_SHOW)

	; Wait for 2 seconds.
	Sleep(2000)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
