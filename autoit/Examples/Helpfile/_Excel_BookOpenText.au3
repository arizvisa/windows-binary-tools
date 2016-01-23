#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox(16, "Excel UDF: _Excel_BookOpenText Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Open a text file as delimited, separator = |, pass fieldinfo and set
; DecimalSeparator and ThousandsSeparator.
; *****************************************************************************
Local $sTextFile = @ScriptDir & "\Extras\_Excel1.txt"
Local $aField1[2] = [1, $xlTextFormat]
Local $aField2[2] = [2, $xlTextFormat]
Local $aField3[2] = [3, $xlGeneralFormat]
Local $aField4[2] = [4, $xlDMYFormat]
Local $aField5[2] = [5, $xlTextFormat]
Local $aFieldInfo[5] = [$aField1, $aField2, $aField3, $aField4, $aField5]
_Excel_BookOpenText($oExcel, $sTextFile, Default, $xlDelimited, Default, True, "|", $aFieldInfo, ",", ".")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpenText Example 1", "Error opening '" & $sTextFile & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpenText Example 1", "Workbook '" & $sTextFile & "' has been opened successfully.")
