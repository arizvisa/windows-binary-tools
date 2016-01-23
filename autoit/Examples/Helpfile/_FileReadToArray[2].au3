#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Define a variable to pass to _FileReadToArray.
	Local $aArray = 0

	; Read the current script file into an array using the variable defined previously.
	; $iFlag is specified as 0 in which the array count will not be defined. Use UBound() to find the size of the array.
	If Not _FileReadToArray(@ScriptFullPath, $aArray, 0) Then
		MsgBox($MB_SYSTEMMODAL, "", "There was an error reading the file. @error: " & @error) ; An error occurred reading the current script file.
	EndIf

	; Display the array in _ArrayDisplay.
	_ArrayDisplay($aArray)
EndFunc   ;==>Example
