#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an new workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookNew($oExcel)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Translate an formula from A1 to R1C1 style and use a relative reference
; *****************************************************************************
Local $sFormula = "=SUM(C4:G12)", $sReference = "B2"
Local $sConverted = _Excel_ConvertFormula($oExcel, $sFormula, $xlA1, $xlR1C1, $xlRelative, $oExcel.Range($sReference))
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 2", "Error converting formula." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 2", "Translate an A1 formula to a R1C1 and use " & $sReference & " as relative reference:" & @CRLF & $sFormula & " to " & $sConverted)
