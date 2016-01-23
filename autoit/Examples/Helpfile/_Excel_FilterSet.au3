#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls", True)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example", "Press Enter to set the first filter!")

; *****************************************************************************
; Filter the complete active worksheet on column 1.
; Only show rows with content >20 and <40 in the specified column.
; *****************************************************************************
_Excel_FilterSet($oWorkbook, Default, "A1:E30", 1, ">20", 1, "<40")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "Filtered on column 'A'. Only show rows with values >20 and <40.")

; *****************************************************************************
; Add a filter to column 2.
; Only show rows with content <310 in the specified column.
; *****************************************************************************
_Excel_FilterSet($oWorkbook, Default, Default, 2, "<310")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 2", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "Added filter on column 'B'. Only show rows with values <310.")

; *****************************************************************************
; Remove the filter from column 1.
; *****************************************************************************
_Excel_FilterSet($oWorkbook, Default, Default, 1)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 3", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "Removed filter from column 'A'.")

; *****************************************************************************
; Only display selected values (20, 40 and 60) of column 2.
; *****************************************************************************
Local $aShow[] = ["20", "40", "60"]
_Excel_FilterSet($oWorkbook, Default, Default, 2, $aShow, $xlFilterValues)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 4", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "Set filter in column 'B' to only display selected values (20, 40 and 60).")

; *****************************************************************************
; Remove all filters.
; *****************************************************************************
_Excel_FilterSet($oWorkbook, Default, Default, 0)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 5", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 1", "All filters removed.")
