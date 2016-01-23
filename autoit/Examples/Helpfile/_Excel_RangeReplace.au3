#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeReplace Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeReplace Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Replace content of cell A1 with another value
; *****************************************************************************
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeReplace Example 1", "Press OK to modify data in cell 'A1'.")
_Excel_RangeReplace($oWorkbook, Default, "A1", 1, 3.37)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeReplace Example 1", "Error replacing data the range." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeReplace Example 1", "Data successfully replaced in cell 'A1'.")
