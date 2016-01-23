#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Add a link to cells A1:C1
; *****************************************************************************
_Excel_RangeLinkAddRemove($oWorkbook, $oWorkbook.Activesheet, "A1:C1", "http://www.autoitscript.com", Default, "AutoIt Homepage")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 1", "Error setting hyperlink." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 1", "Links set to cells 'A1:C3'.")

; *****************************************************************************
; Remove the links from cells A1:C1
; *****************************************************************************
_Excel_RangeLinkAddRemove($oWorkbook, $oWorkbook.Activesheet, "A1:C1", "")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 2", "Error setting hyperlink." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeLinkAddRemove Example 2", "Links removed from cells 'A1:C3'.")
