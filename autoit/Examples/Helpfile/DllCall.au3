; Calling the MessageBox API directly.
DllCall("user32.dll", "int", "MessageBox", _
		"hwnd", 0, _ ; Handle to the parent window
		"str", "Some text", _ ; The text of the message box
		"str", "Some title", _ ; The title of the message box
		"int", 0) ; Flags for the message box.
