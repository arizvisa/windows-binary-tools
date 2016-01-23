#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $sWorkbook = @ScriptDir & "\Extras\_Excel1.xls"
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oExcel, $sWorkbook)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error opening workbook '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Attach to the first Workbook where the file path matches
; *****************************************************************************
$oWorkbook = _Excel_BookAttach($sWorkbook)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example 1", "Error attaching to '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example 1", "Search by 'filepath':" & @CRLF & @CRLF & "Successfully attached to Workbook '" & $sWorkbook & "'." & @CRLF & @CRLF & "Value of cell B3: " & $oWorkbook.Activesheet.Range("B3").Value)
