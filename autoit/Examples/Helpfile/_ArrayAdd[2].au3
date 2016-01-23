#include <Array.au3>

Local $aArray, $sFill

Local $aArray_Base[2][2] = [["Item 0 - 0", "Item 0 - 1"], ["Item 1 - 0", "Item 1 - 1"]]
_ArrayDisplay($aArray_Base, "2D - Base array")

; Add item delimited string
$aArray = $aArray_Base
$sFill = "New Item 2 - 0|New Item 2 - 1"
_ArrayAdd($aArray, $sFill)
_ArrayDisplay($aArray, "2D - Item delimited")

; Add row delimited string - load in col 1
$aArray = $aArray_Base
$sFill = "New Item 2 - 1" & @CRLF & "New Item 3 - 1"
_ArrayAdd($aArray, $sFill, 1)
_ArrayDisplay($aArray, "2D - Row Delimited")

; Add item & row delimited string
$aArray = $aArray_Base
$sFill = "New Item 2 - 0|New Item 2 - 1" & @CRLF & "New Item 3 - 0|New Item 3 - 1"
_ArrayAdd($aArray, $sFill)
_ArrayDisplay($aArray, "2D - Item & row Delimited")

; Add a 2D array
$aArray = $aArray_Base
Local $aFill[2][2] = [["New Item 2 - 1", "New Item 2 - 2"], ["New Item 3 - 1", "New Item 3 - 2"]]
_ArrayAdd($aArray, $aFill)
_ArrayDisplay($aArray, "2D - 2D Array")

; Add a 2D array - Single item/column - load in col 1
$aArray = $aArray_Base
Local $aFill[2][1] = [["New Item 2 - 1"], ["New Item 3 - 1"]]
_ArrayAdd($aArray, $aFill, 1)
_ArrayDisplay($aArray, "2D - 2D Array")
