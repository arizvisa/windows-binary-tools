Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Wait for 2 seconds before calling the WinKill function.
	Sleep(2000)

	; Kill the window using the handle returned by WinWait.
	WinKill($hWnd, "")
EndFunc   ;==>Example
