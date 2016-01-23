; using an array returned by StringSplit()

#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $avArray = StringSplit("a,b,d,c,e,f,g,h,i", ",")

; sort the array to be able to do a binary search
_ArraySort($avArray, 0, 1) ; start at index 1 to skip $avArray[0]

; display sorted array
_ArrayDisplay($avArray, "$avArray AFTER _ArraySort()")

; start at index 1 to skip $avArray[0]
Local $iKeyIndex = _ArrayBinarySearch($avArray, "c", 1)
If Not @error Then
	MsgBox($MB_SYSTEMMODAL, 'Entry found', ' Index: ' & $iKeyIndex)
Else
	MsgBox($MB_SYSTEMMODAL, 'Entry Not found', ' Error: ' & @error)
EndIf
