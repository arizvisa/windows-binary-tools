#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Read the current script file into an array using the filepath.
	Local $aArray = FileReadToArray(@ScriptFullPath)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "There was an error reading the file. @error: " & @error) ; An error occurred reading the current script file.
	Else
		For $i = 0 To UBound($aArray) - 1 ; Loop through the array.
			MsgBox($MB_SYSTEMMODAL, "", $aArray[$i]) ; Display the contents of the array.
		Next
	EndIf
EndFunc   ;==>Example
