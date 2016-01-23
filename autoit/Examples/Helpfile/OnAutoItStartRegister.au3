; Register Example() and SomeFunc() to be called when AutoIt starts.

#OnAutoItStartRegister "Example"
#OnAutoItStartRegister "SomeFunc"

Sleep(1000)

Func Example()
	MsgBox(4096, "", "Function 'Example' is called first.")
EndFunc   ;==>Example

Func SomeFunc()
	MsgBox(4096, "", "Function 'SomeFunc' is called second.")
EndFunc   ;==>SomeFunc
