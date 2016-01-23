#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open(True, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeValidate Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookNew($oExcel)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeValidate Example", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Only values from a list defined in a cell range (column 'D') are valid
; *****************************************************************************
; Write values to a range
Local $aValidation[] = ["10", "20", "30", "40", "50"]
_Excel_RangeWrite($oWorkbook, Default, $aValidation, "D1")
; Only values from the range are valid
_Excel_RangeValidate($oWorkbook, Default, "C:C", $xlValidateList, "=D:D")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeValidate Example 2", "Error setting range validation." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeValidate Example 2", "Validation against a list of values in cell range '=D:D' successfully set for colum 'C'.")
