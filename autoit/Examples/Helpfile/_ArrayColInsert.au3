#include <Array.au3>

Local $aArray[4] = [0, 1, 2, 3]
_ArrayDisplay($aArray, "Original")

_ArrayColInsert($aArray, 0)
; Now a 2D array
_ArrayDisplay($aArray, "Col 0 inserted")

_ArrayColInsert($aArray, 1)
_ArrayDisplay($aArray, "Col 1 inserted")

_ArrayColInsert($aArray, 3)
_ArrayDisplay($aArray, "Col 3 inserted")
