#include <MsgBoxConstants.au3>

If ProcessExists("SciTE.exe") = 0 Then
	MsgBox($MB_SYSTEMMODAL, "", "You will need SciTE.exe to be running for ConsoleWrite to display.")
EndIf

Example()

Func Example()
	; Register the function MyAdLibFunc() to be called every 250ms (default).
	AdlibRegister("MyAdLibFunc")

	; Sleep does not stop AdLib functions from running.
	Sleep(1000)

	; AdLib functions don't run while a blocking function is shown e.g. MsgBox, InputBox, WinWait, WinWaitClose etc.
	MsgBox($MB_SYSTEMMODAL, "", "No console message(s) will be shown whilst the messagebox is displayed.")

	; The AdLib function MyAdLibFunc() will start again.
	Sleep(2000)

	; Unregister the function MyAdLibFunc() from being called every 250ms.
	AdlibUnRegister("MyAdLibFunc")
EndFunc   ;==>Example

Func MyAdLibFunc()
	; Assign a static variable to hold the number of times the function is called.
	Local Static $iCount = 0
	$iCount += 1

	ConsoleWrite("MyAdLibFunc called " & $iCount & " time(s)" & @CRLF)
EndFunc   ;==>MyAdLibFunc
