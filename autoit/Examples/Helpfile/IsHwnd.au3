#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad
	Run("notepad.exe")

	; Wait 10 seconds for the Notepad window to appear.
	Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)

	; Test if the window was found and display the results.
	If IsHWnd($hWnd) Then
		MsgBox($MB_SYSTEMMODAL, "", "It's a valid HWND")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "It's not a valid HWND")
	EndIf
EndFunc   ;==>Example
