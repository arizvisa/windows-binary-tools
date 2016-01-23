#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	Local $sText = "This\nline\ncontains\nC-style breaks." ; Define a variable with a string of text.

	; Pass the variable to StringSplit and using the delimiter "\n".
	; Note that flag parameter is set to $STR_ENTIRESPLIT (1) as it would split at \ or n otherwise.
	MsgBox($MB_SYSTEMMODAL, "", StringSplit($sText, '\n', $STR_ENTIRESPLIT)[2]) ; Directly access the array index by using array access on expression.
	#cs
		An internal temporary array is used to return a string that may contain one of the following values:
		$aArray[1] = "This"
		$aArray[2] = "line"
		...
		$aArray[4] = "C-style breaks."
	#ce
EndFunc   ;==>Example
