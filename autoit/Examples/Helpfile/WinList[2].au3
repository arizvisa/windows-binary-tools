#include <Array.au3>

Example()

Func Example()
	; Retrieve a list of window handles using a regular expression. The regular expression looks for titles that contain the word SciTE or Internet Explorer.
	Local $aWinList = WinList("[REGEXPTITLE:(?i)(.*SciTE.*|.*Internet Explorer.*)]")
	_ArrayDisplay($aWinList)
EndFunc   ;==>Example
