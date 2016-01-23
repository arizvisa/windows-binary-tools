#include <File.au3>

; Example: Write to line 3 of c:\temp\test.txt REPLACING line 3
_FileWriteToLine("c:\temp\test.txt", 3, "my replacement for line 3", True)
; Example: Write to line 3 of c:\temp\test.txt NOT REPLACING line 3
_FileWriteToLine("c:\temp\test.txt", 3, "my insertion", False)
