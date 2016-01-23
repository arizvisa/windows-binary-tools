#include <Excel.au3>
#include <MsgBoxConstants.au3>

; ****************************************************************************
; Translate a column number to the Excel colunm letter
; ****************************************************************************
Local $iCol = 676
Local $sLetter = _Excel_ColumnToLetter($iCol)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToLetter Example 1", "Error converting number to letter." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToLetter Example 1", "Number: " & $iCol & " = Letter: " & $sLetter)
