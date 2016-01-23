#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox(16, "Excel UDF: _Excel_BookOpenText Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Open a text file as fixed, all other parameters will be determined by Excel
; *****************************************************************************
Local $sTextFile = @ScriptDir & "\Extras\_Excel2.txt"
_Excel_BookOpenText($oExcel, $sTextFile, Default, $xlFixedWidth)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpenText Example 2", "Error opening '" & $sTextFile & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpenText Example 2", "Workbook '" & $sTextFile & "' has been opened successfully.")
