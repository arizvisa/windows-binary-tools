#include <Array.au3>
#include <String.au3>

Example()

Func Example()
	; Create an array of all the values between "[" and "]".
	Local $aArray = _StringBetween("[18][20][3][5][500][60]", "[", "]")

	; Display the results in _ArrayDisplay.
	_ArrayDisplay($aArray, "Default Search")

	; Create an array of all the values between "|" and "|" - note $sStart and $sEnd are identical
	Local $sString = "-----|Both Modes|$STR_ENDISSTART only|Both Modes|-----"

	; Mode $STR_ENDISSTART - default - $sEnd is next $sStart
	$aArray = _StringBetween($sString, "|", "|")
	; Display the results in _ArrayDisplay.
	_ArrayDisplay($aArray, "$STR_ENDISSTART")

	; Mode $STR_ENDNOTSTART - $sEnd is not next $sStart
	$aArray = _StringBetween($sString, "|", "|", $STR_ENDNOTSTART)
	; Display the results in _ArrayDisplay.
	_ArrayDisplay($aArray, "$STR_ENDNOTSTART")
EndFunc   ;==>Example
