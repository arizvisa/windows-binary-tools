#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox(16, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Create a new workbook, write some data and save it to @tempdir
; *****************************************************************************
; Create the new workbook
Local $oWorkbook = _Excel_BookNew($oExcel)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Write something into cell A1
_Excel_RangeWrite($oWorkbook, Default, "Test", "A1")
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Exit SetError(1, 0, 0)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error writing to cell 'A1'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Save the workbook to @tempdir as _Excel.xls (replacing existing file)
_Excel_BookSaveAs($oWorkbook, @TempDir & "\_Excel.xls", Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Write something into cell B1
_Excel_RangeWrite($oWorkbook, Default, "2nd Test", "B1")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error writing to cell 'A1'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Save changed workbook
_Excel_BookSave($oWorkbook)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookSave Example 1", "Workbook has been successfully saved as '" & @TempDir & "\_Excel.xls'.")
