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
; Find all values with "Story" at the end using wildcards and exact match
; *****************************************************************************
Local $aResult = _Excel_RangeFind($oWorkbook, "* Story", Default, Default, $xlWhole)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 4", "Error searching the range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeFind Example 4", "Find all values with 'Story' at the end using wildcards and exact match." & @CRLF & "Data successfully searched.")
_ArrayDisplay($aResult, "Excel UDF: _Excel_RangeFind Example 4", "", 0, "|", "Sheet|Name|Cell|Value|Formula|Comment")
