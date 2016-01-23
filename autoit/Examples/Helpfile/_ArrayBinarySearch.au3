#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $iIndex

Local $aArray[5][2]
For $i = 0 To 4
	For $j = 0 To 1
		$aArray[$i][$j] = "#" & $i & $j
	Next
Next
_ArrayDisplay($aArray, "Array")

; Search col 0
$iIndex = _ArrayBinarySearch($aArray, "#10", 0, 0, 0)
MsgBox($MB_SYSTEMMODAL, "Index", $iIndex)

; Search col 1
$iIndex = _ArrayBinarySearch($aArray, "#31", 0, 0, 1)
MsgBox($MB_SYSTEMMODAL, "Index", $iIndex)
