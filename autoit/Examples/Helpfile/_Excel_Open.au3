#include <Excel.au3>
#include <MsgBoxConstants.au3>

; *****************************************************************************
; Create application object or connect to an already running Excel instance
; *****************************************************************************
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Open Example 1", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Open Example 1", "Excel Application has been opened successfully." & @CRLF & @CRLF & "Will _Excel_Close close the application?: " & @extended)
