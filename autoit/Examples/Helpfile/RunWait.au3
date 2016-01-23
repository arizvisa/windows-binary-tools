#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Run Notepad and wait for the Notepad process to close.
	Local $iReturn = RunWait("notepad.exe")

	; Display the return code of the Notepad process.
	MsgBox($MB_SYSTEMMODAL, "", "The return code from Notepad was: " & $iReturn)
EndFunc   ;==>Example
