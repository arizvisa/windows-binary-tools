#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iEncoding = FileGetEncoding(@ScriptFullPath) ; Retrieve the file encoding of the current script.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error: Could not obtain the file encoding.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "FileGetEncoding: The value returned was: " & $iEncoding) ; The value returned for this example should be 0 or $FO_ANSI.
	EndIf
EndFunc   ;==>Example
