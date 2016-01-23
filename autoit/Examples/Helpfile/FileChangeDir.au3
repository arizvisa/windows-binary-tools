#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Display the current working directory.
	MsgBox($MB_SYSTEMMODAL, "", "The current working directory: " & @CRLF & @WorkingDir)

	; Set the working directory @WorkingDir to the @WindowsDir directory. This is normally C:\Windows.
	FileChangeDir(@WindowsDir)

	; Display the working directory after setting it to the windows directory.
	MsgBox($MB_SYSTEMMODAL, "", "The current working directory: " & @CRLF & @WorkingDir)
EndFunc   ;==>Example
