#include <Array.au3>

Local $aArray[5] = [0, 1, 2, 3, 4]

_ArrayDisplay($aArray, "Original")
_ArrayDelete($aArray, 2)
_ArrayDisplay($aArray, "Element 2 deleted")

Local $aArray_Base[25][4]
For $i = 0 To 24
	For $j = 0 To 3
		$aArray_Base[$i][$j] = $i & "-" & $j
	Next
Next

; Single row
$aArray = $aArray_Base
_ArrayDisplay($aArray, "BEFORE deletion")
_ArrayDelete($aArray, 7)
_ArrayDisplay($aArray, "SINGLE ROW deleted")

; Range string
$aArray = $aArray_Base
Local $sRange = "0;11-15;24"
_ArrayDisplay($aArray, "BEFORE deletion")
_ArrayDelete($aArray, $sRange)
ConsoleWrite(" " & @error & @CRLF)
_ArrayDisplay($aArray, "RANGE STRING deleted")

; 1D array
$aArray = $aArray_Base
Local $aDel[4] = [3, 5, 11, 13]
_ArrayDisplay($aArray, "BEFORE deletion")
_ArrayDelete($aArray, $aDel)
_ArrayDisplay($aArray, "RANGE ARRAY deleted")
