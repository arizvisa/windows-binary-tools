#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $aArray[6][4]
For $i = 0 To 5
	For $j = 0 To 3
		$aArray[$i][$j] = "#" & $i & $j
	Next
Next
_ArrayDisplay($aArray, "Looking for '#32'", Default, 8)

; Search by column (looking in col 2)
Local $iIndex = _ArraySearch($aArray, "#32", 0, 0, 0, 0, 1, 2)
MsgBox($MB_SYSTEMMODAL, "Found '#32'", "Column 2 on Row " & $iIndex)

; Search by row (looking in row 3)
$iIndex = _ArraySearch($aArray, "#32", 0, 0, 0, 0, 1, 3, True)
MsgBox($MB_SYSTEMMODAL, "Found '#32'", "Row 3 in Col " & $iIndex)
