#include <Array.au3>

Local $aArray[3][2] = [[1, 2], [3, 4], [5, 6]]
_ArrayDisplay($aArray, "Original")
_ArrayTranspose($aArray)
_ArrayDisplay($aArray, "Transposed")

Local $aArray[5] = [1, 2, 3, 4, 5]
_ArrayDisplay($aArray, "Original 1D")
_ArrayTranspose($aArray)
_ArrayDisplay($aArray, "Transposed to 2D")
_ArrayTranspose($aArray)
_ArrayDisplay($aArray, "Re-transposed to 1D")
