#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Find all occurrences of string "=C10*10" in the formulas, exact match
; *****************************************************************************
Local $aResult = _Excel_RangeFind($oWorkbook, "=C10*10", "A1:G15", $xlFormulas, $xlWhole)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 2", "Error searching the range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 2", "Find all occurrences of string '=C10*10' in the formulas, exact match." & @CRLF & "Data successfully searched.")
_ArrayDisplay($aResult, "Excel UDF: _Excel_RangeFind Example 2", "", 0, "|", "Sheet|Name|Cell|Value|Formula|Comment")
