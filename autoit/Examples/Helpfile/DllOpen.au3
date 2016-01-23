Local $hDLL = DllOpen("user32.dll")
DllCall($hDLL, "int", "MessageBox", "hwnd", 0, "str", "Some text", "str", "Some title", "int", 0)
DllClose($hDLL)
