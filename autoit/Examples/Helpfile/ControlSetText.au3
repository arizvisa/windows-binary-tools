#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Set the edit control in Notepad with some text. The handle returned by WinWait is used for the "title" parameter of ControlSetText.
	ControlSetText($hWnd, "", "Edit1", "This is some text")

	; Retrieve the text of the edit control in Notepad. The handle returned by WinWait is used for the "title" parameter of ControlGetText.
	Local $sText = ControlGetText($hWnd, "", "Edit1")

	; Display the text of the edit control.
	MsgBox($MB_SYSTEMMODAL, "", "The text in Edit1 is: " & $sText)

	; Close the Notepad window using the handle returned by WinWait.
	WinClose($hWnd)
EndFunc   ;==>Example
