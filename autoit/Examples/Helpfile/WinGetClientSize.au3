#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Retrieve the client area of the Notepad window using the handle returned by WinWait.
	Local $aClientSize = WinGetClientSize($hWnd)

	; Display the height and width of the client area.
	MsgBox($MB_SYSTEMMODAL, "", "Width: " & $aClientSize[0] & @CRLF & "Height: " & $aClientSize[1])

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
