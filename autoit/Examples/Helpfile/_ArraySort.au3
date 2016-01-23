; using a 1D array

#include <Array.au3>

Local $avArray[10] = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

_ArrayDisplay($avArray, "BEFORE _ArraySort()")
_ArraySort($avArray)
_ArrayDisplay($avArray, "AFTER QuickSort ascending")
_ArraySort($avArray, 1)
_ArrayDisplay($avArray, "AFTER QuickSort descending")
_ArraySort($avArray, 0, 3, 6)
_ArrayDisplay($avArray, "AFTER QuickSort from index 3 to 6")
_ArraySort($avArray, 0, 0, 0, 0, 1)
_ArrayDisplay($avArray, "AFTER DualPivotSort ascending")
