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

; ****************************************************************************
; Translate an A1 range to a R1C1 range and vice versa
; ****************************************************************************
Local $sFormula = "C4:G12"
; Relative: A1 to R1C1
Local $sR1C1 = _Excel_ConvertFormula($oExcel, $sFormula, $xlA1, $xlR1C1, $xlRelative)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Error converting formula to R1C1 style." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; R1C1 to A1
Local $sA1 = _Excel_ConvertFormula($oExcel, $sR1C1, $xlR1C1, $xlA1, $xlRelative)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Error converting formula to A1 style." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Show result
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Conversion type: Relative" & @CRLF & "  A1 to a R1C1 style: " & $sFormula & " to " & $sR1C1 & @CRLF & "  R1C1 to A1 style: " & $sR1C1 & " to " & $sA1)

; Absolute: A1 to R1C1
$sR1C1 = _Excel_ConvertFormula($oExcel, $sFormula, $xlA1, $xlR1C1, $xlAbsolute)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Error converting formula to R1C1 style." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; R1C1 to A1
$sA1 = _Excel_ConvertFormula($oExcel, $sR1C1, $xlR1C1, $xlA1, $xlAbsolute)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Error converting formula to A1 style." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Show result
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ConvertFormula Example 1", "Conversion type: Absolute" & @CRLF & "  A1 to a R1C1 style: " & $sFormula & " to " & $sR1C1 & @CRLF & "  R1C1 to A1 style: " & $sR1C1 & " to " & $sA1)
