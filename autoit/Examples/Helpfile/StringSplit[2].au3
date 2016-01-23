#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	Local $sText = "This\nline\ncontains\nC-style breaks." ; Define a variable with a string of text.
	Local $aArray = StringSplit($sText, '\n', $STR_ENTIRESPLIT) ; Pass the variable to StringSplit and using the delimiter "\n".
	; Note that flag parameter is set to $STR_ENTIRESPLIT (1) as it would split at \ or n otherwise.
	#cs
		The array returned will contain the following values:
		$aArray[1] = "This"
		$aArray[2] = "line"
		...
		$aArray[4] = "C-style breaks."
	#ce

	For $i = 1 To $aArray[0] ; Loop through the array returned by StringSplit to display the individual values.
		MsgBox($MB_SYSTEMMODAL, "", "$aArray[" & $i & "] - " & $aArray[$i])
	Next
EndFunc   ;==>Example
