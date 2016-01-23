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
; Find all occurrences of value "37000" (partial match)
; *****************************************************************************
Local $aResult = _Excel_RangeFind($oWorkbook, "37000")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 1", "Error searching the range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 1", "Find all occurrences of value '37000' (partial match)." & @CRLF & "Data successfully searched.")
_ArrayDisplay($aResult, "Excel UDF: _Excel_RangeFind Example 1", "", 0, "|", "Sheet|Name|Cell|Value|Formula|Comment")
