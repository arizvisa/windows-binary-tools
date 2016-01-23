#include <Array.au3>

Local $aArray_Base[10][3]
For $i = 0 To 9
	For $j = 0 To 2
		$aArray_Base[$i][$j] = $i & " - " & $j
	Next
Next
_ArrayDisplay($aArray_Base, "2D - Original")

; Insert single item
Local $aArray = $aArray_Base
_ArrayInsert($aArray, 7, "Insert above 7-0")
_ArrayDisplay($aArray, "2D - Single item")

; Insert single item in defined column
$aArray = $aArray_Base
_ArrayInsert($aArray, 3, "Insert above 3-1", 1)
_ArrayDisplay($aArray, "2D - Defined column")

; Insert item delimited string - inserted as 1 row - other rows filled with ""
$aArray = $aArray_Base
Local $sFill = "Above 3-0|Above 3-1|Above 3-2"
_ArrayInsert($aArray, "3;5;9", $sFill)
_ArrayDisplay($aArray, "2D - Item delim string")

; Insert row delimited string using range array - inserted as 3 rows, other cols filled with ""
$aArray = $aArray_Base
Local $aRange[4] = [3, 3, 5, 9]
$sFill = "Above 3-2" & @CRLF & "Above 5-2" & @CRLF & "Above 9-2"
_ArrayInsert($aArray, $aRange, $sFill, 2) ; Insert in column 2
_ArrayDisplay($aArray, "2D - Item delim string")

; Insert item as row delimited string - inserted as 4 rows
$aArray = $aArray_Base
$sFill = "Above 3-0|3-1|3-2" & @CRLF & "Above 5a|5-1a|5-2a" & @CRLF & "Above 5b|5-1b|5-2b" & @CRLF & "Above 9|9-1|9-2"
_ArrayInsert($aArray, "3;5;5;9", $sFill)
_ArrayDisplay($aArray, "2D - Item & row delim string")

; Insert 2D array
$aArray = $aArray_Base
Local $aFill_1D[3][3] = [["Above 2", "2-1", "2-2"], ["Above 3", "3-1", "3-2"], ["Above 4", "4-1", "4-2"]]
_ArrayInsert($aArray, "2-4", $aFill_1D)
_ArrayDisplay($aArray, "2D - 2D Array")
