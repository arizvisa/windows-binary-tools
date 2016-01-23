; using a 2D array

#include <Array.au3>

Local $avArray[5][3] = [ _
		[5, 20, 8], _
		[4, 32, 7], _
		[3, 16, 9], _
		[2, 35, 0], _
		[1, 19, 6]]

_ArrayDisplay($avArray, "$avArray BEFORE _ArraySort()")
_ArraySort($avArray, 0, 0, 0, 0)
_ArrayDisplay($avArray, "$avArray AFTER _ArraySort() ascending column 0")
_ArraySort($avArray, 0, 0, 0, 1)
_ArrayDisplay($avArray, "$avArray AFTER _ArraySort() ascending column 1")
_ArraySort($avArray, 0, 0, 0, 2)
_ArrayDisplay($avArray, "$avArray AFTER _ArraySort() ascending column 2")
