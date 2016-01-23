Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the position as well as the height and width of the Notepad window. We will use this when we have to move the window back to the original position.
	Local $aPos = WinGetPos($hWnd)

	; Move the Notepad to the x, y position of 0, 0 and set the height and width at 200, 200.
	WinMove($hWnd, "", 0, 0, 200, 200)

	; Wait for 2 seconds to display the new position of the Notepad window.
	Sleep(2000)

	; Move the Notepad window back to the original position by using the array returned by WinGetPos.
	WinMove($hWnd, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])

	; Wait for 2 seconds to display the original position of the Notepad window.
	Sleep(2000)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
