#Include <Array.au3>
#include <MsgBoxConstants.au3>

Local $aArray_Base[2] = ["Org Item 0", "Org item 1"]
Local $aArray
Local $sFill = ""
For $i = 2 To 6
	$sFill &= $i & "|" ; Note variables added as number datatype here
Next
$sFill = StringTrimRight($sFill, 1)
MsgBox($MB_SYSTEMMODAL, "Delimited string to add", $sFill)

; Add items by delimited string
$aArray = $aArray_Base
_ArrayAdd($aArray, $sFill)
_ArrayDisplay($aArray, "Converted to string")
; But converted to string datatype when inserted
MsgBox($MB_SYSTEMMODAL, "Result", "Data:" & @TAB & $aArray[6] & @CRLF & "Datatype:" & @TAB & VarGetType($aArray[6]))

; Add items by delimited string
$aArray = $aArray_Base
; Now force datatype to Number
_ArrayAdd($aArray, $sFill, Default, Default, Default, $ARRAYFILL_FORCE_NUMBER)
_ArrayDisplay($aArray, "Forced to number")
; And datatype is forced to required type
MsgBox($MB_SYSTEMMODAL, "Result", "Data:" & @TAB & $aArray[6] & @CRLF & "Datatype:" & @TAB & VarGetType($aArray[6]))
