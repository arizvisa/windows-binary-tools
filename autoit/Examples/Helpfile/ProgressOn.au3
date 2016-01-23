Example()

Func Example()
	; Display a progress bar window.
	ProgressOn("Progress Meter", "Increments every second", "0%")

	; Update the progress value of the progress bar window every second.
	For $i = 10 To 100 Step 10
		Sleep(1000)
		ProgressSet($i, $i & "%")
	Next

	; Set the "subtext" and "maintext" of the progress bar window.
	ProgressSet(100, "Done", "Complete")
	Sleep(5000)

	; Close the progress window.
	ProgressOff()
EndFunc   ;==>Example
