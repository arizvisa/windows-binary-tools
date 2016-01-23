#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Delete 2 rows (1 and 2) on worksheet 3
; *****************************************************************************
$oWorkbook.Worksheets(3).Activate
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example 2", "Deleting rows 1 and 2 on worksheet 3.")
_Excel_RangeDelete($oWorkbook.Worksheets(3), "1:2")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example 2", "Error deleting rows." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
