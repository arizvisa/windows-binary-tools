#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $aArray_Base[2] = ["Org Item 0", "Org item 1"]
_ArrayDisplay($aArray_Base, "1D - Base array")

; Add a single item
Local $aArray = $aArray_Base
Local $sSingleFill = "New Item 2"
_ArrayAdd($aArray, $sSingleFill)
_ArrayDisplay($aArray, "1D - Single")

; Add a delimited string - each item adds new element
$aArray = $aArray_Base
Local $sFill = ""
For $i = 1 To 5
	$sFill &= "New Item " & $i + 1 & "|"
Next
$sFill = StringTrimRight($sFill, 1)
MsgBox($MB_SYSTEMMODAL, "Delimited string to add", $sFill)
_ArrayAdd($aArray, $sFill)
_ArrayDisplay($aArray, "1D - Delim string")

; Add a 1D array - each element adds new element
$aArray = $aArray_Base
Local $aFill[5]
For $i = 0 To 4
	$aFill[$i] = "New Item " & $i + 2
Next
_ArrayDisplay($aFill, "Array to add")
_ArrayAdd($aArray, $aFill)
_ArrayDisplay($aArray, "1D - 1D array")
