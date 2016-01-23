#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls", True)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; Set two filters
_Excel_FilterSet($oWorkbook, Default, "A:E", 3, "<610")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $aShow[] = ["20", "40", "60"]
_Excel_FilterSet($oWorkbook, Default, "A:E", 2, $aShow, $xlFilterValues)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example", "Filters set:" & @CRLF & "  Column B: values = 20, 40 or 60." & @CRLF & "  Column C: values <610.")

; *****************************************************************************
; Display information about the filters on the active worksheet.
; *****************************************************************************
Local $aFilters = _Excel_FilterGet($oWorkbook)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_FilterGet Example 1", "Error filtering data." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
_ArrayDisplay($aFilters, "Excel UDF: _Excel_FilterGet Example 1", Default, Default, Default, "Filter on|#areas|Criteria1|Criteria2|Operator|Range|#Records")
