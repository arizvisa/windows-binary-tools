#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open Workbook 1
Local $oWorkbook1 = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Copy 2 rows (1 and 2) from worksheet 2 to the clipboard
; *****************************************************************************
_Excel_RangeCopyPaste($oWorkbook1.Worksheets(2), "1:2")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example 3", "Error copying rows." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example 3", "Rows 1+2 successfully copied from worksheet 2 to the clipboard.")

; *****************************************************************************
; Paste the range written by Example 3 from the clipboard to the active worksheet.
; Only values without formatting will be pasted.
; *****************************************************************************
_Excel_RangeCopyPaste($oWorkbook1.Activesheet, Default, "1:1", Default, $xlPasteValues)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example 4", "Error copying rows." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeCopy Example 4", "2 Rows successfully pasted from the clipboard to row 1.")
