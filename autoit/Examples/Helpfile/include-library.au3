; Use #include-once when creating UDFs so the file isn't included multiple times
; if you call the same UDF in multiple files.

#include-once
#include <MsgBoxConstants.au3>

; Rename this file as IncludeFunc.au3 and place next to the main script.
; Then add #include "IncludeFunc.au3" at the top of the script.

Func IncludeFunc()
	MsgBox($MB_SYSTEMMODAL, "", "This is an example of including a file.")
EndFunc   ;==>IncludeFunc
