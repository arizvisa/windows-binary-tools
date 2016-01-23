#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls", True)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Insert an index sheet with links to all other sheets.
; Handles Sheet names with spaces correctly.
; *****************************************************************************
Local $oSheet = _Excel_SheetAdd($oWorkbook, 1, True, 1, "Index")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 3", "Error adding sheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
$oSheet.Range("A1").Value = "Index"
Local $iRow = 2
For $iSheet = 2 To $oWorkbook.Sheets.Count
	$oSheet.Cells($iRow, 1).Value = $iRow - 1
	$oSheet.Cells($iRow, 2).Value = $oWorkbook.Worksheets($iRow).Name
	_Excel_RangeLinkAddRemove($oWorkbook, $oSheet, $oSheet.Cells($iRow, 2), $oWorkbook.Fullname, "'" & $oSheet.Cells($iRow, 2).Value & "'!A1")
	$iRow = $iRow + 1
Next
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 3", "Index Sheet inserted as sheet 1.")
