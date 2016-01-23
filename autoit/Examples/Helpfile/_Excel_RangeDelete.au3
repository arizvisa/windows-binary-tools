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
; Delete a range with 3 rows and 2 columns on the active worksheet
; and shift the cells up.
; *****************************************************************************
Local $sRange = "J5:K7"
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example 1", "Deleting cells " & $sRange & ".")
_Excel_RangeDelete($oWorkbook.ActiveSheet, $sRange, $xlShiftUp)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeDelete Example 1", "Error deleting cells." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
