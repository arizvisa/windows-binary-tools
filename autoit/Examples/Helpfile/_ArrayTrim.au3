#include <Array.au3>

Local $aArray[5] = ["ab", "bc", "cd", "de", "ef"]

_ArrayDisplay($aArray, "1D array")
_ArrayTrim($aArray, 1, 1, 1, 3)
_ArrayDisplay($aArray, "Trimmed right 1 char from items 1-3")

Local $aArray[4][4], $iChr
For $i = 0 To 3
	For $j = 0 To 3
		$iChr = Random(97, 121, 1)
		$aArray[$i][$j] = Chr($iChr) & Chr($iChr + 1)
	Next
Next
_ArrayDisplay($aArray, "2D array")
_ArrayTrim($aArray, 1, 0, 1, 2, 3)
_ArrayDisplay($aArray, "Trimmed left 1 char from col 2-3 in row 1-2")
