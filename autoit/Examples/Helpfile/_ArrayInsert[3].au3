#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $aArray_Base[2][2] = [["Org Item 0 - 0", "Org Item 0 - 1"], ["Org Item 1 - 0", "Org Item 1 - 1"]]
Local $aArray
Local $sFill = 1 & @CRLF & 2 ; Note added as number datatype here
MsgBox($MB_SYSTEMMODAL, "Delimited string to add", $sFill)

; Add items by delimited string
$aArray = $aArray_Base
 _ArrayInsert($aArray, "0;1", $sFill)
_ArrayDisplay($aArray, "Converted to string")
; But converted to string datatype here
MsgBox($MB_SYSTEMMODAL, "Result", "Data:" & @TAB & $aArray[2][0] & @CRLF & "Datatype:" & @TAB & VarGetType($aArray[2][0]))

; Add items by delimited string
$aArray = $aArray_Base
; Now force datatype to be retained
Local $hDataType = Number
 _ArrayInsert($aArray, "0;1", $sFill, Default, Default, Default, $ARRAYFILL_FORCE_NUMBER)
_ArrayDisplay($aArray, "Forced to number")
; And datatype is retained
MsgBox($MB_SYSTEMMODAL, "Result", "Data:" & @TAB & $aArray[2][0] & @CRLF & "Datatype:" & @TAB & VarGetType($aArray[2][0]))
