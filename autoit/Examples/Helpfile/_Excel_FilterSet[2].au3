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
; Filter Column M by date. Show all dates in october of 2013 and 2014.
; 0-year, 1-month, 2-day, 3-hour, 4-minute, 5-second
; *****************************************************************************
Local $aShow[] = [1, "01/10/2013", 1, "01/10/2014"]
_Excel_FilterSet($oWorkbook, Default, Default, 13, Default, $xlFilterValues, $aShow)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 6", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 2", "Column 'M' filtered by date. Show all dates in October of 2013 and 2014.")

; *****************************************************************************
; Filter Column M by date. Show all dates of last year.
; *****************************************************************************
_Excel_FilterSet($oWorkbook, Default, Default, 13, $xlFilterLastYear, $xlFilterDynamic)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 7", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterSet Example 2", "Column 'M' filtered by date. Show all dates of last year.")
