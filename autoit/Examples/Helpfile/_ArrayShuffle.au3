#include <Array.au3>

Local $aArray_Base[10] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
_ArrayDisplay($aArray_Base, "1D - Original", Default, 8)

Local $aArray = $aArray_Base
_ArrayShuffle($aArray)
_ArrayDisplay($aArray, "1D - Shuffled", Default, 8)

$aArray = $aArray_Base
_ArrayShuffle($aArray, 3, 8)
_ArrayDisplay($aArray, "1D - Shuffled - 3-8 ", Default, 8)

Local $aArray_Base[10][10]
For $i = 0 To 9
	For $j = 0 To 9
		$aArray_Base[$i][$j] = $i
	Next
Next
_ArrayDisplay($aArray_Base, "2D - Original", Default, 8)

$aArray = $aArray_Base
_ArrayShuffle($aArray)
_ArrayDisplay($aArray, "2D - Shuffled - All rows", Default, 8)

$aArray = $aArray_Base
_ArrayShuffle($aArray, 3, 8, 2)
_ArrayDisplay($aArray, "2D - Shuffled - Col 2, 3-8", Default, 8)
