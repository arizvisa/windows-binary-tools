#include <Excel.au3>
#include <MsgBoxConstants.au3>

; ****************************************************************************
; Translate an Excel column letter to the colunm number
; ****************************************************************************
Local $sCol = "YZ"
Local $iNumber = _Excel_ColumnToNumber($sCol)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToNumber Example 1", "Error converting letter to number." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToNumber Example 1", "Letter: " & $sCol & " = Number: " & $iNumber)
