#include <Array.au3>

Local $aArray[4][3]
For $i = 0 To 3
	For $j = 0 To 2
		$aArray[$i][$j] = $i & $j
	Next
Next
_ArrayDisplay($aArray, "Original")

_ArrayColDelete($aArray, 2)
_ArrayDisplay($aArray, "Col 2 Deleted")

; Copy 2 col array
Local $aArray_2Col = $aArray

; Default 1 column left as 2D array
_ArrayColDelete($aArray, 0)
_ArrayDisplay($aArray, "Col 0 del - 2D array")

; Convert 1 column array to 1D
_ArrayColDelete($aArray_2Col, 0, True)
_ArrayDisplay($aArray_2Col, "Col 0 del - 1D array")
