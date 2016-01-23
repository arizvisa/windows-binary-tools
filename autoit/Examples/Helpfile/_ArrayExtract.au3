#include <Array.au3>

Local $aArray[4][4]
For $i = 0 To 3
	For $j = 0 To 3
		$aArray[$i][$j] = $i & $j
	Next
Next
_ArrayDisplay($aArray, "Original")
Local $aExtract = _ArrayExtract($aArray, 1, 2, 2, 3)
_ArrayDisplay($aExtract, "Row 1-2 cols 2-3")
