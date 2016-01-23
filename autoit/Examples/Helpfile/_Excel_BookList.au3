#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create two instances of Excel and open two workbooks
Local $sWorkbook1 = @ScriptDir & "\Extras\_Excel1.xls", $sWorkbook2 = @ScriptDir & "\Extras\_Excel2.xls"
Local $oExcel1 = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookList Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook1 = _Excel_BookOpen($oExcel1, $sWorkbook1)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookList Example", "Error opening workbook '" & $sWorkbook1 & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel1)
	Exit
EndIf
Local $oExcel2 = _Excel_Open(Default, Default, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookList Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook2 = _Excel_BookOpen($oExcel2, $sWorkbook2)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookList Example", "Error opening workbook '" & $sWorkbook1 & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel1)
	_Excel_Close($oExcel2)
	Exit
EndIf

; *****************************************************************************
; Display a list of all workbooks of all Excel instances
; *****************************************************************************
Local $aWorkBooks = _Excel_BookList()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookList Example 2", "Error listing Workbooks." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
_ArrayDisplay($aWorkBooks, "Excel UDF: _Excel_BookList Example 2 - List of workbooks of all instances")
