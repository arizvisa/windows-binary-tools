#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Create a new workbook, write some data and close it without saving
; *****************************************************************************
; Create the new workbook
Local $oWorkbook = _Excel_BookNew($oExcel)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookClose Example 1", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Write something into cell A1
_Excel_RangeWrite($oWorkbook, Default, "Test", "A1")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookClose Example 1", "Error writing to cell 'A1'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox(64, "Excel UDF: _Excel_BookClose Example 1", "Click OK to close the workbook without saving.")
; Close the workbook without saving
_Excel_BookClose($oWorkbook, False)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookClose Example 1", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookClose Example 1", "Workbook has been successfully closed.")
