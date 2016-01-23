#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Attach to the first Workbook where the file name matches
; *****************************************************************************
Local $sWorkbook = "_Excel1.xls"
$oWorkbook = _Excel_BookAttach($sWorkbook, "filename")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example 2", "Error attaching to '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example 2", "Search by 'filename':" & @CRLF & @CRLF & "Successfully attached to Workbook '" & $sWorkbook & "'." & @CRLF & @CRLF & "Value of cell A2: " & $oWorkbook.Activesheet.Range("A2").Value)
